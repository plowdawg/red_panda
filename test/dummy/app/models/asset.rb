class Asset < ActiveRecord::Base
  include RedPanda::Extension
  #extend RedPanda::SqlExtension
  attr_accessible :lifetime, :name, :purchase_date, :purchase_price
end
