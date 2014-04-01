module MageRecord
  class Website < ActiveRecord::Base
    self.table_name = :core_website

    has_many :customers
    has_many :stores
  end
end
