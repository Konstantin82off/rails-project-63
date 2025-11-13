# test/test_cases/input_type_tests.rb
# frozen_string_literal: true

module InputTypeTests
  def html_equal?(expected, actual)
    clean_expected = expected.gsub(/\s+/, ' ').strip
    clean_actual = actual.gsub(/\s+/, ' ').strip

    parse_tags(clean_expected) == parse_tags(clean_actual)
  end

  private

  def parse_tags(html)
    tags = []
    html.scan(/<([^>]*)>/) do |match|
      tag_content = match[0]
      parts = split_tag_parts(tag_content)
      tag_name = extract_tag_name(parts)
      attributes = parse_attributes(parts[1..])

      tags << { name: tag_name, attrs: attributes }
    end
    tags
  end

  def split_tag_parts(tag_content)
    tag_content.split(/\s+/)
  end

  def extract_tag_name(parts)
    parts[0].downcase
  end

  def parse_attributes(attr_parts)
    attributes = {}
    attr_parts.each do |attr|
      if attr.include?('=')
        key, value = split_attribute(attr)
        attributes[key] = value
      else
        attributes[attr.downcase] = nil
      end
    end
    attributes
  end

  def split_attribute(attr)
    key, value = attr.split('=', 2)
    key = key.downcase.strip
    value = value.strip.delete('"\'')
    [key, value]
  end

  def test_form_for_with_input
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job, as: :textarea
    end

    expected = ExpectedOutputs::FORM_WITH_INPUT
    assert html_equal?(expected, result), 'Форма с input и textarea не совпадает'
  end

  def test_form_for_with_checkbox_input
    user = Struct.new(:gender).new('m')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :gender, as: :checkbox, checked: true
    end

    expected = ExpectedOutputs::FORM_WITH_CHECKBOX_INPUT
    assert html_equal?(expected, result), 'Форма с чекбоксом не совпадает'
  end

  def test_form_for_with_select_input
    user = Struct.new(:gender).new('m')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :gender, as: :select, choices: %w[m f]
    end

    expected = ExpectedOutputs::FORM_WITH_SELECT_INPUT
    assert html_equal?(expected, result), 'Форма с select не совпадает'
  end

  def test_textarea_defaults
    user = Struct.new(:job).new('hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :job, as: :textarea
    end

    expected = ExpectedOutputs::FORM_WITH_TEXTAREA_DEFAULTS
    assert html_equal?(expected, result), 'Textarea с дефолтными атрибутами не совпадает'
  end

  def test_custom_textarea_attributes
    user = Struct.new(:job).new('hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :job, as: :textarea, rows: 50, cols: 50
    end

    expected = ExpectedOutputs::FORM_WITH_CUSTOM_TEXTAREA
    assert html_equal?(expected, result), 'Textarea с кастомными атрибутами не совпадает'
  end

  def test_password_input
    user = Struct.new(:password).new('secret123')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :password, as: :password
    end

    expected = ExpectedOutputs::FORM_WITH_PASSWORD_INPUT
    assert html_equal?(expected, result), 'Пароль без кастомных атрибутов не совпадает'
  end

  def test_password_with_custom_attributes
    user = Struct.new(:password).new('secret123')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :password, as: :password, class: 'form-control', placeholder: 'Enter password'
    end

    expected = ExpectedOutputs::FORM_WITH_PASSWORD_CUSTOM
    assert html_equal?(expected, result), 'Пароль с кастомными атрибутами не совпадает'
  end
end
