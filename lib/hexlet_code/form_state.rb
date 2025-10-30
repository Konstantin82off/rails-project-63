# lib/hexlet_code/form_state.rb
# frozen_string_literal: true

module HexletCode
  # FormState — хранит внутреннее состояние формы как структуру данных.
  # Позволяет:
  # - собирать поля без привязки к формату вывода (HTML, XML, JSON);
  # - добавлять новые типы полей без изменения логики рендеринга;
  # - применять разные рендереры (Bootstrap, Semantic UI и т.п.).
  class FormState
    attr_reader :fields

    # Инициализирует пустое состояние формы.
    def initialize
      @fields = []
    end

    # Добавляет поле в состояние формы.
    # @param field [Hash] описание поля (type:, name:, value:, options:)
    def add_field(field)
      @fields << field
    end

    # Проверяет, есть ли поля в состоянии.
    # @return [Boolean] true, если полей нет
    def empty?
      @fields.empty?
    end
  end
end
