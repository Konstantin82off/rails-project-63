# lib/hexlet_code/hexlet_code.rb
# frozen_string_literal: true

require_relative "hexlet_code/tag"
require_relative "hexlet_code/form_builder"
require_relative "hexlet_code/version"

module HexletCode
  def self.form_for(entity, url: nil, **attrs)
    builder = FormBuilder.new(entity)
    yield builder if block_given?

    form_attrs = {}
    form_attrs[:action] = url || "#"
    form_attrs[:method] = "post"
    form_attrs.merge!(attrs)

    Tag.build("form", form_attrs) do
      builder.to_s
    end
  end
end