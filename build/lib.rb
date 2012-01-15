module Lib
  include Rake::DSL
end

require_relative './utils'
require_relative './compiler'
require_relative './concat'
require_relative './lessc'
require_relative './expose'
