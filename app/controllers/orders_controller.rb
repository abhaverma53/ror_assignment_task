class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[show update destroy]

  rescue_from CanCan::AccessDenied do |exception|
    render json: { warning: exception, status: :authorization_failed }
  end

  def index
    @q = Order.includes(:customer, :seller).ransack(params[:q])
    @orders = @q.result(distinct: true)
    render json: @orders
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
    sign_in_user if params[:authentication_token].present?
    authorize! :read, @order
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    render json: { message: 'Order destroyed successfully' }
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:amount, :customer_id, :seller_id)
  end

  def sign_in_user
    user = User.find_by(authentication_token: params[:authentication_token])
    sign_in(user, store: false) if user
  end
end
