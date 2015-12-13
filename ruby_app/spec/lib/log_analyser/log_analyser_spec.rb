require 'spec_helper'
require 'log_analyser/log_analyser'

RSpec.describe LogAnalyser::LogAnalyser do
  let(:log_analyser) { described_class.new(log_entries) }
  let(:log_entries) do
    [
      LogAnalyser::LogEntry.new(uri: "/help",  ip_address: "10.0.0.1"),
      LogAnalyser::LogEntry.new(uri: "/help",  ip_address: "10.0.0.1"),
      LogAnalyser::LogEntry.new(uri: "/help",  ip_address: "10.0.0.2"),
      LogAnalyser::LogEntry.new(uri: "/help",  ip_address: "10.0.0.2"),
      LogAnalyser::LogEntry.new(uri: "/about", ip_address: "10.0.0.1"),
      LogAnalyser::LogEntry.new(uri: "/about", ip_address: "10.0.0.2"),
      LogAnalyser::LogEntry.new(uri: "/about", ip_address: "10.0.0.3"),
    ]
  end

  context '#most_visited' do
    it 'returns pages ordered by number of visits' do
      expect(log_analyser.most_visited.first.page)
        .to eq("/help")
    end

    it 'returns hits per page' do
      expect(log_analyser.most_visited.first.hits)
        .to eq(4)
    end
  end

  context '#most_unique_page_views' do
    it 'returns pages ordered by number of unique page views' do
      expect(log_analyser.most_unique_page_views.first.page)
        .to eq("/about")
    end

    it 'returns unique page views' do
      expect(log_analyser.most_unique_page_views.first.unique_hits)
        .to(eq(3))
    end
  end
end
