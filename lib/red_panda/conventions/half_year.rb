module RedPanda
  class HalfYear
    
    def to_s
      "HY"
    end
    
    def get_rate(*args)
      asset = args[0]
      tax_year = args[1]
      tax_year ||= (Time.now.year - 1)
      if asset.send(RedPanda.col_placed_in_service).year == tax_year or (asset.send(RedPanda.col_placed_in_service).year + asset.send(RedPanda.col_lifetime) -1) == tax_year
        return 0.5
      elsif asset.send(RedPanda.col_placed_in_service).year > tax_year
        return 0.0
      else
        return 1.0
      end
    end
  end
end