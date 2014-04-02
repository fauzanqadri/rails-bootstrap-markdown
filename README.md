# Rails::Bootstrap::Markdown

A rails gem for [Bootstrap Markdown](http://toopay.github.io/bootstrap-markdown/), rewritten to SCSS for use with [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass).

3rd party libraries included:

- http://toopay.github.io/bootstrap-markdown/
- https://github.com/domchristie/to-markdown
- https://github.com/evilstreak/markdown-js

## Installation

Add this line to your application's Gemfile:

    gem 'rails-bootstrap-markdown'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails-bootstrap-markdown

## Usage

### CSS

```
*= require static/bootstrap-markdown.min
```

### Javascript

```
//= require bootstrap-markdown
```

### Generator
```
$ rails g bootstrap_markdown:install (sass|less|static)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
