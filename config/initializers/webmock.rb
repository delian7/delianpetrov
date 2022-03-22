if Rails.env.test?
  require 'webmock'
  WebMock.disable_net_connect!
end
