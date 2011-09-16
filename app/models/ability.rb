class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    cannot :manage, Organization
    cannot :manage, ClientApp
    can :read, User, :organization_id => user.organization_id
    can :update, User, :id => user.id
    
    cannot :manage, :all if user.new_record? # guest user gets no privlages
    can :manage, :all if user.admin?
  end
end
