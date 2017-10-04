module MageRecord
  class Coupon < ActiveRecord::Base
    self.table_name = :salesrule_coupon
    self.inheritance_column = :_type_disabled
  end
end
