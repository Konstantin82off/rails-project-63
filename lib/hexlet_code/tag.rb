# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[input br hr img].freeze

    def self.build(name, options = {}, &block)
      attributes = if name == "input"
        # Сортировка атрибутов для input: name, type, value, остальные по алфавиту
        order = %w[name type value]
        ordered_attrs = order.filter_map do |k|
          v = options[k.to_sym] || options[k]
          [k, v] if options.key?(k.to_sym) || options.key?(k)
        end
        rest = options.reject { |k, _| order.include?(k.to_s) }
        attrs_arr = ordered_attrs + rest.sort_by { |k, _| k.to_s }
        attrs_arr.map { |key, value| attr_to_s(key, value) }.compact.join(" ")
      else
        options.map { |key, value| attr_to_s(key, value) }.compact.join(" ")
      end

      attrs_str = attributes.empty? ? "" : " #{attributes}"

      if block_given?
        "<#{name}#{attrs_str}>#{yield}</#{name}>"
      elsif SINGLE_TAGS.include?(name)
        "<#{name}#{attrs_str}>"
      else
        "<#{name}#{attrs_str}></#{name}>"
      end
    end

    def self.attr_to_s(key, value)
      return nil if value.nil? || value == false
      value == true ? key.to_s : %(#{key}="#{value}")
    end
  end
end
