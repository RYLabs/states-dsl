module States
  module Dsl
    class Trait < StateLike
      def initialize(options, context)
        super(options)
        self.context = context
      end
    end
  end
end
