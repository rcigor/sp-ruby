require 'web_traffic_analyser/log_entry'

module WebTrafficAnalyser
  class WebTrafficAnalyser
    def initialize(entries)
      @entries = entries
    end

    def most_visited
      pages_hits.sort_by_hits
    end

    def most_unique_page_views
      pages_hits.sort_by_unique_hits
    end

    private
    attr_reader :entries

    def pages_hits
      @pages_hits ||= PagesHits.new(entries)
    end

    class PagesHits
      def initialize(entries)
        @entries    = entries
      end

      def pages_hits
        @pages_hits ||= calculate_pages_hits
      end

      def sort_by_hits
        pages_hits.sort_by(&:hits).reverse
      end

      def sort_by_unique_hits
        pages_hits.sort_by(&:unique_hits).reverse
      end

      private
      attr_reader :entries

      def calculate_pages_hits
        pages_hits = []

        entries.each do |entry|
          page = pages_hits.detect{|ph| ph.page == entry.uri}

          if page.nil?
            pages_hits << PageHits.new(page: entry.uri, ip_address: entry.ip_address)
          else
            page.increment_hits(ip_address: entry.ip_address)
          end
        end

        pages_hits
      end
    end

    class PageHits
      def initialize(page: page, ip_address: ip_address)
        @page         = page
        @ip_addresses = [ip_address]
      end

      def increment_hits(ip_address)
        @ip_addresses << ip_address
      end

      def unique_hits
        @ip_addresses.uniq.count
      end

      def hits
        @ip_addresses.count
      end

      attr_reader :page
    end
  end
end
