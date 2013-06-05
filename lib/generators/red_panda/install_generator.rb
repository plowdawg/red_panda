require 'rails/generators'
module RedPanda
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates',__FILE__)
    def generate_install
      #ToDo: make sure to migrate "deprications"
    end
  end
end