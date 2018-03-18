module States
  module Dsl
    class ConditionGroup < Choice
      def initialize(type, naming)
        super(naming)
        @type = type
        @parts = []
      end

      def variable(path, &block)
        c = VariableConditionPart.new(path)
        c.instance_eval(&block)
        @parts << c
        c
      end

      def serializable_hash
        { @type => @parts.map(&:serializable_hash) }.merge(super)
      end
    end
  end
end
