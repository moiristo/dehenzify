module A
  module B
    class Pirate
      CONST = 1

      def test
        true
      end
    end

    class Matey
      def self.test
        true
      end
    end

    class Chest
      attr_accessor :test

      def set_test=(value)
        self.test = value
      end
    end

    module Concern
      WOOT = 1
    end

    module OtherConcern
      WOOT = 2
    end
  end
end
