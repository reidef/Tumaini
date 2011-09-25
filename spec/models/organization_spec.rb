require 'spec_helper'

describe Organization do
  it "should be valid" do
    FactoryGirl.build(:organization).should be_valid
  end
  
  it "is invalid if name is blank" do
    FactoryGirl.build(:organization, :name => "").should_not be_valid
  end
  
  it "is invalid if organization name already exists" do
    FactoryGirl.create(:organization, :name => "My App")
    FactoryGirl.build(:organization, :name => "My App").should_not be_valid
  end
end
