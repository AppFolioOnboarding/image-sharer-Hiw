ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'webmock/test_unit'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    WebMock.enable!

    # Add more helper methods to be used by all tests here...
    WebMock.stub_request(:get, 'https://www.example.com/image1.jpg')
      .to_return(status: 200, body: '', headers: {
        'Content-Type': 'image/jpg'
      })
    WebMock.stub_request(:get, 'https://www.example.com/image2.jpg')
      .to_return(status: 200, body: '', headers: {
        'Content-Type': 'image/jpg'
      })
    WebMock.stub_request(:get, 'google.com')
      .to_return(status: 200, body: '', headers: {
        'Content-Type': 'text/html'
      })
    WebMock.stub_request(:get, 'test')
      .to_return(status: 404)
  end
end
