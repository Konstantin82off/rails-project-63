# test/test_helper.rb
# frozen_string_literal: true

require 'bundler'
Bundler.setup

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest/autorun'
require 'hexlet_code'

module TestHelpers
  def normalize_html(html)
    html.gsub(/\s+/, ' ').strip.gsub(/>\s</, '><')
  end
end

module Minitest
  class Test
    include TestHelpers
  end
end
