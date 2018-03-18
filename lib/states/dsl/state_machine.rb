module States
  module Dsl
    class StateMachine < ExecutionContext
      attr_reader :states

      def initialize(options)
        super(nil, options)
      end

      def trait(name, options={}, &block)
        trait = Trait.new(options, context)
        trait.instance_eval(&block)
        @context.register_trait(name, trait)
      end

      def to_json
        JSON.pretty_generate(serializable_hash)
      end
    end
  end
end
