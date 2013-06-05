require 'date'
module RedPanda
  module Extension
    #Add to asset by include RedPanda::Extension
    def get_convention
      #This is CPU intensive, but it is probably best to leave it this way
      model = self.class.name.constantize
      date = Date.new(self.send(RedPanda.col_placed_in_service).year,1,1)
      assets = model.where("#{RedPanda.col_placed_in_service} >= ? and #{RedPanda.col_placed_in_service} < ?",date,date.next_year).all
      last_quarter_count = assets.count{|asset| !!(Date::MONTHNAMES[asset.send(RedPanda.col_placed_in_service).month] =~ /(oct|nov|dec)/i)}
      if (last_quarter_count.to_f/assets.size) < 0.4
         convention = RedPanda::HalfYear.new 
      else
        convention = RedPanda::MidQuarter.new
      end
      convention
    end
    
    def get_convention_rate(year=nil)
      year ||= Time.now.year - 1
      get_convention.get_rate(self,year)
    end
    
    def get_remaining_life(year=nil)
      year ||= Time.now.year - 1
      amount = self.send(RedPanda.col_placed_in_service).year + self.send(RedPanda.col_lifetime) - year
      if amount < 0
        return 0
      else
        return amount
      end
    end
    
    def get_adjusted_basis(year=Time.now.year-1)
      #subtract all prev years
      value = self.send(RedPanda.col_init_val)
      for i in self.send(RedPanda.col_placed_in_service).year .. (year-1)
        value = value -(value * get_convention_rate(i) * (1.0/get_remaining_life(i).to_i))
      end
      value
    end
    
    def get_deprication_amount(year=Time.now.year-1)
      get_adjusted_basis(year) * get_convention_rate(year) * (1.0/get_remaining_life(year).to_i)
    end
    
  end
end