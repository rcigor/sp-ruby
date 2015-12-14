require 'web_traffic_analyser/log_entry'

module WebTrafficAnalyser
  class LogReader
    def entries_from_file(filename)
      File.read(filename).split(/\n+/).map do |line|
        uri, ip_address = line.split(/\s+/)
        LogEntry.new(uri: uri, ip_address: ip_address)
      end
    end
  end
end
