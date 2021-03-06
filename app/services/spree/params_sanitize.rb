# frozen_string_literal: true

module Spree
  class ParamsSanitize
    def initialize(klass:, params:)
      @klass = klass
      @params = params
    end

    def call
      klass_option_types = find_option_types

      klass_params = params.require(klass).permit(klass_option_types)

      klass_params.transform_keys { |k, _v| k.delete_prefix("#{params['product_type']}_").to_sym }
    end

    private

    def find_option_types
      Spree::ProductType.find_by(name: params['product_type'])
                        .send("#{klass}_option_types").pluck(:name)
                        .map { |context| "#{params['product_type']}_#{context}" }
    end

    attr_reader :klass, :params
  end
end
