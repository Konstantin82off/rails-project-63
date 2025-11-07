# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # FormBuilder — собирает состояние формы (поля, метки, кнопки)
  # без непосредственной генерации HTML. Позволяет отделить логику
  # сбора данных от их рендеринга.
  class FormBuilder
    attr_reader :entity, :fields, :submit_value

    def initialize(entity)
      @entity = entity
      @fields = []
      @submit_value = nil
    end

    def input(name, **options)
      type = extract_type(options)
      value = @entity.public_send(name)

      @fields << {
        type: type,
        name: name,
        value: value,
        options: options
      }
    end

    def submit(value = 'Save')
      @submit_value = value
    end

    private

    def extract_type(options)
      as = options[:as]&.to_sym
      case as
      when :textarea then :textarea
      when nil then :text
      else as
      end
    end
  end
end
