require 'spec_helper'
require 'log_analyser/log_entry'

RSpec.describe LogAnalyser::LogEntry do
  let(:log_entry) do
    described_class.new(
      uri: "/help_page",
      ip_address: "192.168.1.19"
    )
  end

  it 'records uri' do
    expect(log_entry.uri).to eq("/help_page")
  end

  it 'records requester IP address' do
    expect(log_entry.ip_address).to eq("192.168.1.19")
  end
end
