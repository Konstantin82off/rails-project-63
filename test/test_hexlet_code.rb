# test/test_hexlet_code.rb
# frozen_string_literal: true

require 'test_helper'
require_relative 'fixtures/expected_outputs'
require_relative '../lib/hexlet_code'

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_with_input
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job, as: :textarea # ← исправлено: :textarea (символ)
    end

    expected = ExpectedOutputs::FORM_WITH_INPUT
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_for_with_additional_attributes
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expected = ExpectedOutputs::FORM_WITH_ADDITIONAL_ATTRIBUTES
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_for_with_checkbox_input
    user = Struct.new(:gender).new('m')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :gender, as: :checkbox # ← уже корректно: :checkbox
    end

    expected = ExpectedOutputs::FORM_WITH_CHECKBOX_INPUT
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_for_with_select_input
    user = Struct.new(:gender).new('m')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :gender, as: :select, choices: %w[m f] # ← уже корректно: :select
    end

    expected = ExpectedOutputs::FORM_WITH_SELECT_INPUT
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_for_with_default_input
    user = Struct.new(:name).new('rob')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
    end

    expected = ExpectedOutputs::FORM_WITH_DEFAULT_INPUT
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_textarea_defaults
    user = Struct.new(:job).new('hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :job, as: :textarea # ← исправлено: :textarea (символ)
    end

    expected = ExpectedOutputs::FORM_WITH_TEXTAREA_DEFAULTS
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_custom_textarea_attributes
    user = Struct.new(:job).new('hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :job, as: :textarea, rows: 50, cols: 50 # ← исправлено: :textarea (символ)
    end

    expected = ExpectedOutputs::FORM_WITH_CUSTOM_TEXTAREA
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_with_labels_and_submit
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert_equal normalize_html(ExpectedOutputs::FORM_WITH_LABELS_AND_SUBMIT), normalize_html(result)
  end

  def test_custom_submit_text
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job
      f.submit 'Update'
    end

    assert_equal normalize_html(ExpectedOutputs::FORM_WITH_CUSTOM_SUBMIT), normalize_html(result)
  end

  def test_missing_field_error
    user = Struct.new(:name).new('rob')
    assert_raises(NoMethodError) do
      HexletCode.form_for(user) do |f|
        f.input :age
      end
    end
  end
end
