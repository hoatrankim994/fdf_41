class CartsController < ApplicationController
  before_action :load_product, only: %i(create update)
  before_action :current_order, only: :show
  before_action :load_cart, only: %i(show update)

  def show; end

  def create
    order_detail = OrderDetail.new cart_params
    result = find_product_in_cart order_detail.product_id
    check_cart order_detail, result
    redirect_to cart_path
  end

  def update
    quantity = params[:quantity].to_i
    respond_to do |format|
      format.html{redirect_to cart_path}
      format.js
      if quantity > @product.quantity || quantity <= 0
        format.json{render json: {quantity_product: @product.quantity, message: t(".invalid_quantity")}}
      else
        result = find_product_in_cart(@product.id)
        result["quantity"] = quantity
        format.json{render json: {result: result, product: @product, order_details: @order_details}.to_json}
      end
    end
  end

  private

  def cart_params
    params.permit :product_id, :quantity, :price
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

  def load_cart
    @order_details = []
    session[:cart].each do |item|
      @order_details << OrderDetail.new(item)
    end
  end
end
