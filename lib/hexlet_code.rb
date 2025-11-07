# lib/hexlet_code.rb
# frozen_string_literal: true

# HexletCode — DSL‑библиотека для генерации HTML‑форм.
module HexletCode
  autoload :Version, 'hexlet_code/version'
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :HtmlRenderer, 'hexlet_code/html_renderer'

  # Пространство имён для классов input-компонентов
  module Inputs
    autoload :BaseInput, 'hexlet_code/inputs/base_input'
    autoload :TextInput, 'hexlet_code/inputs/text_input'
    autoload :TextareaInput, 'hexlet_code/inputs/textarea_input'
    autoload :SelectInput, 'hexlet_code/inputs/select_input'
    autoload :CheckboxInput, 'hexlet_code/inputs/checkbox_input'
    autoload :PasswordInput, 'hexlet_code/inputs/password_input'
    autoload :SubmitInput, 'hexlet_code/inputs/submit_input'
  end

  def self.form_for(entity, **attrs)
    builder = FormBuilder.new(entity)
    yield builder if block_given?

    renderer = HtmlRenderer.new
    renderer.render(builder, attrs)
  end
end
