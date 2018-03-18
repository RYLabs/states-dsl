module States
  module Dsl
    class State < StateLike
      attr_reader :name

      def initialize(name, context, options={})
        super(options)
        @name = context.naming << name
        self.context = context
      end

      def serializable_hash
        json = super
        json["Type"] ||= "Pass"
        json["End"] = true if json["Next"].nil? && json["Type"] != "Choice"
        json
      end
    end
  end
end
