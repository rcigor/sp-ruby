require 'spec_helper'
require 'web_traffic_analyser/log_reader'

RSpec.describe WebTrafficAnalyser::LogReader do
  let(:filename)   { "spec/lib/web_traffic_analyser/samples/example.log" }
  let(:log_reader) { described_class.new }

  context '#entries_from_file' do
    it 'reads all lines from file' do
      expect(log_reader.entries_from_file(filename).size).to eq(2)
    end

    it 'converts log lines into log entries' do
      entries = log_reader.entries_from_file(filename)

      expect(entries.first.uri)
        .to eq("/help")

      expect(entries.first.ip_address)
        .to eq("10.0.0.1")
    end
  end
end
