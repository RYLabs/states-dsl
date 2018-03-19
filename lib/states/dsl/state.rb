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
        if json["Next"].nil? && !%w(Choice Fail).include?(json["Type"])
          json["End"] = true
        end
        json
      end
    end
  end
end
