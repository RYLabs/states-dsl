module States
  module Dsl
    class Catch
      include States::Dsl::ErrorSupport

      attr_reader :context

      def initialize(context, options={})
        @context = context
        @error_equals = ensure_errors_array(options[:error_equals])
      end

      def result_path(path)
        @result_path = path
      end

      def next_state(state)
        @next_state = context.naming.ref(state)
      end

      def serializable_hash
        {
          "ErrorEquals" => @error_equals,
          "ResultPath" => @result_path,
          "Next" => @next_state,
        }
      end
    end
  end
end
