require 'minitest_helper'

class Dehenzify::DehenzifierTest < Minitest::Spec
  it 'extracts classes and modules' do
    extracted_sources = dehenzify!('henzified_classes.rb')

    assert extracted_sources[0].target_file_path.end_with?('/a/b/pirate.rb')
    assert_equal %w[A B], extracted_sources[0].namespace_modules

    assert extracted_sources[1].target_file_path.end_with?('/a/b/matey.rb')
    assert_equal %w[A B], extracted_sources[1].namespace_modules

    assert extracted_sources[2].target_file_path.end_with?('/a/b/chest.rb')
    assert_equal %w[A B], extracted_sources[2].namespace_modules

    assert extracted_sources[3].target_file_path.end_with?('/a/b/concern.rb')
    assert_equal %w[A B], extracted_sources[3].namespace_modules

    assert extracted_sources[4].target_file_path.end_with?('/a/b/other_concern.rb')
    assert_equal %w[A B], extracted_sources[4].namespace_modules

    assert extracted_sources[5].target_file_path.end_with?('/henzified_classes.rb')
    assert_nil extracted_sources[5].namespace_modules
  end

  private

  def dehenzify!(fixture_file)
    file_path = fixture_path(fixture_file)
    dehenzifier = Dehenzify::Dehenzifier.new(file_path)
    dehenzifier.run!
  end
end
