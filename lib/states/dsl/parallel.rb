module States
  module Dsl
    class Parallel
      def initialize(context)
        @context = context
        @branches = []
      end

      def branch(options={}, &block)
        branch = ExecutionContext.new(@context, options)
        branch.instance_eval(&block)
        @branches << branch
        branch
      end

      def serializable_hash
        { "Branches" => @branches.map(&:serializable_hash) }
      end
    end
  end
end
