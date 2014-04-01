module MageRecord
  # allows us to make queries like: "List all supplements"
  class ProductAttributeSet < ActiveRecord::Base
    self.table_name = :eav_attribute_set

    default_scope { where entity_type_id: 4 }

    alias_attribute :name, :attribute_set_name


    has_many :products, foreign_key: :attribute_set_id
  end
end
