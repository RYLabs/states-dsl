require "thor"
require "states/dsl"

module States
  module Dsl
   class CLI < Thor

     desc "parse FILE", "Convert a state machine file"
     def parse(file)
       puts Dsl.parse(file).first.to_json
     end

     default_task :parse
   end
 end
end
