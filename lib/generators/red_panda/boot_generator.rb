require 'rails/generators'
module RedPanda
  class BootGenerator < Rails::Generators::Base
    desc "Adds the initializer StraightLine to configure your db"
    source_root File.expand_path('../templates',__FILE__)
    
    def generate_boot
      #puts "All vars: #{self.inspect}"    
      template "boot_init.rb","config/initializers/red_panda.rb"
    end
    

  end
end
