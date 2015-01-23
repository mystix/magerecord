# MageRecord RubyGem

## Introduction
Simple ActiveRecord wrapper for various Magento models.

## Installation

Add this line to your application's Gemfile:
```
gem 'magerecord'
```
And then execute:
```
$ bundle
```
Or install it yourself as:
```
$ gem install magerecord
```

## Basic Usage:
```
# require 'activerecord-jdbc-adapter' # if running jruby

# IMPORTANT: initialise magento mysql database connection
MageRecord::Connection.new 'localhost', 'db_name', 'username', 'password'


# get total number of orders
MageRecord::Order.count

# get latest order
order = MageRecord::Order.last

# get order items
order.items

# get associated products
order.products

# get customer's full name
order.customer.firstname + ' ' + order.customer.lastname

# get billing address
order.billing_address

# get shipping address
order.shipping_address


# get EAV attributes for the following Magento models:
# - MageRecord::Address
# - MageRecord::Customer
# - MageRecord::Product
MageRecord::Address.eav_attributes
MageRecord::Customer.eav_attributes
MageRecord::Product.eav_attributes


# get a product
product = MageRecord::Product.last

# get product name
product.name

# get custom product EAV attribute
# (note: these should first be defined in Magento)
product.flavor
product.size
product.color

# get product stock level
product.qty
```

## Contributing

1. Fork it ( http://github.com/[my-github-username]/magerecord/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
