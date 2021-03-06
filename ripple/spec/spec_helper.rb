$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'riak-client','lib'))

require 'rubygems' # Use the gems path only for the spec suite
require 'ripple'
require 'ripple/conflict/test_helper'
require 'rspec'

# Only the tests should really get away with this.
Riak.disable_list_keys_warnings = true

Dir[File.join(File.dirname(__FILE__), "support", "*.rb")].sort.each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.after(:each) do
    $test_server.recycle if $test_server
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.debug = true
  config.include Ripple::Conflict::TestHelper
end
