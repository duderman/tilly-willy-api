# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def create
    @checkout = Checkout.create
    render json: @checkout
  end
end
