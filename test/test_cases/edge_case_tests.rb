# test/test_cases/edge_case_tests.rb
# frozen_string_literal: true

module EdgeCaseTests
  def test_missing_field_error
    user = Struct.new(:name).new('rob')
    assert_raises(NoMethodError) do
      HexletCode.form_for(user) do |f|
        f.input :age
      end
    end
  end

  def test_checkbox_with_false_value
    user = Struct.new(:accepted).new(false)
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :accepted, as: :checkbox
    end

    expected = ExpectedOutputs::FORM_WITH_CHECKBOX_FALSE
    assert_equal normalize_html(expected), normalize_html(result)
  end
end
