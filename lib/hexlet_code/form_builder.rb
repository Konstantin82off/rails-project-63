# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

# FormBuilder — строитель HTML-форм для объекта-модели.
module HexletCode
  # FormBuilder предоставляет API для построения форм
  class FormBuilder
    INPUT_BUILDERS = {
      text: :add_text_input,
      select: :add_select,
      checkbox: :add_checkbox,
      password: :add_password,
      textarea: :add_textarea
    }.freeze

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      value = @entity.public_send(name)
      as = options.delete(:as) || :text
      dispatch_input(as, name, value, options)
      nil
    end

    def to_s
      @fields.join("\n")
    end

    private

    def dispatch_input(as, name, value, options)
      method = INPUT_BUILDERS[as.to_sym] || :add_text_input
      send(method, name, value, options)
    end

    def add_textarea(name, value, options)
      default_options = { cols: 20, rows: 40 }
      attrs = { name: name }.merge(default_options).merge(options)
      @fields << Tag.build("textarea", attrs) { value.to_s.strip }
    end

    def add_select(name, value, options)
      choices = options.delete(:choices) || []
      # Получаем selected значение из объекта или из options
      selected = options.delete(:selected) || value
      attrs = { name: name }.merge(options)
      options_html = choices.map do |choice|
        # Добавляем атрибут selected если значение совпадает с текущим
        selected_attr = choice == selected ? { selected: true } : {}
        Tag.build("option", { value: choice }.merge(selected_attr)) { choice }
      end.join("\n")
      @fields << Tag.build("select", attrs) { options_html }
    end

    def add_checkbox(name, value, options)
      checked = options.delete(:checked) || value
      attrs = { name: name, type: "checkbox", value: value }
      attrs[:checked] = true if checked
      attrs.merge!(options)
      @fields << Tag.build("input", attrs)
    end

    def add_password(name, _value, options)
      attrs = { name: name, type: "password" }
      attrs.merge!(options)
      @fields << Tag.build("input", attrs)
    end

    def add_text_input(name, value, options)
      attrs = { name: name, type: "text" }
      attrs[:value] = value.to_s unless value.nil?
      attrs.merge!(options)
      @fields << Tag.build("input", attrs)
    end
  end
end
