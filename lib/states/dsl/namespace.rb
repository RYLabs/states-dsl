module States
  module Dsl
    class Namespace
      def initialize
        @source = {}
        @plurals = {}
      end

      def resolve(name)
        if usages = @source[name.local_name]
          if usages.length == 1
            usages[0].index = 0
          end
          name.index = usages.length
          usages << name
        else
          @source[name.local_name] = [name]
        end
      end
    end
  end
end
