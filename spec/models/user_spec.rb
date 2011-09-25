require 'spec_helper'

describe User do
  it "is valid" do
    FactoryGirl.build(:user).should be_valid
  end
  
  it "is invalid with blank password" do
    FactoryGirl.build(:user, :password => "").should_not be_valid
  end
  
  it "is invalid with blank password confirmation" do
    FactoryGirl.build(:user, :password_confirmation => "").should_not be_valid
  end
  
  it "is invalid when password and confirmation do not match" do
    FactoryGirl.build(:user, :password => "secret", :password_confirmation => "not secret").should_not be_valid
  end
  
  it "is invalid with blank email" do
    FactoryGirl.build(:user, :email => "").should_not be_valid
  end
  
  it "is invalid with if email already exists" do
    FactoryGirl.create(:user, :email => "user@example.com")
    FactoryGirl.build(:user, :email => "user@example.com").should_not be_valid
  end
  
  it "is invalid if email isn't properly fomed" do
    FactoryGirl.build(:user, :email => "user@example").should_not be_valid
    FactoryGirl.build(:user, :email => "userexample.com").should_not be_valid
    FactoryGirl.build(:user, :email => "userexamplecom").should_not be_valid
  end
  
  it "has a authorization token generated when it is created" do
    FactoryGirl.build(:user).auth_token.should be_nil
    FactoryGirl.create(:user).auth_token.should_not be_nil
  end
  
  it "has a token generated for specified column" do
    user = FactoryGirl.build(:user)
    user.generate_token(:auth_token)
    user.auth_token.should_not be_nil
  end
  
  it "is returned if authentication is successful" do
    user = FactoryGirl.build(:user, :password => "secret")
    user.authenticate("not secret").should be_false
    user.authenticate("secret").should_not be_nil
  end
end