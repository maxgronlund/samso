require 'test_helper'
require 'generators/scaffold_module/scaffold_module_generator'

class ScaffoldModuleGeneratorTest < Rails::Generators::TestCase
  tests ScaffoldModuleGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
