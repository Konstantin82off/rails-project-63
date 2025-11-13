# test/test_cases/advanced_tests.rb
# frozen_string_literal: true

module AdvancedTests
  def test_form_for_with_additional_attributes
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expected = ExpectedOutputs::FORM_WITH_ADDITIONAL_ATTRIBUTES
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_form_with_labels_and_submit
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job
      f.submit
    end

    expected = ExpectedOutputs::FORM_WITH_LABELS_AND_SUBMIT
    assert_equal normalize_html(expected), normalize_html(result)
  end

  def test_custom_submit_text
    user = Struct.new(:name, :job).new('rob', 'hexlet')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
      f.input :job
      f.submit 'Update'
    end

    expected = ExpectedOutputs::FORM_WITH_CUSTOM_SUBMIT
    assert_equal normalize_html(expected), normalize_html(result)
  end
end
