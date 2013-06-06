module RedPanda
  module SqlExtension
    
    def agnostic_date_add(*args)
      #Simple possiblye col + col Type < ?
      if defined? SQLite3
        return sqlite_date_add(args)
      elsif defined? Mysql2
        return mysql2_date_add(args)
      elsif defined? PG
        #POSTGRES
        return postgres_date_add(args)
      else
        #We will use EXTRACT(YEAR/DAY/MONTH) POSSIBLY OR DATEADD or DATE_ADD Depending on DB
        throw "Unknown Database Adapter"
      end
    end
    
    private
    def postgres_date_add(args)
      # NOT SURE IF THIS WORKS!!!
      return "#{args[0]} + INTERVAL '#{args[0]}'" 
    end
    
    def mysql2_date_add(args)
      return "DATE_ADD(#{args[0]},INTERVAL #{args[1]})" #That was easy. Does it work?
    end
    
    def sqlite_date_add(args)
      #Determine the type
      first_col = args[0]
      puts "ARGS: #{args}"
      throw "SQLite ARGS are NULL" if args.nil?
      type = nil
      if !!(args[1] =~ /year/i)
        type = "YEAR"
      elsif !!(args[1] =~ /month/i)
        type = "MONTH"
      else
        type = "DAY"
      end
      col = /^\w*/.match(args[1]).to_s
     return "date(#{first_col}, '+'|| #{col}||' #{type}')"
     end
  end
end