class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
        can :manage, :all
    elsif user.role == 'user'
        can :read, Ttt
        can :manage, Ttt do |target_ttt|
          user.id == target_ttt.p1.to_i
        end
        can :manage, Ttt do |target_ttt|
          user.id == target_ttt.p2.to_i
        end
        can :create, Ttt
        # can :manage, Movie do |target_movie|
        #   user == target_movie.users.first
        # end
        # cannot :destroy, Recipe
        # can :read, Ingredient
        # can :read, Category
        # can :update, User do |target_user|
        #   user == target_user
        # end
    else
        can :create, User
    end
  end

end
