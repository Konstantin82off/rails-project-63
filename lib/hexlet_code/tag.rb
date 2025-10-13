# frozen_string_literal: true

module HexletCode # :nodoc:
  # Helpers to build HTML tags.
  module Tag
    VOID_TAGS = %w[area base br col embed hr img input link meta param source track wbr].freeze

    def self.build(name, attrs = {}, &block)
      tag_name = name.to_s
      attributes = build_attributes(attrs)

      if VOID_TAGS.include?(tag_name)
        "<#{tag_name}#{attributes}>"
      else
        content = block_given? ? block.call : ""
        "<#{tag_name}#{attributes}>#{content}</#{tag_name}>"
      end
    end

    def self.build_attributes(attrs)
      return "" if attrs.nil? || attrs.empty?

      parts = attributes_parts(attrs)
      parts.empty? ? "" : " #{parts.join(" ")}"
    end

    def self.attributes_parts(attrs)
      attrs.each_with_object([]) do |(key, value), acc|
        next if skip_attribute?(value)

        acc << (value == true ? key.to_s : %(#{key}="#{value}"))
      end
    end

    def self.skip_attribute?(value)
      value.nil? || value == false
    end

    private_class_method :build_attributes, :attributes_parts, :skip_attribute?
  end
end
