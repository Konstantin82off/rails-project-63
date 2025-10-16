# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode — набор хелперов для генерации HTML‑форм и тегов.
module HexletCode
  class Error < StandardError; end

  autoload :Tag, "hexlet_code/tag"

  def self.form_for(_entity, url: nil, **attrs)
    action = url || "#"
    method_value = attrs.delete(:method) || "post"

    # Пока контент формы пустой (следующие задачи добавят builder).
    # Для непустых тегов Tag.build вернёт парный тег даже без блока.
    Tag.build("form", { action: action, method: method_value }.merge(attrs))
  end
end
