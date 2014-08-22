require "asciidoctor-diagram-cacoo/version"
require 'asciidoctor/extensions'
require_relative 'version'

Asciidoctor::Extensions.register do
  require_relative 'asciidoctor-diagram-cacoo/extension'
  block Asciidoctor::Diagram::CacooBlockProcessor, :cacoo
  block_macro Asciidoctor::Diagram::CacooBlockMacroProcessor, :cacoo
end
