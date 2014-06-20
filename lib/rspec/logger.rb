require "rspec/logger/version"
require 'benchmark'

module RSpec
  class Logger
    attr_reader :example

    def initialize(example)
      @example = example
    end

    def self.logger=(logger)
      @_logger = logger
    end

    def self.logger
      @_logger ||= defined?(::Rails) ? ::Rails.logger : Logger.new(STDERR)
    end

    def log
      self.class.logger.debug start_line + start_line_tail
      # ---------------------------
      @times = Benchmark.measure do
        example.run
      end
      # ---------------------------
      self.class.logger.debug finish_line + finish_line_tail
    end

    def start_string
      @@_start_string ||= "\n\n ====> Start for: %s :: %s, location: %s:%s <="
    end

    def finish_string
      @@_finish_string ||=  "\n ====> Finish example real time execution: %s <="
    end

    def width
      @@_width ||= Integer(`tput co`)
    end

    def start_line
      start = start_string % [describe, it, file, line]
    end

    def start_line_tail
      '=' * (width - start_line.gsub(/\e\[(\d+;*\d*)m/, '').length).abs + "= \n"
    end

    def finish_line
      finish = finish_string % [@times.real.to_s]
    end

    def finish_line_tail
      '=' * (width - finish_line.gsub(/\e\[(\d+;*\d*)m/, '').length).abs + "\n"
    end

    def describe
      s = example.metadata[:example_group][:description_args].flatten.join
    end

    def it
      s = example.metadata[:description_args].flatten.join
    end

    def file
      s = example.metadata[:file_path].to_s
    end

    def line
      s = example.metadata[:line_number].to_s
    end
  end
end

RSpec.configure do |config|
  config.around(:each) do |example|
    RSpec::Logger.new(example).log
  end
end
