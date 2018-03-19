require 'spec_helper'
require 'states/dsl'

RSpec.describe States::Dsl::Retry do

  it "should support error equals as option" do
    subject = described_class.new(error_equals: ["MyError"])
    expect(subject.serializable_hash).to include("ErrorEquals" => ["MyError"])
  end
end
