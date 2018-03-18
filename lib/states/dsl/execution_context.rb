module States
  module Dsl
    class ExecutionContext
      attr_reader :context
      attr_reader :resource_defaults

      def initialize(context, options)
        @context = if context.nil?
          Context.new(options)
        else
          context.create_sub_context
        end
        if start_at = options[:start_at]
          @start_at = @context.naming.ref(start_at)
        end
        @states = []
      end

      def state(name, options={}, &block)
        state = State.new(name, @context, options)
        state.instance_eval(&block) if block
        @states << state
        state
      end

      def start(name, options={}, &block)
        @start_at = @context.naming.ref(name)
        state(name, options, &block)
      end

      def serializable_hash
        {
          "StartAt" => @start_at,
          "States" => @states.reduce({}) { |m,s| m[s.name.to_s] = s.serializable_hash; m }
        }
      end
    end
  end
end
