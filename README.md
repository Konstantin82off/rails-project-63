# HexletCode

[![CI](https://github.com/Konstantin82off/rails-project-63/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Konstantin82off/rails-project-63/actions/workflows/main.yml)
[![hexlet-check](https://github.com/Konstantin82off/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg?branch=main)](https://github.com/Konstantin82off/rails-project-63/actions/workflows/hexlet-check.yml)

## Overview

HexletCode is a Ruby library for declarative HTML form generation. It builds forms bound to your Ruby objects, auto-fills values, and supports passing arbitrary HTML attributes.

**Key Features (v0.2.0):**
- Object binding with automatic value population
- Separation of concerns: form state (`FormState`) and rendering (`HtmlRenderer`)
- Field types: input, textarea, checkbox, select, password
- Custom HTML attributes (class, placeholder, id, etc.)
- Labels for each input field
- Submit button with customizable text and attributes
- Modular input system via `HexletCode::Inputs` namespace
- Autoloading of core components (`HexletCode`, `Tag`, `FormBuilder`, etc.)

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

### Basic Example
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

### With URL and HTML Attributes
```ruby
HexletCode.form_for(user, url: '/users') do |f|
  f.input :name, class: 'user-input', placeholder: 'Enter your name'
  f.input :job
  f.submit 'Save', class: 'btn btn-primary'
end
```

### Supported Field Types
```ruby
# Text input (default)
f.input :name

# Textarea
f.input :job, as: :text

# Checkbox
f.input :gender, as: :checkbox

# Select
f.input :gender, as: :select, choices: %w[m f]

# Password
f.input :password, as: :password
```

### Custom Submit Button
```ruby
f.submit                # default "Save" button
f.submit 'Wow'         # custom button text
f.submit 'Save', class: 'btn btn-primary'  # with additional attributes
```

### Example HTML Output
```html
<form action="/users" method="post">
  <label for="name">Name</label>
  <input name="name" type="text" class="user-input" placeholder="Enter your name">
  <label for="job">Job</label>
  <textarea name="job">hexlet</textarea>
  <input type="submit" value="Save" class="btn btn-primary">
</form>
```

## Architecture (v0.2.0 Changes)

### Key Concepts

**1. FormState**
Stores the form data structure without HTML coupling.

**2. FormBuilder**
Collects form fields, labels, and buttons. Passes state to the renderer.

**3. HtmlRenderer**
Converts `FormState` into HTML markup. Handles all rendering logic.

**4. HexletCode::Inputs Module**
Manages input types via dedicated classes:

- `HexletCode::Inputs::BaseInput (abstract base)`

- `HexletCode::Inputs::TextInput`

- `HexletCode::Inputs::CheckboxInput`

- `HexletCode::Inputs::PasswordInput`

- `HexletCode::Inputs::SelectInput`

- `HexletCode::Inputs::TextareaInput`

### Important Notes (Breaking Changes)
- **Input Namespace:** Use `HexletCode::Inputs::[InputType]` to access input classes.

- **HTML Generation:** Now handled by `HtmlRenderer`, not `FormBuilder`.

- **Autoloading:** Core components use `autoload` instead of `require_relative`.

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

### Linters (if configured):
```bash
bundle exec rubocop
```
### Local install/release:
```bash
bundle exec rake install
```
### For releasing:
1. Bump version in `lib/hexlet_code/version.rb`
2. Run:
```bash
bundle exec rake release
```

## Contributing
1. Create a feature branch:
```bash
git checkout -b feat/something
```
2. Commit your changes:
```bash
git commit -m "feat: add new input type"
```
3. Push to GitHub:
```bash
git push -u origin feat/something
```
4 Open a pull request:

<https://github.com/Konstantin82off/rails-project-63>

## License
MIT (see LICENSE)

## GitHub

[GitHub-Konstantin82off/rails-project-63](https://github.com/Konstantin82off/rails-project-63)

Contribute to Konstantin82off/rails-project-63 development by creating an account on GitHub.