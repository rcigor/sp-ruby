require 'log_analyser/log_entry'

module LogAnalyser
  class LogAnalyser
    def initialize(entries)
      @entries = entries
    end

    def most_visited(number = 3)
      @pages_hits ||= pages_hits.sort_by_hits
      @pages_hits.first(number)
    end

    private
    attr_reader :entries

    def pages_hits
      PagesHits.new(entries)
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

      private
      attr_reader :entries

      def calculate_pages_hits
        pages_hits = []

        entries.each do |entry|
          page = pages_hits.detect{|ph| ph.page == entry.uri}

          if page.nil?
            pages_hits << PageHits.new(page: entry.uri)
          else
            page.increment_hits
          end
        end

        pages_hits
      end
    end

    class PageHits
      def initialize(page: page)
        @page = page
        @hits = 1
      end

      def increment_hits
        @hits += 1
      end

      attr_reader :hits, :page
    end
  end
end
