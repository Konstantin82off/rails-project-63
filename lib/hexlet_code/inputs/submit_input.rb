# lib/hexlet_code/inputs/submit_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит кнопку отправки формы (<button type="submit">).
    class SubmitInput < BaseInput
      def initialize(name:, value:, options: {})
        super
      end

      def render
        options = tag_options.reject { |k| k == :name }
        options.merge!(type: 'submit')

        Tag.build('button', options) do
          @value.to_s
        end
      end
    end
  end
end
