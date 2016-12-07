module MageRecord
  class OrderHistory < ActiveRecord::Base
    self.table_name = :sales_flat_order_status_history

    belongs_to :order, foreign_key: :parent_id
  end
end
