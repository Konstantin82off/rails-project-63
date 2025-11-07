# lib/hexlet_code/inputs/base_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Базовый класс для всех input-компонентов.
    # Хранит @name, @value, @options и умеет собирать атрибуты в HTML.
    class BaseInput
      def initialize(name, value, options = {})
        @name = name
        @value = value
        @options = options
      end

      def render
        raise NotImplementedError
      end

      protected

      def input_options
        { name: @name }.tap do |opts|
          opts[:id] = @options[:id] if @options.key?(:id)
        end
      end

      def tag_options
        input_options.merge(@options)
      end
    end
  end
end
