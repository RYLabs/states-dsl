module States
  module Dsl
    class ResourceLookup
      attr_reader :params

      def initialize(defaults)
        @defaults = defaults
        @params = {}
      end

      def function(name)
        resource(name, :function, :lambda)
      end

      def activity(name)
        resource(name, :activity, :states)
      end

      def resource(name, type, service, options={})
        @params = options.merge(name: name, type: type, service: service)
        self
      end

      def to_s
        values = {partition: "aws"}.merge(@defaults).merge(params)
        ["arn", values[:partition], values[:service], values[:region], values[:account], values[:type], values[:name]].join(":")
      end
    end
  end
end
