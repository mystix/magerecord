module MageRecord
  class OrderPayment < ActiveRecord::Base
    def prepaid?
      return method != 'cashondelivery'
    end
  end
end
