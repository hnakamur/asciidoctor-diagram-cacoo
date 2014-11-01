require 'json'
require 'time'
require 'asciidoctor-diagram/extensions'
require 'nokogiri'

module Asciidoctor
  module Diagram
    # @private
    module Cacoo
      def self.get_diagram_metadata(diagram_id, api_key)
        # NOTE: See API document at https://cacoo.com/lang/en/api and
        # https://cacoo.com/lang/en/api_image
        unless @diagrams
          diagrams = JSON.parse(get("/api/v1/diagrams.json?apiKey=#{api_key}"))
          @diagrams = diagrams['result'].each_with_object({}) { |d, h| h[d['diagramId']] = d }
        end

        @diagrams[diagram_id]
      end

      def self.get_diagram(diagram_id, api_key)
        # NOTE: See API document at https://cacoo.com/lang/en/api and
        # https://cacoo.com/lang/en/api_image
        get("/api/v1/diagrams/#{diagram_id}.png?apiKey=#{api_key}")
      end

      def self.get_diagram_contents(diagram_id, api_key)
        # NOTE: See API document at https://cacoo.com/lang/en/api and
        # https://cacoo.com/lang/en/api_diagram_contents
        get("/api/v1/diagrams/#{diagram_id}/contents.xml?returnValues=textStyle,shapeStyle,uid,position,point&apiKey=#{api_key}")
      end

      def self.save_diagram_contents(filename, contents, indent)
        doc = Nokogiri.XML(contents)
        File.open(filename, 'w') do |f|
          f.write doc.to_xml(indent: indent)
        end
      end

      def self.get(url)
        https = Net::HTTP.new('cacoo.com', 443)
        https.use_ssl = true
        https.start do
          response = https.get(url)
          raise "Cacoo response status code was #{response.code}" if response.code != '200'
          response.body
        end
      end

      def self.included(mod)
        mod.register_format(:png, :image) do |c, p|
          if c.options[:does_download_contents]
            contents = Cacoo.get_diagram_contents(c.diagram_id, c.api_key)
            Cacoo.save_diagram_contents("#{c.image_name}-contents.xml", contents, c.options[:contents_xml_indent])
          end
          Cacoo.get_diagram(c.diagram_id, c.api_key)
        end
      end

      class Source < Extensions::BasicSource
        attr_accessor :diagram_id
        attr_accessor :api_key
        attr_accessor :options

        def initialize(diagram_id, api_key, options)
          @diagram_id = diagram_id
          @api_key = api_key
          @options = options
        end

        def image_name
          "cacoo-#{diagram_id}"
        end

        def code
          diagram_id
        end

        def should_process?(image_file, image_metadata)
          Time.rfc2822(cacoo_metadata['updated']) < Time.rfc2822(image_metadata['updated'])
        end

        def create_image_metadata
          { 'updated' => cacoo_metadata['updated'] }
        end

        def cacoo_metadata
          Cacoo.get_diagram_metadata(diagram_id, api_key)
        end
      end
    end

    class CacooBlockProcessor < Extensions::DiagramBlockProcessor
      include Cacoo

      def create_source(parent, reader, attributes)
        api_key = ENV['CACOO_API_KEY'] || parent.document.attributes['cacoo_api_key']
        raise "Please specify your Cacoo API key using the CACOO_API_KEY environment variable or cacoo_api_key document attribute" unless api_key
        does_download_contents = parent.document.attributes['cacoo_does_download_contents'] || false
        contents_xml_indent = (parent.document.attributes['cacoo_contents_xml_indent'] || '2').to_i
        options = {
          does_download_contents: does_download_contents,
          contents_xml_indent: contents_xml_indent
        }
        Cacoo::Source.new(reader.read.strip, api_key, options)
      end
    end

    class CacooBlockMacroProcessor < Extensions::DiagramBlockMacroProcessor
      include Cacoo

      def create_source(parent, target, attributes)
        api_key = ENV['CACOO_API_KEY'] || parent.document.attributes['cacoo_api_key']
        raise "Please specify your Cacoo API key using the CACOO_API_KEY environment variable or cacoo_api_key document attribute" unless api_key
        does_download_contents = parent.document.attributes['cacoo_does_download_contents'] || false
        contents_xml_indent = (parent.document.attributes['cacoo_contents_xml_indent'] || '2').to_i
        options = {
          does_download_contents: does_download_contents,
          contents_xml_indent: contents_xml_indent
        }
        Cacoo::Source.new(target.strip, api_key, options)
      end
    end
  end
end
