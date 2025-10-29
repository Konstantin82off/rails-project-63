# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # FormBuilder — строитель HTML-форм для объекта-модели.
  class FormBuilder
    attr_reader :fields

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      value = @entity.public_send(name)
      as = (options.delete(:as)&.to_sym || :text).to_sym

      @fields << label(name)
      @fields << build_input(as, name, value, options)
    end

    def submit(text = 'Save')
      @fields << Tag.build('input', type: 'submit', value: text)
    end

    def to_s
      @fields.join("\n")
    end

    private

    def label(name)
      Tag.build('label', for: name.to_s) { name.to_s.capitalize }
    end

    def build_input(as, name, value, options)
      klass_name = "#{as.capitalize}Input"

      # Явно загружаем файл инпута перед обращением к константе
      begin
        # Пытаемся получить класс — это инициирует autoload
        klass = HexletCode::Inputs.const_get(klass_name)
      rescue NameError => e
        raise e unless e.message.include?("uninitialized constant HexletCode::Inputs::#{klass_name}")

        # Принудительно загружаем модуль Inputs, чтобы autoload сработал
        # Повторно пытаемся получить класс
        klass = HexletCode::Inputs.const_get(klass_name)
      end

      input = klass.new(name, value, options)
      input.render
    end
  end
end
