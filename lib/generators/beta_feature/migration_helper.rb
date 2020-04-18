module BetaFeature
  module Generators
    module MigrationHelper
      def migration_parent
        if Rails::VERSION::MAJOR == 4 
          'ActiveRecord::Migration' 
        else
         "ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]"
       end
     end
   end
 end
end
