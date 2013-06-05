class Asset < ActiveRecord::Base
  include RedPanda::Extension
  attr_accessible :lifetime, :name, :purchase_date, :purchase_price
end
