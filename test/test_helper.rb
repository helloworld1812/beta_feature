ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rails/test_help'

require 'beta_feature'

class ActiveSupport::TestCase
  setup do
    ActiveRecord::Migration.verbose = false
  end

  def load_schema( version )
    load File.dirname(__FILE__) + "/db/version_#{version}.rb"
  end
end
