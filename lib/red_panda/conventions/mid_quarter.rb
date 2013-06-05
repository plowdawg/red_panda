module RedPanda
  class MidQuarter
    def to_s
      return "MQ"
    end
    
    def get_rate(*args)
      asset = args[0]
      tax_year = args[1] || Time.now.year - 1
      if tax_year == asset.send(RedPanda.col_placed_in_service).year
        return get_first_year_rate(asset)
      elsif tax_year == (asset.send(RedPanda.col_placed_in_service).year + asset.send(RedPanda.col_lifetime) - 1)
        return get_last_year_rate(asset)
      elsif tax_year < asset.send(RedPanda.col_placed_in_service).year
        return 0.0 #This is ok as it will make any asset that year 0
      else
        return 1.0
      end
    end
    
    private
    def get_first_year_rate(asset)
      return (((4-get_quarter(asset)) * 3.0) + 1.5)/12.0
    end
    
    def get_last_year_rate(asset)
      return (((get_quarter(asset)-4).abs * 3.0) + 1.5)/12.0
    end
    
    def get_quarter(asset)
      pis_date = Date::MONTHNAMES[asset.send(RedPanda.col_placed_in_service).month]
      if !!(pis_date =~ /(jan|feb|mar)/i)
        return 1
      elsif !!(pis_date =~ /(apr|may|jun)/i)
        return 2
      elsif !!(pis_date =~ /(jul|aug|sep)/i)
        return 3
      else
        return 4
      end
    end
    
  end
end