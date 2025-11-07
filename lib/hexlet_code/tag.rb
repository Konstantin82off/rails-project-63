# lib/hexlet_code/tag.rb
# frozen_string_literal: true

module HexletCode
  # Класс для создания HTML‑тегов с атрибутами и содержимым.
  class Tag
    VOID_TAGS = %i[area base br col embed hr img input link meta param source track wbr].freeze

    def self.build(name, options = {})
      tag_name = name.to_s
      attrs_str = build_attributes(options)

      if VOID_TAGS.include?(tag_name.to_sym)
        "<#{tag_name}#{attrs_str}>"
      else
        body = block_given? ? yield : ''
        "<#{tag_name}#{attrs_str}>#{body}</#{tag_name}>"
      end
    end

    def self.build_attributes(options)
      options.map { |k, v| attr_to_s(k, v) }.compact.join
    end

    def self.attr_to_s(key, value)
      return nil if value.nil? || value == false

      if value == true
        " #{key}"
      else
        value = value.to_s if value.is_a?(Symbol)
        " #{key}=\"#{escape_attr_value(value)}\""
      end
    end

    def self.escape_attr_value(value)
      value.to_s.gsub(/["<>]/, { '"' => '&quot;', '<' => '&lt;', '>' => '&gt;' })
    end
  end
end
