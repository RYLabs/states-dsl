module States
  module Dsl
    module VariableCondition
      checks = {
        string_equals: "StringEquals",
        string_less_than: "StringLessThan",
        string_greater_than: "StringGreaterThan",
        string_less_than_equals: "StringLessThanEquals",
        string_greater_than_equals: "StringGreaterThanEquals",

        string_eq: "StringEquals",
        string_lt: "StringLessThan",
        string_gt: "StringGreaterThan",
        string_lte: "StringLessThanEquals",
        string_gte: "StringGreaterThanEquals",

        numeric_equals: "NumericEquals",
        numeric_less_than: "NumericLessThan",
        numeric_greater_than: "NumericGreaterThan",
        numeric_less_than_equals: "NumericLessThanEquals",
        numeric_greater_than_equals: "NumericGreaterThanEquals",

        numeric_eq: "NumericEquals",
        numeric_lt: "NumericLessThan",
        numeric_gt: "NumericGreaterThan",
        numeric_lte: "NumericLessThanEquals",
        numeric_gte: "NumericGreaterThanEquals",

        boolean_equals: "BooleanEquals",

        timestamp_equals: "TimestampEquals",
        timestamp_less_than: "TimestampLessThan",
        timestamp_greater_than: "TimestampGreaterThan",
        timestamp_less_than_equals: "TimestampLessThanEquals",
        timestamp_greater_than_equals: "TimestampGreaterThanEquals",

        timestamp_eq: "TimestampEquals",
        timestamp_lt: "TimestampLessThan",
        timestamp_gt: "TimestampGreaterThan",
        timestamp_lte: "TimestampLessThanEquals",
        timestamp_gte: "TimestampGreaterThanEquals",
      }

      checks.keys.each do |name|
        define_method name do |val|
          instance_variable_set("@#{name}".to_sym, val)
        end
      end

      define_method :condition_hash do
        h = {}
        if k = checks.keys.detect { |nm| !instance_variable_get("@#{nm}".to_sym).nil? }
          h[checks[k]] = instance_variable_get("@#{k}".to_sym)
        end
        h
      end
    end
  end
end
