module States
  module Dsl
    class Choices
      def initialize(naming)
        @naming = naming
        @choices = []
      end

      def variable(path, &block)
        c = VariableChoice.new(path, @naming)
        c.instance_eval(&block)
        @choices << c
        c
      end

      def any(&block)
        g = ConditionGroup.new("Or", @naming)
        g.instance_eval(&block)
        @choices << g
        g
      end

      def all(&block)
        g = ConditionGroup.new("And", @naming)
        g.instance_eval(&block)
        @choices << g
        g
      end

      def default(state)
        @default = @naming.ref(state)
      end

      def serializable_hash
        j = {}
        j["Choices"] = @choices.map(&:serializable_hash)
        if @default
          j["Default"] = @default
        end
        j
      end
    end
  end
end
