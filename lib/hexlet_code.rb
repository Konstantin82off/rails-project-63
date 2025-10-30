# lib/hexlet_code.rb
# frozen_string_literal: true

require 'active_support/all'
require_relative 'hexlet_code/html_renderer'

# Основной модуль HexletCode, предоставляющий DSL для генерации форм
# в Rails‑приложениях. Содержит точки входа для построения форм
# и их элементов.
module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :Version, 'hexlet_code/version'
  autoload :Inputs, 'hexlet_code/inputs'

  # Создаёт HTML‑форму для заданного объекта с указанными атрибутами.
  #
  # @param entity [Object] объект, для которого строится форма
  # @param url [String, nil] URL для отправки формы (по умолчанию '#')
  # @param attrs [Hash] дополнительные атрибуты тега <form>
  # @yield [FormBuilder] блок для конфигурирования полей формы
  # @return [String] HTML‑разметка формы
  def self.form_for(entity, url: nil, **attrs)
    builder = FormBuilder.new(entity)
    yield builder if block_given?

    form_attrs = attrs.merge(url ? { action: url } : {})
    renderer = HtmlRenderer.new
    renderer.render(builder.state, form_attrs)
  end
end
