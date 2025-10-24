# lib/hexlet_code/form_builder.rb
# frozen_string_literal: true

module HexletCode
  # FormBuilder — строитель HTML-форм для объекта-модели.
  class FormBuilder
    INPUT_BUILDERS = {
      input: :add_text_input, # default
      select: :add_select,
      checkbox: :add_checkbox,
      password: :add_password,
      text: :add_textarea, # as: :text → <textarea>
      textarea: :add_textarea # на всякий случай
    }.freeze

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      value = @entity.public_send(name)
      # если as не указан — :input, иначе — тот ключ, который передали
      as = options.delete(:as)&.to_sym || :input

      @fields << label(name)
      dispatch_input(as, name, value, options)
      @fields << @last_input

      nil
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
      @last_input = Tag.build('textarea', attrs) { value.to_s }
    end

    def add_select(name, value, options)
      choices  = options.delete(:choices)  || []
      selected = options.delete(:selected) || value
      attrs    = { name: name.to_s }.merge(options)

      options_html = choices.map do |choice|
        sel_attr = choice == selected ? { selected: true } : {}
        Tag.build('option', { value: choice }.merge(sel_attr)) { choice }
      end.join("\n")

      @last_input = Tag.build('select', attrs) { options_html }
    end

    def add_checkbox(name, value, options)
      checked = options.delete(:checked) || value
      attrs   = { name: name.to_s, type: 'checkbox', value: value }
      attrs[:checked] = true if checked
      attrs.merge!(options)

      @last_input = Tag.build('input', attrs)
    end

    def add_password(name, _value, options)
      attrs = { name: name.to_s, type: 'password' }.merge(options)
      @last_input = Tag.build('input', attrs)
    end

    def add_text_input(name, value, options)
      attrs = { name: name.to_s, type: 'text' }
      attrs[:value] = value.to_s unless value.nil?
      attrs.merge!(options)

      @last_input = Tag.build('input', attrs)
    end
  end
end
