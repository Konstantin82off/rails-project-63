# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

require_relative 'form_state'

module HexletCode
  # FormBuilder — собирает состояние формы (поля, метки, кнопки)
  # без непосредственной генерации HTML. Позволяет отделить логику
  # сбора данных от их рендеринга.
  class FormBuilder
    attr_reader :state

    # Инициализирует сборщик формы для заданного объекта.
    # @param entity [Object] модель, чьи атрибуты будут использоваться в форме
    def initialize(entity)
      @entity = entity
      @state = FormState.new
    end

    # Добавляет поле в форму с указанным типом и опциями.
    # @param name [Symbol] имя атрибута модели
    # @param options [Hash] опции поля (as:, class:, и т.д.)
    def input(name, **options)
      value = @entity.public_send(name)
      as = (options.delete(:as)&.to_sym || :text).to_sym

      field = {
        type: as,
        name: name,
        value: value,
        options: options
      }

      @state.add_field({ role: :label, name: name })
      @state.add_field(field)
    end

    # Добавляет кнопку отправки формы.
    # @param text [String] текст на кнопке (по умолчанию 'Save')
    def submit(text = 'Save')
      @state.add_field({ role: :submit, value: text })
    end

    # Возвращает собранные поля формы (для обратной совместимости).
    # @return [Array] список полей в формате { role:, name:, value:, options: }
    def fields
      @state.fields
    end

    private

    def label(name)
      Tag.build('label', for: name.to_s) { name.to_s.capitalize }
    end

    def build_input(as, name, value, options)
      klass_name = "#{as.capitalize}Input"
      klass = HexletCode::Inputs.const_get(klass_name)
      input = klass.new(name, value, options)
      input.render
    end
  end
end
