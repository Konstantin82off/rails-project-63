# frozen_string_literal: true

module HexletCode
  module Inputs
    # Рендерит <textarea> с дефолтными rows/cols = 50.
    class TextareaInput < BaseInput
      def render
        default_options = { rows: 50, cols: 50 }
        attrs = { name: @name.to_s }
                .merge(default_options)
                .merge(@options)
        "<textarea #{build_attributes(attrs)}>#{escape_attr_value(@value)}</textarea>"
      end
    end
  end
end
