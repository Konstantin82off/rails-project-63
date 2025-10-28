# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # FormBuilder — строитель HTML-форм для объекта-модели.
  class FormBuilder
    INPUT_BUILDERS = {
      input: :add_text_input,
      select: :add_select,
      checkbox: :add_checkbox,
      password: :add_password,
      text: :add_textarea,
      textarea: :add_textarea
    }.freeze

    attr_reader :fields

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      value = @entity.public_send(name)
      as = (options.delete(:as)&.to_sym || :input).to_sym

      @fields << label(name)
      @fields << dispatch_input(as, name, value, options)
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

    def dispatch_input(as, name, value, options)
      method = INPUT_BUILDERS[as] || :add_text_input
      send(method, name, value, options)
    end

    def add_textarea(name, value, options)
      default_options = { cols: 20, rows: 40 }
      attrs = { name: name.to_s }
              .merge(default_options)
              .merge(options)
      Tag.build('textarea', attrs) { value.to_s }
    end

    def add_select(name, value, options)
      choices  = options.delete(:choices)  || []
      selected = options.delete(:selected) || value
      attrs    = { name: name.to_s }.merge(options)

      options_html = choices.map do |choice|
        sel_attr = choice == selected ? { selected: true } : {}
        Tag.build('option', { value: choice }.merge(sel_attr)) { choice }
      end.join("\n")

      Tag.build('select', attrs) { options_html }
    end

    def add_checkbox(name, value, options)
      checked = options.delete(:checked) || value
      attrs   = { name: name.to_s, type: 'checkbox', value: value }
      attrs[:checked] = true if checked
      attrs.merge!(options)

      Tag.build('input', attrs)
    end

    def add_password(name, _value, options)
      attrs = { name: name.to_s, type: 'password' }.merge(options)
      Tag.build('input', attrs)
    end

    def add_text_input(name, value, options)
      attrs = { name: name.to_s, type: 'text' }
      attrs[:value] = value.to_s unless value.nil?
      attrs.merge!(options)

      Tag.build('input', attrs)
    end
  end
end
