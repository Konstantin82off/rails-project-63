# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode — набор хелперов для генерации HTML‑форм и тегов.
module HexletCode
  class Error < StandardError; end

  autoload :Tag, "hexlet_code/tag"
end
