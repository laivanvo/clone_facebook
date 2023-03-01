class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Post
    else
      can :read, Post
    end
  end
end
