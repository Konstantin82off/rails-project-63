# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode — набор хелперов для генерации HTML‑форм и тегов.
module HexletCode
  class Error < StandardError; end

  autoload :Tag, "hexlet_code/tag"
  autoload :FormBuilder, "hexlet_code/form_builder"  # Добавлено

  def self.form_for(entity, url: nil, **attrs)  # Изменено: добавлен параметр entity
    action = url || "#"
    method_value = attrs.delete(:method) || "post"

    builder = FormBuilder.new(entity, url: action, **attrs)  # Добавлено
    form_content = yield(builder) if block_given?  # Добавлено

    Tag.build("form", { action: action, method: method_value }.merge(attrs)) do
      form_content  # Добавлено
    end
  end
end
