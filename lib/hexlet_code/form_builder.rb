# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      value = @entity.public_send(name)
      as = options.delete(:as)

      case as&.to_sym
      when :text
        attrs = { name: name }.merge(options)
        @fields << Tag.build("textarea", attrs) { value.to_s }
      when :select
        choices = options.delete(:choices) || []
        attrs = { name: name }.merge(options)
        options_html = choices.map do |choice|
          selected = (choice == value) ? { selected: true } : {}
          Tag.build("option", { value: choice }.merge(selected)) { choice }
        end.join
        @fields << Tag.build("select", attrs) { options_html }
      when :checkbox
        attrs = { name: name, type: "checkbox", value: value }
        attrs[:checked] = true if value
        attrs.merge!(options)
        @fields << Tag.build("input", attrs)
      else # default: text input
        attrs = { name: name, type: "text" }
        attrs[:value] = value unless value.nil?
        attrs.merge!(options)
        @fields << Tag.build("input", attrs)
      end
      nil
    end

    def to_s
      @fields.join
    end
  end
end
