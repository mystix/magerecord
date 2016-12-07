module MageRecord
  class Order < ActiveRecord::Base
    self.table_name = :sales_flat_order

    scope :cash, -> { joins(:payment).where("#{OrderPayment.table_name}.method = ?", 'cashondelivery') }
    scope :cheque, -> { joins(:payment).where("#{OrderPayment.table_name}.method = ?", 'checkmo') }

    belongs_to :customer

    has_one :billing_address, -> { where address_type: 'billing' }, class_name: :OrderAddress, foreign_key: :parent_id
    has_one :shipping_address, -> { where address_type: 'shipping' }, class_name: :OrderAddress, foreign_key: :parent_id

    has_many :items, class_name: :OrderItem
    has_many :products, through: :items
  end
end
