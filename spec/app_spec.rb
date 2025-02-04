require 'rspec'
require 'rack/test'
require_relative '../app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App.app
  end

  describe 'GET /' do
    it 'returns order textarea and submit button' do
      get '/'
      expect(last_response.body).to include('<textarea name="order_lines"')
      expect(last_response.body).to include('<input type="submit"')
      expect(last_response.status).to eq(200)
    end
  end

  describe 'POST /' do
    it 'returns processed order and rerenders GET / with a summary' do
      post '/', order_lines: "10 R12\n15 L09\n13 T58"
      expect(last_response.body).to include('10 R12 12.99')
      expect(last_response.body).to include('1 x 10 $12.99')

      expect(last_response.body).to include('15 L09 41.9')
      expect(last_response.body).to include('1 x 9 $24.95')
      expect(last_response.body).to include('1 x 6 $16.95')

      expect(last_response.body).to include('13 T58 22.94')
      expect(last_response.body).to include('1 x 9 $16.99')
      expect(last_response.body).to include('1 x 3 $5.95')

      expect(last_response.status).to eq(200)
    end
  end
end