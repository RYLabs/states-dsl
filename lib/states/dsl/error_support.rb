module States
  module Dsl
    module ErrorSupport
      protected
      def ensure_errors_array(arr)
        [arr].flatten.map { |exc| exc == :all ? "States.ALL" : exc }
      end
    end
  end
end
