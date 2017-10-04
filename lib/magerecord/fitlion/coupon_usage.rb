require 'composite_primary_keys'

module MageRecord
  class CouponUsage < ActiveRecord::Base
    self.table_name = :salesrule_coupon_usage

    # note: requires composite_primary_keys gem specific to installed version of ActiveRecord
    # (see https://github.com/composite-primary-keys/composite_primary_keys)
    self.primary_keys = :coupon_id, :customer_id

    belongs_to :coupon
    belongs_to :customer
  end
end
