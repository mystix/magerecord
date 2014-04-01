module MageRecord
  class Product < EavRecord
    self.table_name = :catalog_product_entity

    alias_attribute :type, :type_id


    belongs_to :product_attribute_set, foreign_key: :attribute_set_id

    has_one :stock

    has_many :items, class_name: :OrderItem
    has_many :orders, through: :items


    def qty
      stock.qty.to_i
    end


    def in_stock?
      stock.is_in_stock?
    end


    def enabled?
      # note: a magento product's enabled/disabled status is stored in EAV attribute code "status"
      # 1 = enabled, 2 = disabled
      status.to_i == 1
    end


    def set
      # return product's attribute set
      product_attribute_set.attribute_set_name
    end
  end
end
