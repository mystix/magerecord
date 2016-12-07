module MageRecord
  # add custom FitLion-specific order methods
  class Order < ActiveRecord::Base
    # mysql regex for postal codes that are in town
    TOWN_REGEX = '^(0[1-9]|10|1[78]|2[2-4])'

    # ignore canceled orders
    default_scope { where state: [:processing, :complete] }

    scope :prepaid, -> { joins(:payment).where("#{OrderPayment.table_name}.method NOT IN (?, ?)", 'cashondelivery', 'checkmo') }

    scope :delivery, -> { where shipping_method: [:flatrate_flatrate, :addon_addon] }
    scope :collection, -> { where "#{Order.table_name}.shipping_method LIKE 'selfcollect%'" }

    scope :town, -> { joins(:shipping_address).where("sales_flat_order_address.postcode RLIKE ?", TOWN_REGEX) }
    scope :residential, -> { joins(:shipping_address).where("sales_flat_order_address.postcode NOT RLIKE ?", TOWN_REGEX) }


    def for_delivery?
      %w{flatrate addon}.include? shipping_method.split('_').first
    end

    def for_collection?
      shipping_method.include? 'selfcollect'
    end
  end
end
