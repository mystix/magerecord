module MageRecord
  class Customer < EavRecord
    self.table_name = :customer_entity

    belongs_to :store
    belongs_to :website

    has_many :addresses, foreign_key: :parent_id
    has_many :orders
  end
end
