# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :set_checkout, except: :create

  def create
    @checkout = Checkout.create
    render json: @checkout
  end

  def destroy
    @checkout.destroy
    create
  end

  def add
    product = Product.find(params[:product_id])
    AddProductToCheckout.call(product, @checkout)
    render json: @checkout
  end

  private

  def checkout_id
    params[:id]
  end
end
