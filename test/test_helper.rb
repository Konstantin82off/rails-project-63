# test/test_helper.rb
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'

module TestHelpers
  # Нормализует HTML: сжимает пробелы и убирает переносы
  def normalize_html(html)
    html.gsub(/\s+/, ' ').strip.gsub(/>\s</, '><')
  end
end

module Minitest
  class Test
    include TestHelpers
  end
end
