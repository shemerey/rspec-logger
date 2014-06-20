require 'spec_helper'

describe RSpec::Logger do
  before(:all) do
    @logger = Logger.new(@log = StringIO.new)
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "#{msg}"
    end
    described_class.logger = @logger
  end

  describe 'test wrap for' do
    it 'silly log message' do
      @logger.info  'silly log message'
    end
  end

  after(:all) do
    @log.string
      .gsub!(/\={6,999}/, '==')   # replace tail
      .gsub!(/\n\n/, "\n")        # replace empty lines
      .gsub!(/0\.\d{,7}/, 'xxxx') # replace time benchmark

    @log.string.strip! # clean up new line chars

    expect(@log.string).to eq(
      "====> Start for: test wrap for :: silly log message, location: ./spec/rspec/logger_spec.rb:13 <== \n" +
      "silly log message\n " +
      "====> Finish example real time execution: xxxx <=="
    )
  end
end

