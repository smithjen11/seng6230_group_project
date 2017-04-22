class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:new, :edit, :create, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @user = current_user
  end

  # GET /orders/1/edit
  def edit
    @user = current_user
  end

  # POST /orders
  def create
    @user = current_user
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        @order_product = OrderProduct.create(order_id: @order.id, 
                        product_id: order_product_params[:order_products][:id], 
                        product_count: order_product_params[:order_products][:product_count])
        if @order_product.save
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
        else
          format.html { render :new, flash: {error: 'Order was not saved correctly.'} }
        end
      else
        format.html { render :new, notice: 'Could not save order.' }
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    @user = current_user
    order_product = OrderProduct.where(id: @order.id)
    order_product.delete_all if order_product
    OrderProduct.create(order_id: @order.id, 
                        product_id: order_product_params[:order_products][:id], 
                        product_count: order_product_params[:order_products][:product_count])
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, error: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    @user = current_user
    @order.destroy
    OrderProduct.where(order_id: @order.id).delete_all
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  def get_product_information
    product = Product.find(params[:id])
    respond_to do |format|
      format.json {render json: product.as_json}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @order_product = OrderProduct.where(order_id: params[:id]).first
      if @order_product
        @product = Product.where(id: @order_product.product_id).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_total, :payment_type, :employee, order_products_attributes: [:id, :product_count])
    end
    
    def order_product_params
      params.require(:order)
    end
    
    def set_products
      all_products = Product.all
      @products = []
      @product_prices = []
      all_products.each do |product|
        if product.count > 0
          @products.push [product.name+' ($'+product.price.round(2).to_s+')', product.id]
          @product_prices.push [product.id, product.price]
        end
      end
    end
end
