# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # Построитель форм: генерирует HTML-поля по атрибутам переданного объекта.
  # Пример использования:
  #   HexletCode::FormBuilder
  #     .new(user, url: '/users', method: 'post')
  #     .input(:name, placeholder: 'Your name')
  #     .input(:bio, as: :text, rows: 10)
  #     .submit('Create')
  #     .to_s
  class FormBuilder
    def initialize(entity, url:, method: "post")
      @entity = entity
      @url = url
      @method = method
      @parts = []
    end

    # Добавляет в форму поле input или textarea.
    # name — имя атрибута, **options: :as, :type, :value и др.
    def input(name, **options)
      value = options.fetch(:value) { @entity.public_send(name) }
      as    = options.delete(:as)
      attrs = build_input_attrs(name, value, options)
      tag   = as == :text ? "textarea" : "input"

      append_input(tag, attrs, as == :text)
    end

    def submit(value = "Save")
      @parts << Tag.build("input", type: "submit", value: value)
    end

    def to_s
      open = Tag.build("form", action: @url, method: @method)
      close = "</form>"
      [open, *@parts, close].join
    end

    private

    def build_input_attrs(name, value, options)
      { name: name, value: value, type: options.delete(:type) || "text" }
        .merge(options)
    end

    def append_input(tag, attrs, textarea)
      if textarea
        inner = attrs.delete(:value)
        @parts << Tag.build(tag, attrs) { inner.to_s }
      else
        @parts << Tag.build(tag, attrs)
      end
    end
  end
end
