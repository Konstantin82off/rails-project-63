# test/test_form_for_empty.rb
# frozen_string_literal: true

require 'test_helper'

User = Struct.new(:name, :job, keyword_init: true)

class TestHexletCodeFormEmpty < Minitest::Test
  def setup
    @user = User.new(name: 'rob')
  end

  def test_generates_empty_form_with_defaults
    html = HexletCode.form_for(@user) { |_f| nil }
    assert_equal '<form action="#" method="post"></form>', html
  end

  def test_accepts_additional_html_attributes
    html = HexletCode.form_for(@user, class: 'hexlet-form') { |_f| nil }
    assert_equal '<form action="#" method="post" class="hexlet-form"></form>', html
  end

  def test_uses_url_as_action
    html = HexletCode.form_for(@user, url: '/profile', class: 'hexlet-form') { |_f| nil }
    assert_equal '<form action="/profile" method="post" class="hexlet-form"></form>', html
  end
end
