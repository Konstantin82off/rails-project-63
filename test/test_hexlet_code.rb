# test/test_hexlet_code.rb
# frozen_string_literal: true

require 'test_helper'
require_relative 'fixtures/expected_outputs'
require_relative '../lib/hexlet_code'

# Тестовые модули разбиты на группы для соблюдения ограничения RuboCop Metrics/ClassLength.
# Это не влияет на работу autoload в lib/, так как:
# - autoload отвечает за загрузку классов библиотеки из lib/
# - require_relative здесь подключает только тестовые вспомогательные модули
require_relative 'test_cases/basic_tests'
require_relative 'test_cases/input_type_tests'
require_relative 'test_cases/advanced_tests'
require_relative 'test_cases/edge_case_tests'

class TestHexletCode < Minitest::Test
  include BasicTests
  include InputTypeTests
  include AdvancedTests
  include EdgeCaseTests
end
