module States
  module Dsl
    class Context
      attr_accessor :naming, :traits, :resource_defaults

      def initialize(options={})
        @traits = {}
        @naming = Naming.new(nil)
        @naming.converter = options[:name_converter]
        @resource_defaults = options[:resource] || {}
      end

      def create_sub_context(options={})
        sub = Context.new
        sub.traits = traits

        sub.resource_defaults = resource_defaults
        if defaults = options[:resource]
          sub.resource_defaults = defaults
        end

        sub.naming = Naming.new(naming)
        if converter = options[:name_converter]
          sub.naming.converter = converter
        end
        sub
      end

      def register_trait(name, trait)
        trait.context = self
        @traits[name] = trait
      end

      def lookup_traits(names)
        names.map { |nm| traits[nm] }
      end

      def function_resource(name)
        ResourceLookup.new(resource_defaults).function(name)
      end

      def activity_resource(name)
        ResourceLookup.new(resource_defaults).activity(name)
      end
    end
  end
end
