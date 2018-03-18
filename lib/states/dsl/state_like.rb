module States
  module Dsl
    class StateLike
      UNSET = Object.new

      attr_accessor :context

      def initialize(options={})
        @traits = options[:traits] || []
        @result_path = @output_path = @input_path = UNSET
        @retries = []
        @catches = []
      end

      def function(name)
        resource(context.function_resource(name))
      end

      def activity(name)
        resource(context.activity_resource(name))
      end

      def resource(arn)
        @resource = arn
      end

      def result_path(path)
        @result_path = path
      end

      def output_path(path)
        @output_path = path
      end

      def input_path(path)
        @input_path = path
      end

      def next_state(state)
        @next_state = context.naming.ref(state)
      end

      def parallel(&block)
        @parallel = Parallel.new(@context)
        @parallel.instance_eval(&block)
        @parallel
      end

      def choices(&block)
        @choices = Choices.new(@context.naming)
        @choices.instance_eval(&block)
        @choices
      end

      def wait(&block)
        @wait = Wait.new(@context.naming)
        @wait.instance_eval(&block)
        @wait
      end

      def fail(&block)
        @fail = Fail.new
        @fail.instance_eval(&block)
        @fail
      end

      def retry_if(options={}, &block)
        _retry = Retry.new(options)
        if block_given?
          _retry.instance_eval(&block)
        end
        @retries << _retry
      end

      def catch_if(options={}, &block)
        katch = Catch.new(context, options)
        if block_given?
          katch.instance_eval(&block)
        end
        @catches << katch
      end

      def serializable_hash
        j = context.lookup_traits(@traits).reduce({}) { |m, t| m.merge(t.serializable_hash) }
        if @resource
          j["Type"] = "Task"
          j["Resource"] = @resource.to_s

        elsif @parallel
          j["Type"] = "Parallel"
          j.merge!(@parallel.serializable_hash)

        elsif @choices
          j["Type"] = "Choice"
          j.merge!(@choices.serializable_hash)

        elsif @wait
          j["Type"] = "Wait"
          j.merge!(@wait.serializable_hash)

        elsif @fail
          j["Type"] = "Fail"
          j.merge!(@fail.serializable_hash)
        end

        [
          [@result_path, "ResultPath"],
          [@input_path , "InputPath" ],
          [@output_path, "OutputPath"],
        ].each { |(k,v)| j[v] = k if k != UNSET }

        unless @retries.empty?
          j["Retry"] = @retries.map(&:serializable_hash)
        end

        unless @catches.empty?
          j["Catch"] = @catches.map(&:serializable_hash)
        end

        if @next_state
          j["Next"] = @next_state.to_s
        end
        j
      end
    end
  end
end
