class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user.role
    when 'admin'
      can :manage, :all
    when 'customer'
      can :read, Order
      can :create, Order
    when 'seller'
      can :read, Order
      can :update, Order, seller_id: user.seller.id
    end
  end
end
