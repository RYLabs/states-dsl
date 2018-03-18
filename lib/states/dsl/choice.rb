module States
  module Dsl
    class Choice
      def initialize(naming)
        @naming = naming
      end

      def next_state(state)
        @next_state = @naming.ref(state)
      end

      def serializable_hash
        { "Next" => @next_state }
      end
    end
  end
end
