# test/test_hexlet_code.rb
# frozen_string_literal: true

require "test_helper"
require_relative "fixtures/expected_outputs"

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_with_input
    user = Struct.new(:name, :job).new("rob", "hexlet")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :name
      f.input :job, as: "text"
    end

    expected = ExpectedOutputs::FORM_WITH_INPUT
    assert_equal expected, result
  end

  def test_form_for_with_additional_attributes
    user = Struct.new(:name, :job).new("rob", "hexlet")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :name, class: "user-input"
      f.input :job
    end

    expected = ExpectedOutputs::FORM_WITH_ADDITIONAL_ATTRIBUTES
    assert_equal expected, result
  end

  def test_form_for_with_checkbox_input
    user = Struct.new(:gender).new("m")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :gender, as: "checkbox"
    end

    expected = ExpectedOutputs::FORM_WITH_CHECKBOX_INPUT
    assert_equal expected, result
  end

  def test_form_for_with_select_input
    user = Struct.new(:gender).new("m")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :gender, as: "select", choices: %w[m f]
    end

    expected = ExpectedOutputs::FORM_WITH_SELECT_INPUT
    assert_equal expected, result
  end

  def test_form_for_with_default_input
    user = Struct.new(:name).new("rob")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :name
    end

    expected = '<form action="/users" method="post"><input name="name" type="text" value="rob"></form>'
    assert_equal expected, result
  end

  def test_textarea_defaults
    user = Struct.new(:job).new("hexlet")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :job, as: "text"
    end

    expected = ExpectedOutputs::FORM_WITH_TEXTAREA_DEFAULTS
    assert_equal expected, result
  end

  def test_custom_textarea_attributes
    user = Struct.new(:job).new("hexlet")
    result = HexletCode.form_for(user, url: "/users") do |f|
      f.input :job, as: "text", rows: 50, cols: 50
    end

    expected = ExpectedOutputs::FORM_WITH_CUSTOM_TEXTAREA
    assert_equal expected, result
  end

  def test_missing_field_error
    user = Struct.new(:name).new("rob")
    assert_raises(NoMethodError) do
      HexletCode.form_for(user) do |f|
        f.input :age
      end
    end
  end

  def test_it_does_something_useful
    skip "temporary: investigate failing assertion"
    assert false
  end
end
