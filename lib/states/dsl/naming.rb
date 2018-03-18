module States
  module Dsl
    class Naming
      attr_accessor :converter

      attr_reader :parent
      attr_reader :namespace
      attr_reader :children
      attr_reader :names

      def initialize(parent)
        @parent = parent
        @names = []
        @references = []
        @children = []
        if parent
          @namespace = parent.namespace
          if parent.converter
            self.converter = parent.converter
          end
          parent.children << self
        else
          @namespace = Namespace.new
        end
      end

      def <<(name)
        nm = StateName.new(name, self)
        @names << nm
        nm
      end

      def ref(name)
        ref = StateReference.new(name, self)
        @references << ref
        ref
      end

      def convert(str)
        if converter
          converter.call(str)
        else
          str
        end
      end

      def resolve
        return if @resolved
        if parent
          parent.resolve
        else
          resolve_children
        end
      end

      def resolve_children
        @names.each { |name| @namespace.resolve(name) }
        @references.each do |ref|
          ref.resolved_to = @names.detect { |nm| nm.local_name == ref.name }
        end
        @children.each(&:resolve_children)
        @resolved = true
      end
    end
  end
end
