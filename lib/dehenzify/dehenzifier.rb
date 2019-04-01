module Dehenzify

  class Dehenzifier
    attr_accessor :file_name

    def initialize(file_name)
      self.file_name = file_name
    end

    def run!
      extractor = Dehenzify::Extractor.new
      extractor.extract(file_name)
    end
  end
end
