require "asciidoctor/diagram/cacoo/version"
require 'asciidoctor/extensions'

#module Asciidoctor
#  module Diagram
#    module Cacoo
#      # Your code goes here...
#    end
#  end
#end

Asciidoctor::Extensions.register do
  require_relative 'cacoo/extension'
  block Asciidoctor::Diagram::CacooBlock, :cacoo
  block_macro Asciidoctor::Diagram::CacooBlockMacro, :cacoo
end
