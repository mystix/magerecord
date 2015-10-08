module MageRecord
  # add custom fitnessfirst-specific order methods
  class FfOrder < Order
    default_scope { where store_id: 2 }

    belongs_to :club
    belongs_to :trainer
  end
end
