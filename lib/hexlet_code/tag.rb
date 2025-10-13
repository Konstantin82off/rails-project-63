# frozen_string_literal: true

module HexletCode
  module Tag
    VOID_TAGS = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def self.build(name, attrs = {})
      tag_name = name.to_s
      attributes = build_attributes(attrs)

      if VOID_TAGS.include?(tag_name)
        "<#{tag_name}#{attributes}>"
      else
        content = block_given? ? yield : ''
        "<#{tag_name}#{attributes}>#{content}</#{tag_name}>"
      end
    end

    def self.build_attributes(attrs)
      return '' if attrs.nil? || attrs.empty?

      parts = []
      attrs.each do |key, value|
        next if value.nil?
        parts << "#{key}="#{value}""
      end

      parts.empty? ? '' : " #{parts.join(' ')}"
    end

    private_class_method :build_attributes
  end
end
