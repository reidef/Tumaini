require 'spec_helper'

describe ClientApp do
  it "should be valid" do
    FactoryGirl.build(:client_app).should be_valid
  end
  
  it "should be invalid if name is blank" do
    FactoryGirl.build(:client_app, :name => "").should_not be_valid
  end
  
  it "should be invalid if api_key is blank" do
    FactoryGirl.build(:client_app, :api_key => "").should_not be_valid
  end
  
  it "should be invalid if name has already been used" do
    FactoryGirl.create(:client_app, :name => "MyApp")
    FactoryGirl.build(:client_app, :name => "MyApp").should_not be_valid
  end
end
