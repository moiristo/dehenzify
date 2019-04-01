require 'dehenzify'
require 'minitest/autorun'
require 'pry'

TEST_ROOT = Pathname.new(__FILE__).join('../').freeze

def fixture_path(file_path)
  TEST_ROOT.join('fixtures').join(file_path)
end
