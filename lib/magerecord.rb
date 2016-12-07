require 'active_record'
require 'active_support/core_ext/string/strip'

# for establishing db connection
require 'magerecord/connection.rb'

# include models
require 'magerecord/eav_record'
require 'magerecord/address'
require 'magerecord/customer'
require 'magerecord/product'

require 'magerecord/website'
require 'magerecord/store'
require 'magerecord/product_attribute_set'
require 'magerecord/stock'
require 'magerecord/order'
require 'magerecord/order_item'
require 'magerecord/order_address'
require 'magerecord/order_history'
require 'magerecord/order_payment'
