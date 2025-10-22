# lib/hexlet_code/tag.rb
# frozen_string_literal: true

# Служебный класс для создания HTML-тегов с атрибутами и содержимым.
# Поддерживает одиночные теги (input, br, hr, img)
# и обычные теги с необязательным содержимым блока.
class Tag
  SINGLE_TAGS = %w[input br hr img].freeze

  # Пример вызова:
  #   Tag.build('div', class: 'foo') { '<span>bar</span>' }
  def self.build(name, options = {})
    tag_name = name.to_s
    attrs_str = build_attributes(tag_name, options)

    if block_given? && !SINGLE_TAGS.include?(tag_name)
      inner = yield
      "<#{tag_name}#{attrs_str}>#{inner}</#{tag_name}>"
    elsif SINGLE_TAGS.include?(tag_name)
      "<#{tag_name}#{attrs_str}>"
    else
      # обычный тег без блока
      "<#{tag_name}#{attrs_str}></#{tag_name}>"
    end
  end

  # Собирает атрибуты в строку вида ' key1="val1" key2="val2"…'
  def self.build_attributes(tag_name, options)
    attrs = if tag_name == "input"
              ordered_input_attributes(options)
            else
              regular_attributes(options)
            end

    attrs.empty? ? "" : " #{attrs.join(" ")}"
  end

  # Для <input> гарантируем порядок name, type, value, остальные — по алфавиту
  def self.ordered_input_attributes(options)
    order = %w[name type value]
    # берём из options name, type, value в нужном порядке, если есть
    primary = order.filter_map { |key| fetch_option(options, key) }
    # остальные опции (кроме уже взятых по order) сортируем по имени
    rest = options
           .reject { |k, _| order.include?(k.to_s) }
           .sort_by { |k, _| k.to_s }
           .map { |k, v| attr_to_s(k, v) }
           .compact

    primary + rest
  end

  # Если в options есть ключ key (string или symbol) — возвращаем attr_to_s
  def self.fetch_option(options, key)
    return unless options.key?(key.to_sym) || options.key?(key)

    value = options[key.to_sym] || options[key]
    attr_to_s(key, value)
  end

  # Обычный перебор хэша options
  def self.regular_attributes(options)
    options.map { |k, v| attr_to_s(k, v) }.compact
  end

  # Преобразует пару key/value в строку атрибута
  #   nil или false  → nil (не выводим атрибут)
  #   true           → 'key'
  #   остальное      → 'key="value"'
  def self.attr_to_s(key, value)
    return nil if value.nil? || value == false

    key_s = key.to_s
    value == true ? key_s : %(#{key_s}="#{value}")
  end
end
