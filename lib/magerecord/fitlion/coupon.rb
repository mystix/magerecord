module MageRecord
  class Coupon
    has_many :usage, class_name: 'CouponUsage'
  end
end
