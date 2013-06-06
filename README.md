# RedPanda

##Installation
Add to GemFile:

>> "red_panda","~>0.0.1.pre2"

Then run the boot generator which accepts in order: col placed in service, col lifetime, col initial value.

>> rails g red_panda:boot purchase_date lifetime purchase_price

Then add the extension to your assets you want to depricate:

```ruby
include RedPanda::Extension
```

##Supports

Red_Panda tries to conform to IRS publication 946 and supports:

- Any property that does not fall under the mid-month convention (Residential and Some RR Property)
- GDS Recovery Period

Red_Panda does not support:

- Automated checks
- ADS Recovery Period
- Completion of form 4562

Red_Panda is used at the risk of the programmer and any company choosing to use it in their own software.
While Red_Panda was designed we tried to implement it according to IRS publication 946 acuratly.  However,
no responsibility for any malfunction of Red_Panda can be given to Red_Panda or its creators.  This software
is provided as-is with no waranty written or implied.  Proceed with use at own risk.

##Use

The RedPanda model extension (RedPanda::Extension) provides methods that can be used directly on the object itself.

```ruby
@asset.get_convention #=> Will return string "HY" or "MQ" depending on the year placed in service

@asset.get_convention_rate #=> Returns percentage bassed on convention (given as decimal ie 80% = 0.8)

# Anything that takes year or tax_year, if not given will default to last years tax year
# So, if it is 2013 then the determined tax year will be 2012

@asset.get_remaining_life(year=nil) #=> Returns the amount of life remaining as an integer. 

@asset.get_adjusted_basis(year=nil) #=> Returns the value of the asset after applying previous years adjustments

@asset.get_depreciation_amount(year=nil)  #=> Gives the amount that can be used for that year's depreciation

```

ActiveRecord is lacking in support for an agnostic way to add an integer to a date so, RedPanda implements agnostic_date_add
which takes an argument on the date column followed by the integer column and what you want to add it to.

For example:

```ruby
Asset.find(agnostic_date_add("purchase_date","lifetime year"))
```

Year can be any of the following:

- Day
- Month
- Year

The method `agnostic_date_add` does not support all databases and may not be tested on some.  The following have implementations

- Sqlite3 (implemented and tested)
- MySql2 (implemented not tested)
- PostgreSQL (implemented not tested)

*Note:* This _probably_ will not work in JRuby at the current time, but should be easy to implement

###How to get deductions for assets placed in service before the tax year which have not expired:

```ruby
@assets = Asset.where(agnostic_date_add("purchase_date","lifetime year")+"> ? AND purchase_date < ?",Date.today,Date.today).all
```


This project rocks and uses MIT-LICENSE.