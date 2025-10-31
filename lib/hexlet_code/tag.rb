# lib/hexlet_code/tag.rb
# frozen_string_literal: true

module HexletCode
  # Служебный класс для создания HTML-тегов с атрибутами и содержимым.
  # Поддерживает отдельные теги (input, br, hr, img) и обычные теги с необязательным содержимым блока.
  class Tag
    SINGLE_TAGS = %i[input br hr img].freeze

    def self.build(name, options = {})
      tag_name = name.to_s
      attrs_str = build_attributes(options)

      return "<#{tag_name}#{attrs_str}>" if SINGLE_TAGS.include?(tag_name.to_sym)

      body = block_given? ? yield.strip : ''
      "<#{tag_name}#{attrs_str}>#{body}</#{tag_name}>"
    end

    def self.build_attributes(options)
      attrs = options.map do |key, value|
        attr_to_s(key, value)
      end.compact

      attrs.empty? ? '' : attrs.join
    end

    def self.attr_to_s(key, value)
      return nil if value.nil? || value == false

      value == true ? " #{key}" : " #{key}=\"#{value}\""
    end
  end
end
