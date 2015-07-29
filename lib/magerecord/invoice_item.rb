module MageRecord
  # invoice items can be parents / children of other invoice items
  # (only within the same order)
  class InvoiceItem < ActiveRecord::Base
    self.table_name = :sales_flat_invoice_item
    self.primary_key = :entity_id

    belongs_to :order_item, class_name: :OrderItem
    belongs_to :parent, class_name: :InvoiceItem, foreign_key: :parent_item_id
    belongs_to :product

    # note: add an index on the column "parent_item_id" to
    # *dramatically* speed up loading of child order items from the parent order item
    has_many :children, class_name: :InvoiceItem, foreign_key: :parent_item_id


    # call associated product's method
    def method_missing(meth, *args, &block)
      if product && product.respond_to?(meth)
        product.send(meth)
      else
        # call superclass's method_missing method
        # or risk breaking Ruby's method lookup
        super
      end
    end


    def respond_to?(meth, include_private = false)
      super || (product && product.respond_to?(meth))
    end
  end
end
