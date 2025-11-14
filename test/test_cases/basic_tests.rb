# test/test_cases/basic_tests.rb
# frozen_string_literal: true

module BasicTests
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_with_default_input
    user = Struct.new(:name).new('rob')
    result = HexletCode.form_for(user, url: '/users') do |f|
      f.input :name
    end

    expected = ExpectedOutputs::FORM_WITH_DEFAULT_INPUT
    assert_equal normalize_html(expected), normalize_html(result)
  end
end
