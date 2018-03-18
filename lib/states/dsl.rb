require "states/dsl/version"

require "json"

require "states/dsl/error_support"
require "states/dsl/state_like"
require "states/dsl/choice"
require "states/dsl/variable_condition"
require "states/dsl/variable_choice"
require "states/dsl/catch"
require "states/dsl/choices"
require "states/dsl/condition_group"
require "states/dsl/context"
require "states/dsl/execution_context"
require "states/dsl/fail"
require "states/dsl/namespace"
require "states/dsl/naming"
require "states/dsl/parallel"
require "states/dsl/resource_lookup"
require "states/dsl/retry"
require "states/dsl/state"
require "states/dsl/state_machine"
require "states/dsl/state_name"
require "states/dsl/state_reference"
require "states/dsl/trait"
require "states/dsl/variable_condition_part"
require "states/dsl/wait"

module States
  module Dsl

    def self.parse(file)
      Parser.load(file).state_machines
    end


    class Parser
      attr_reader :state_machines

      def initialize
        @state_machines = []
      end

      def self.load(filename)
        parser = new
        parser.instance_eval(File.read(filename), filename)
        parser
      end

      def state_machine(options={}, &block)
        sm = StateMachine.new(options)
        sm.instance_eval(&block)
        @state_machines << sm
        sm
      end
    end
  end
end
