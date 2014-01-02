require 'spec_helper'

describe "Wechats" do
  describe "GET /wechats" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get wechats_path
      response.status.should be(200)
    end
  end
end
