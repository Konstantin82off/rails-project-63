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

      # Явно проверяем тип поля
      if as == :textarea
        # Для textarea используем специальный метод
        add_textarea(name, value, options)
      else
        dispatch_input(as, name, value, options)
      end

      # Теперь добавляем label перед полем
      @fields << label(name)
      @fields << @last_input # Используем сохраненный тег input
      nil
    end

    def submit(text = "Save")
      @fields << Tag.build("input", { type: "submit", value: text })
    end

    def to_s
      @fields.join("\n")
    end

    private

    def label(name)
      Tag.build("label", { for: name.to_s }) { name.to_s.capitalize }
    end

    def dispatch_input(as, name, value, options)
      method = INPUT_BUILDERS[as.to_sym] || :add_text_input
      send(method, name, value, options)
    end

    def add_textarea(name, value, options)
      # Устанавливаем значения по умолчанию
      default_options = { cols: 20, rows: 40 }
      attrs = { name: name }.merge(default_options).merge(options)
      @last_input = Tag.build("textarea", attrs) { value.to_s.strip }
    end

    def add_select(name, value, options)
      choices = options.delete(:choices) || []
      selected = options.delete(:selected) || value
      attrs = { name: name }.merge(options)
      options_html = choices.map do |choice|
        selected_attr = choice == selected ? { selected: true } : {}
        Tag.build("option", { value: choice }.merge(selected_attr)) { choice }
      end.join("\n")
      @last_input = Tag.build("select", attrs) { options_html }
    end

    def add_checkbox(name, value, options)
      checked = options.delete(:checked) || value
      attrs = { name: name, type: "checkbox", value: value }
      attrs[:checked] = true if checked
      attrs.merge!(options)
      @last_input = Tag.build("input", attrs)
    end

    def add_password(name, _value, options)
      attrs = { name: name, type: "password" }
      attrs.merge!(options)
      @last_input = Tag.build("input", attrs)
    end

    def add_text_input(name, value, options)
      attrs = { name: name, type: "text" }
      attrs[:value] = value.to_s unless value.nil?
      attrs.merge!(options)
      @last_input = Tag.build("input", attrs)
    end
  end
end
