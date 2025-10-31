# lib/hexlet_code/inputs/base_input.rb
# frozen_string_literal: true

module HexletCode
  module Inputs
    # Базовый класс для всех input-компонентов формы.
    # Обеспечивает:
    # - унифицированную инициализацию
    # - механизм упорядоченного рендеринга атрибутов
    # - базовую защиту от XSS через экранирование
    class BaseInput
      # Список приоритетных атрибутов в нужном порядке для предсказуемого рендеринга.
      # Порядок влияет на вывод в HTML (важно для сравнения в тестах).
      ATTRIBUTE_ORDER = %i[
        name id type value class placeholder
        readonly disabled required autofocus
        cols rows selected checked
      ].freeze

      def initialize(name, value, options = nil)
        @name = name
        @value = value
        # Гарантируем, что @options — всегда хэш (даже если передали nil)
        @options = options.is_a?(Hash) ? options : (options || {})
      end

      # Абстрактный метод, должен быть переопределён в подклассах.
      # Отвечает за генерацию HTML-разметки конкретного input-элемента.
      def render
        raise NotImplementedError, 'Метод render должен быть переопределён в подклассе'
      end

      private

      # Формирует строку атрибутов в фиксированном порядке.
      #
      # @param attrs [Hash] хэш атрибутов для рендеринга
      # @return [String] строка вида 'name="value" id="value"'
      # Для булевых атрибутов (со значением nil) выводит только имя атрибута (например, checked)
      def build_attributes(attrs)
        ATTRIBUTE_ORDER
          .select { |attr| attrs.key?(attr) }
          .map do |attr|
            if attrs[attr].nil?
              attr.to_s
            else
              "#{attr}=\"#{escape_attr_value(attrs[attr])}\""
            end
          end
          .join(' ')
      end

      # Экранирует специальные символы в значении атрибута.
      #
      # @param value [Object] значение атрибута (будет приведено к строке)
      # @return [String] экранированное значение
      def escape_attr_value(value)
        value.to_s.gsub('"', '&quot;')
      end
    end
  end
end
