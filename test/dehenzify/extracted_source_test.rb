require 'minitest_helper'

class Dehenzify::ExtractedSourceTest < Minitest::Spec
  it 'knows when ruby source is empty' do
    file_path = fixture_path('empty_file.rb')
    source = File.read(file_path)
    extracted_source = Dehenzify::ExtractedSource.new(file_path, source, 'A')

    assert extracted_source.empty?
  end
end
