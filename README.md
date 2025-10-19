# HexletCode 

[![CI](https://github.com/Konstantin82off/rails-project-63/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Konstantin82off/rails-project-63/actions/workflows/main.yml)
[![hexlet-check](https://github.com/Konstantin82off/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg?branch=main)](https://github.com/Konstantin82off/rails-project-63/actions/workflows/hexlet-check.yml)

## Overview

HexletCode is a Ruby library for declarative HTML form generation. It builds forms bound to your Ruby objects, auto-fills values, and supports passing arbitrary HTML attributes.

- Object binding with automatic value population
- Field types: input, textarea, checkbox, select, password
- Custom HTML attributes (class, placeholder, id, etc.)
- submit button with customizable text and attributes

## Requirements

- Ruby 3.x
- Bundler
- (optional) asdf for version management

## Installation

In your Gemfile:
```ruby
gem 'hexlet_code', git: 'https://github.com/Konstantin82off/rails-project-63'
```

Then:
```bash
bundle install
```
Alternative: build and install locally
```bash
gem build hexlet_code.gemspec
gem install pkg/hexlet_code-*.gem
```

## Usage

Basic example:
```ruby
User = Struct.new(:name, :job, :gender, :password, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = HexletCode.form_for(user) do |f|
  f.input :name
  f.input :job, as: :text
  f.submit
end

puts html
```
With URL and HTML attributes:
```ruby
HexletCode.form_for(user, url: '/users') do |f|
  f.input :name, class: 'user-input', placeholder: 'Enter your name'
  f.input :job
  f.submit 'Save', class: 'btn btn-primary'
end
```
Supported field types:
```ruby
* Text input
f.input :name

* Textarea
f.input :job, as: :text

* Checkbox
f.input :gender, as: :checkbox

* Select
f.input :gender, as: :select, choices: %w[m f]

* Password
f.input :password, as: :password
```
Example HTML output:
```html
<form action="/users" method="post">
  <input name="name" type="text" class="user-input" placeholder="Enter your name">
  <textarea name="job">hexlet</textarea>
  <input type="submit" value="Save" class="btn btn-primary">
</form>
```
## Development

```bash
git clone https://github.com/Konstantin82off/rails-project-63 ~/projects/rails-project-63
cd ~/projects/rails-project-63
```
If you use asdf:
```bash
asdf install
```
Then:
```bash
bin/setup
rake test
bin/console
```
Linters (if configured):
```bash
bundle exec rubocop
```
Local install/release:
```bash
bundle exec rake install
```
▎For releasing, bump version in lib/hexlet_code/version.rb
bundle exec rake release

## Contributing

```bash
git checkout -b feat/something
git commit -m "feat: add new input type"
git push -u origin feat/something
Open a pull request:
https://github.com/Konstantin82off/rails-project-63
```

## License

MIT (see LICENSE)
GitHub\
GitHub - Konstantin82off/rails-project-63

Contribute to Konstantin82off/rails-project-63 development by creating an account on GitHub.