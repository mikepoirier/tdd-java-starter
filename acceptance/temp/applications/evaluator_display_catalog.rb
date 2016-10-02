require_relative './urls'
require_relative './application'

class SomeApp < Application
  def initialize
    @name = 'name'
    @dir = 'dir'
    @base_url = 'url'
    @health_url = 'health url'
    @port = 'url'
    @max_timeout_in_seconds = 90
  end
end
