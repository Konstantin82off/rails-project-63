# lib/hexlet_code/tag.rb
# frozen_string_literal: true

# Служебный класс для создания HTML-тегов с атрибутами и содержимым.
# Поддерживает отдельные теги (input, br, hr, img) и обычные теги с необязательным содержимым блока.
class Tag
  SINGLE_TAGS = %w[input br hr img].freeze

  def self.build(name, options = {})
    tag_name = name.to_s
    attrs_str = build_attributes(tag_name, options)

    if block_given? && !SINGLE_TAGS.include?(tag_name)
      "<#{tag_name}#{attrs_str}>#{yield.strip}</#{tag_name}>".strip
    elsif SINGLE_TAGS.include?(tag_name)
      "<#{tag_name}#{attrs_str}>".strip
    else
      "<#{tag_name}#{attrs_str}></#{tag_name}>".strip
    end
  end

  def self.build_attributes(tag_name, options)
    attrs =
      if tag_name == "input"
        ordered_input_attributes(options)
      else
        regular_attributes(options)
      end
    attrs.empty? ? "" : " #{attrs.join(" ")}"
  end

  def self.ordered_input_attributes(options)
    order = %w[name type value]
    ordered = order.filter_map do |key|
      fetch_option(options, key)
    end
    rest = options.reject { |k, _| order.include?(k.to_s) }
                  .sort_by { |k, _| k.to_s }
                  .map { |k, v| attr_to_s(k, v) }
                  .compact
    (ordered + rest)
  end

  def self.fetch_option(options, key)
    v = options[key.to_sym] || options[key]
    attr_to_s(key, v) if options.key?(key.to_sym) || options.key?(key)
  end

  def self.regular_attributes(options)
    options.map { |k, v| attr_to_s(k, v) }.compact
  end

  def self.attr_to_s(key, value)
    return nil if value.nil? || value == false

    value == true ? key.to_s : %(#{key}="#{value}")
  end
end
