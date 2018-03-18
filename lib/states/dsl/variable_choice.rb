module States
  module Dsl
    class VariableChoice < Choice
      include VariableCondition

      def initialize(path, naming)
        super(naming)
        @variable = path
      end

      def serializable_hash
        super.merge("Variable" => @variable).merge(condition_hash)
      end
    end
  end
end
