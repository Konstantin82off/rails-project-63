# lib/hexlet_code.rb
# frozen_string_literal: true

# Основной модуль HexletCode, предоставляющий DSL для генерации форм
# в Rails-приложениях. Модуль включает в себя основные компоненты
# для работы с формами и их элементами.
module HexletCode
  # Требует необходимые компоненты
  require_relative 'hexlet_code/tag'
  require_relative 'hexlet_code/form_builder'
  require_relative 'hexlet_code/version'

  # Создает форму с заданными параметрами и блоком
  #
  # Параметры:
  # * entity - объект, для которого создается форма
  # * url - URL для отправки формы (по умолчанию "#")
  # * attrs - дополнительные атрибуты формы
  #
  # Возвращает:
  # Строку с HTML-разметкой формы
  def self.form_for(entity, url: nil, **attrs)
    builder = FormBuilder.new(entity)
    yield builder if block_given?

    form_attrs = {}
    form_attrs[:action] = url || '#'
    form_attrs[:method] = 'post'
    form_attrs.merge!(attrs)

    Tag.build('form', form_attrs) do
      builder.to_s
    end
  end
end
