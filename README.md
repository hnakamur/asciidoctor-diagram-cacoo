# Asciidoctor::Diagram::Cacoo

A ruby gem for adding support for [Cacoo](https://cacoo.com) to [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram).

## Installation

Add this line to your application's Gemfile:

    gem 'asciidoctor-diagram-cacoo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asciidoctor-diagram-cacoo

If you enable downloading contents.xml for cacoo diagrams, you also need to install [Nokogiri](http://www.nokogiri.org/)

    $ gem install nokogiri

## Usage

You must have an account of [Cacoo](https://cacoo.com/).
You need to create an Caoo API Key at [Cacoo API key config page](https://cacoo.com/profile/api)
and set it to the environment variable `CACOO_API_KEY`.

If you use bash or zsh, you can set it like the following:

```
export CACOO_API_KEY=_Your_Cacoo_API_key_here_
```


When you would like to add a diagram on Cacoo, you need the diagram ID.
For example, if your diagram's URL is https://cacoo.com/diagrams/f0MLos8tgXXxaTB,
your diagram ID is f0MLos8tgXXxaTBv.

You can add a diagram to your application, like the following example:

```
acoo::f0MLos8tgXXxaTBv["png", alt="alt text"]
```

### Complete example

sample.adoc

```
= asciidoctor-diagram-cacoo-example

:cacoo_does_download_contents: true
:cacoo_contents_xml_indent: 0

.DiagramBlockProcessor class diagram
cacoo::f0MLos8tgXXxaTBv["png", alt="DiagramBlockProcessor class"]

.Source class diagram
cacoo::Vsw9cGkj8bJjEBr6["png", alt="Source class"]
```

Optional asciidoc document attributes

* cacoo_does_download_contents: true|false. Enable downlaoding contents.xml for cacoo diagrams. This is not needed to generate documents. However it is useful to see differences in diagrams if you put these contents.xml in version control system like git. Filename will be "cacoo-#{diagram_id}-contents.xml"
* cacoo_contents_xml_indent: 0|2|4|0. Number of spaces for indent of contents.xml.


You can load asciidoctor-diagram and asciidoctor-diagram-cacoo (this gem) with `-r` option
of asciidoctor like below:

```
$ asciidoctor -r asciidoctor-diagram -r asciidoctor-diagram-cacoo sample.adoc
```

For a complete example, see https://github.com/hnakamur/asciidoctor-diagram-cacoo-example

## Credits

[asciidoctor-diagram-cacoo/extension.rb]( https://github.com/hnakamur/asciidoctor-diagram-cacoo/blob/master/lib/asciidoctor-diagram-cacoo/extension.rb ) is based on https://gist.github.com/pepijnve/2d4059db5d827462b5cd by [pepijnve (Pepijn Van Eeckhoudt)]( https://github.com/pepijnve ).

Thanks!

## Contributing

1. Fork it ( https://github.com/hnakamur/asciidoctor-diagram-cacoo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
