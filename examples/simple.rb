state_machine resource: { account: "ACCOUNT", region: "REGION" } do
  comment "A state machine that submits a Job to AWS Batch and monitors the Job until it completes."

  start "Submit Job" do
    function "SubmitJob"
    result_path "$.guid"
    next_state "Wait X Seconds"
    retry_if :all do
      interval_seconds 1
      max_attempts 3
      backoff_rate 2
    end
  end

  state "Wait X Seconds" do
    wait do
      seconds_path "$.wait_time"
    end
    next_state "Get Job Status"
  end

  state "Get Job Status" do
    function "CheckJob"
    next_state "Job Complete?"
    input_path "$.guid"
    result_path "$.status"
    retry_if :all do
      interval_seconds 1
      max_attempts 3
      backoff_rate 2
    end
  end

  state "Job Complete?" do
    choices do
      variable "$.status" do
        string_eq "FAILED"
        next_state "Job Failed"
      end
      variable "$.status" do
        string_eq "SUCCEEDED"
        next_state "Get Final Job Status"
      end
      default "Wait X Seconds"
    end
  end

  state "Job Failed" do
    fail do
      cause "AWS Batch Job Failed"
      error "DescribeJob returned FAILED"
    end
  end

  state "Get Final Job Status" do
    function "CheckJob"
    input_path "$.guid"
    retry_if :all do
      interval_seconds 1
      max_attempts 3
      backoff_rate 2
    end
  end
end
