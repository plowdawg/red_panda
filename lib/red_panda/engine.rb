require "rails"
module RedPanda
  class Engine < ::Rails::Engine
    isolate_namespace RedPanda
    initializer "red_panda.sql_extension" do |app|
       ActiveRecord::Base.send :extend, RedPanda::SqlExtension
       ActionController::Base.send :extend, RedPanda::SqlExtension
    end
  end
end
