module MageRecord
  # order items can be parents / children of other order items
  # (only within the same order)
  class OrderItem < ActiveRecord::Base
    self.table_name = :sales_flat_order_item

    belongs_to :order
    belongs_to :parent, class_name: :OrderItem, foreign_key: :parent_item_id
    belongs_to :product

    # note: add an index on the column "parent_item_id" to
    # *dramatically* speed up loading of child order items from the parent order item
    has_many :children, class_name: :OrderItem, foreign_key: :parent_item_id


    # call associated product's method
    def method_missing(meth, *args, &block)
      product.nil? ? super : product.send(meth)
    end
  end
end
