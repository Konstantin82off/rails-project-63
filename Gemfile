# Gemfile
# frozen_string_literal: true

source "https://rubygems.org"

# Подгружаем runtime-зависимости из hexlet_code.gemspec
gemspec

# Для удобного запуска в консоли
gem "irb"

group :development, :test do
  # таски (rake, binstubs и т.п.)
  gem "rake", "~> 13.0"

  # тестовые фреймворки
  gem "minitest", "~> 5.16"
  gem "rspec",   "~> 3.13"

  # статический анализ и автокоррекция кода
  gem "rubocop", "~> 1.21", require: false
end
