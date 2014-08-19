# Asciidoctor::Diagram::Cacoo

A ruby gem for adding support for [Cacoo](https://cacoo.com) to [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram).

## Installation

Add this line to your application's Gemfile:

    gem 'asciidoctor-diagram-cacoo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asciidoctor-diagram-cacoo

## Usage

You must have an account of https://cacoo.com/[Cacoo].
You need to create an Caoo API Key at https://cacoo.com/profile/api[Cacoo API key config page]
and set it to the environment variable `CACOO_API_KEY`.

If you use bash or zsh, you can set it like the following:

```
export CACOO_API_KEY=_Your_Cacoo_API_key_here_
```


When you would like to add a diagram on Cacoo, you need the diagram ID.
For example, if your diagram's URL is https://cacoo.com/diagrams/gJpqSQjwc7GFDAaI,
your diagram ID is gJpqSQjwc7GFDAaI.

You can add a diagram to your application, like the following example:

```
["cacoo"]
---------------------------------------------------------------------
_Your_diagram_ID_here_
---------------------------------------------------------------------
```

You could load asciidoctor-diagram-cacoo (this gem) with the following command:

```
$ asciidoctor -r asciidoctor-diagram-cacoo sample.adoc
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/asciidoctor-diagram-cacoo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
