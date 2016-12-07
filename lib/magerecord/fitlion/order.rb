module MageRecord
  # add custom FitLion-specific order methods
  class Order < ActiveRecord::Base
    # ignore canceled orders
    default_scope { where state: [:processing, :complete] }
    scope :delivery, -> { where shipping_method: [:flatrate_flatrate, :addon_addon] }
    scope :collection, -> { where "#{Order.table_name}.shipping_method LIKE 'selfcollect%'" }
    scope :prepaid, -> { joins(:payment).where("#{OrderPayment.table_name}.method NOT IN (?, ?)", 'cashondelivery', 'checkmo') }

    def for_delivery?
      %w{flatrate addon}.include? shipping_method.split('_').first
    end

    def for_collection?
      shipping_method.include? 'selfcollect'
    end
  end
end
