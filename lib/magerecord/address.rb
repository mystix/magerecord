module MageRecord
  class Address < EavRecord
    self.table_name = :customer_address_entity

    belongs_to :customer, foreign_key: :parent_id
  end
end
