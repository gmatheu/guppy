module Guppy
  class Parser

    include Guppy::Utilities
    attr_accessor :parser

    def initialize(file_or_string)
      data = file_or_string.read if file_or_string.respond_to?(:read)
      @xml_doc = ::Nokogiri.XML(data)
      set_parser
    end

    def activities
      @activities ||= @parser.activities
    end

    def inspect
      parser.to_s
    end
    alias :to_s :inspect

    private

      def set_parser
        @parser = if @xml_doc.namespaces.values.include?(TCX_NS)
          Guppy::Parser::TCX.new(@xml_doc)
        elsif @xml_doc.namespaces.values.include?(PWX_NS)
          extend Guppy::Parser::PWX.new(@xml_doc)
        else
          raise UnsupportedFileType.new
        end
      end

  end
end
