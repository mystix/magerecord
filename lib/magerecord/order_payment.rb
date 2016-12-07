module MageRecord
  class OrderPayment < ActiveRecord::Base
    self.table_name = :sales_flat_order_payment

    belongs_to :order, foreign_key: :parent_id


    def cash?
      return method == 'cashondelivery'
    end

    def cheque?
      return method == 'checkmo'
    end
  end
end
