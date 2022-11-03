
class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/:id
  def show
    render json: @product
  end

  # GET /products/:length/:width/:height/:weight
  def show_best_fit
    @product = Product.where(
      :length.gte => params[:length],
      :width.gte => params[:width],
      :height.gte => params[:height],
      :weight.gte => params[:weight]
    ).order_by(:volume.asc, :weight.asc).first
    
    if @product
      render json: @product, status: :found
    else
      render status: :not_found
    end
  end


  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end
end
