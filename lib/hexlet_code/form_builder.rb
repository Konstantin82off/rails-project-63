# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # FormBuilder — собирает состояние формы (поля, метки, кнопки)
  # без непосредственной генерации HTML. Позволяет отделить логику
  # сбора данных от их рендеринга.
  class FormBuilder
    attr_reader :fields, :submit_value

    def initialize(entity)
      @entity = entity
      @fields = []
      @submit_value = nil
    end

    def input(name, options = {})
      @fields << build_field(name, options)
      self
    end

    def submit(value = 'Save', options = {})
      @submit_value = { value: value, options: options }
      self
    end

    private

    def build_field(name, options)
      opts = options.dup
      type = extract_type(opts.delete(:as))
      value = extract_value(name, opts)

      { type: type, name: name, value: value, options: opts }
    end

    def extract_type(as)
      return :text if as.nil?

      return :textarea if %i[text textarea].include?(as)

      input_class_name = "#{camelize(as)}Input"
      unless HexletCode::Inputs.const_defined?(input_class_name, false)
        raise ArgumentError, "Unsupported input type: #{as}. Valid types: text, textarea, or defined Input classes."
      end

      as
    end

    def extract_value(name, options)
      return options.delete(:value) if options.key?(:value)

      raise NoMethodError, "Unknown attribute #{name} for #{@entity.class}" unless @entity.respond_to?(name)

      @entity.public_send(name)
    end

    def camelize(sym)
      sym.to_s.split('_').map!(&:capitalize).join
    end
  end
end
