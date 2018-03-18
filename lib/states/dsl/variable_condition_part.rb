module States
  module Dsl
    class VariableConditionPart
      include VariableCondition

      def initialize(path)
        @variable = path
      end

      def serializable_hash
        { "Variable" => @variable }.merge(condition_hash)
      end
    end
  end
end
