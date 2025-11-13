# lib/hexlet_code/inputs/base_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Базовый класс для всех input-компонентов.
    class BaseInput
      def initialize(name:, value:, options: {})
        @name = name
        @value = value
        @options = options
      end

      def render
        raise NotImplementedError
      end

      def render_with_label
        if @options[:skip_label]
          render
        else
          label_text = @options[:label] || humanize_name(@name)
          label_attrs = { for: @name.to_s }
          label_html = Tag.build('label', label_attrs) { label_text }
          "#{label_html}\n#{render}"
        end
      end

      protected

      def input_options
        { name: @name }.merge(@options.slice(:id))
      end

      def tag_options
        input_options.merge(@options)
      end

      private

      def humanize_name(name)
        name.to_s.tr('_', ' ').split.map(&:capitalize).join(' ')
      end
    end
  end
end
