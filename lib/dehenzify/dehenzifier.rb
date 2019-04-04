module Dehenzify

  class Dehenzifier
    attr_accessor :file_name

    def initialize(file_name)
      self.file_name = file_name
    end

    def run!(base_dir: nil)
      extractor = Dehenzify::Extractor.new
      extractor.extract(file_name, base_dir: base_dir)
    end
  end
end
