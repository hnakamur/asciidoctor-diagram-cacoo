require "asciidoctor-diagram-cacoo/version"
require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  require_relative 'asciidoctor-diagram-cacoo/extension'
  block Asciidoctor::Diagram::CacooBlock, :cacoo
  block_macro Asciidoctor::Diagram::CacooBlockMacro, :cacoo
end
