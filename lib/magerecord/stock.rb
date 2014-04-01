module MageRecord
  class Stock < ActiveRecord::Base
    self.table_name = :cataloginventory_stock_item

    belongs_to :product
  end
end
