module Spree
  module Admin
    class RatesController < ResourceController

      before_filter :load_product

      def load_product
        @product = Spree::Product.find_by_permalink(params[:product_id])
      end

      def collection_url
        admin_product_rates_path
      end

      def edit_object_url(rate)
        edit_admin_product_rate_path(:product_id => rate.variant.product.permalink, :id => rate.id)
      end

      def object_url(rate)
        admin_product_rate_path(:product_id => rate.variant.product.permalink, :id => rate.id)
      end

      # TODO: revisar parametro de params[:rate]
      def create
        @rate = Spree::Rate.new(:variant_id => params[:rate][:variant_id])
        if @rate.save
          @rate.set_option_values(params)
          flash[:success] = flash_message_for(@rate, :successfully_created)
          redirect_to admin_product_rates_path(params[:product_id])
        else
          invalid_resource!(@rate)
        end
      end

      def update
        @rate = Spree::Rate.find(params[:id])
        @rate.variant_id = params[:rate][:variant_id]
        if @rate.save
          @rate.set_option_values(params)
          flash[:success] = flash_message_for(@rate, :successfully_updated)
          redirect_to admin_product_rates_path(params[:product_id])
        else
          invalid_resource!(@rate)
        end
      end

    end
  end
end