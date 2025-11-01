# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

require_relative 'form_state'

module HexletCode
  # FormBuilder — собирает состояние формы (поля, метки, кнопки)
  # без непосредственной генерации HTML. Позволяет отделить логику
  # сбора данных от их рендеринга.
  class FormBuilder
    attr_reader :state

    def initialize(entity)
      @entity = entity
      @state  = FormState.new
    end

    # теперь всего 4 строки + заголовок
    def input(name, **options)
      type  = extract_type!(options)
      value = @entity.public_send(name)
      add_label(name)
      add_field(type, name, value, options)
    end

    def submit(text = 'Save')
      @state.add_field(role: :submit, value: text)
    end

    private

    # Выбирает и удаляет :as из options
    def extract_type!(options)
      as = options.delete(:as)&.to_sym
      case as
      when :text, :textarea then :textarea
      when nil then :text
      else as
      end
    end

    def add_label(name)
      @state.add_field(role: :label, name: name)
    end

    def add_field(type, name, value, options)
      @state.add_field(
        type: type,
        name: name,
        value: value,
        options: options
      )
    end
  end
end
