module LogAnalyser
  class LogEntry
    def initialize(uri: uri, ip_address: ip_address)
      @uri        = uri
      @ip_address = ip_address
    end

    attr_reader :uri, :ip_address
  end
end
