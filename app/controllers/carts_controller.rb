class CartsController < ApplicationController
  before_action :load_product, only: :create
  before_action :current_order, only: :show

  def show
    @order_details = []
    session[:cart].each do |item|
      @order_details << OrderDetail.new item
    end
  end

  def create
    order_detail = OrderDetail.new cart_params
    result = find_product_in_cart order_detail.product_id
    check_cart order_detail, result
    redirect_to cart_path
  end

  private

  def cart_params
    params.permit :product_id, :quantity
  end

  def load_product
    current_order
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end

  def find_product_in_cart product_id
    session[:cart].find do |item|
      item if item["product_id"] == product_id
    end
  end

  def check_quantity result, quantity
    if result["quantity"] + quantity > @product.quantity
      flash[:danger] = t ".invalid_quantity"
    else
      result["quantity"] += quantity
    end
  end

  def check_cart order_detail, result
    if order_detail.quantity.nil? || order_detail.quantity <= 0
      flash[:danger] = t ".fail_add_cart"
    elsif result
      check_quantity result, order_detail.quantity
    else
      session[:cart] << order_detail
      flash[:success] = t ".success_add_cart"
    end
  end
end
