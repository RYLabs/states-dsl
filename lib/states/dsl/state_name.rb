module States
  module Dsl
    class StateName
      attr_reader :local_name
      attr_accessor :index

      def initialize(local_name, naming)
        @local_name = local_name
        @naming = naming
      end

      def to_s
        @naming.resolve
        resolved = local_name.to_s
        unless index.nil?
          resolved += "_#{(index + 1)}"
        end
        @naming.convert(resolved)
      end
    end
  end
end
