# hexlet_code.gemspec
# frozen_string_literal: true

require_relative "lib/hexlet_code/version"

Gem::Specification.new do |spec|
  spec.name          = "hexlet_code"
  spec.version       = HexletCode::VERSION
  spec.authors       = ["Konstantin Udodov"]
  spec.email         = ["k.udodov@internet.ru"]

  spec.summary       = "DSL to build HTML forms"
  spec.description   = "Hexlet Code — tiny form generator to reduce template boilerplate and handle errors."
  spec.homepage      = "https://github.com/Konstantin82off/rails-project-63"
  spec.required_ruby_version = ">= 3.2.2"

  # Лицензия
  spec.license = "MIT"

  # Метаданные для RubyGems
  spec.metadata["homepage_uri"]     = spec.homepage
  spec.metadata["source_code_uri"]  = spec.homepage
  spec.metadata["changelog_uri"]    = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Файлы, попадающие в гем
  dir           = File.expand_path(__dir__)
  gemspec_file  = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: dir, err: IO::NULL) do |ls|
    ls.read.split("x0").reject do |f|
      f == gemspec_file ||
        f.start_with?(
          "bin/", "Gemfile", ".gitignore",
          "test/", ".github/", ".rubocop.yml"
        )
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime-зависимости (раскомментируйте и добавьте при необходимости)
  # spec.add_dependency "rails", "~> 6.1"
end
