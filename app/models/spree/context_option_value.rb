# frozen_string_literal: true

module Spree
  class ContextOptionValue < Spree::Base
    include Spree::RateContextMethods

    belongs_to :context, class_name: 'Spree::Context', foreign_key: 'context_id', required: false
    belongs_to :option_value, class_name: 'Spree::OptionValue', foreign_key: 'option_value_id', required: false
    has_one :value, as: :valuable
  end
end
