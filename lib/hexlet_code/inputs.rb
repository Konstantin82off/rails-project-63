# lib/hexlet_code/inputs.rb
# frozen_string_literal: true

require_relative 'inputs/base_input'

module HexletCode
  # Модуль Inputs — пространство имён для классов, реализующих различные
  # типы полей формы. Каждый класс отвечает за рендеринг конкретного
  # HTML-элемента (input, select и т. д.).
  #
  # Доступные классы:
  # - BaseInput     — базовый класс, содержит общий интерфейс
  # - TextInput     — текстовое поле (type="text")
  # - TextareaInput — многострочное поле (textarea)
  # - SelectInput   — выпадающий список (select)
  # - CheckboxInput — флажок (checkbox)
  # - PasswordInput — поле для ввода пароля (type="password")
  module Inputs
    autoload :BaseInput,    'hexlet_code/inputs/base_input'
    autoload :TextInput,    'hexlet_code/inputs/text_input'
    autoload :TextareaInput, 'hexlet_code/inputs/textarea_input'
    autoload :SelectInput, 'hexlet_code/inputs/select_input'
    autoload :CheckboxInput, 'hexlet_code/inputs/checkbox_input'
    autoload :PasswordInput, 'hexlet_code/inputs/password_input'
  end
end
