# lib/hexlet_code/inputs/submit_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит кнопку отправки формы (<input type="submit">).
    class SubmitInput < BaseInput
      def render
        options = tag_options.reject { |k| k == :name }
        options.merge!(type: 'submit')

        options[:value] = @value unless @value.nil? || @value.to_s.empty?

        Tag.build('input', options)
      end
    end
  end
end
