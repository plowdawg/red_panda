require "red_panda/engine"
require "red_panda/models/extension"
require "red_panda/conventions/convention"
require "red_panda/conventions/mid_quarter"
require "red_panda/conventions/half_year"
require "red_panda/sql/sql_extension"

module RedPanda
  mattr_accessor :col_placed_in_service
  mattr_accessor :col_lifetime
  mattr_accessor :col_init_val
end
