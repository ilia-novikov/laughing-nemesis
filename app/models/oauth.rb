class Oauth
  require 'uri'
  require 'json'
  require 'digest/sha2'

  def initialize (code)
    require 'net/http'
    require 'net/https'
    #Constants:
    client_id = '754054970160.apps.googleusercontent.com'
    client_secret = 'Ze7WAc-7MKdYZ3SRElNGaLgv'
    redirect_uri = URI.encode('http://localhost:3000/oauth')
    #Get access token from code
    access_uri = URI.parse('https://accounts.google.com/o/oauth2/token')
    access_connection = Net::HTTP.new(access_uri.host, access_uri.port)
    access_connection.use_ssl =true
    access_request = Net::HTTP::Post.new(access_uri.request_uri)
    access_request.set_content_type('application/x-www-form-urlencoded')
    access_parameters = {:code => code, :client_id => client_id, :client_secret => client_secret, :redirect_uri => redirect_uri, :grant_type => 'authorization_code'}
    access_request.set_form_data(access_parameters)
    access_response = access_connection.request(access_request)
    auth = ActiveSupport::JSON.decode(access_response.body)
    unless auth.nil? or auth['access_token'].blank?
      #Auth and get user info
      auth_uri = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{auth['access_token']}")
      auth_http = Net::HTTP.new(auth_uri.host, auth_uri.port)
      auth_http.use_ssl =true
      auth_response = auth_http.request(Net::HTTP::Get.new(auth_uri.request_uri))
      @info = ActiveSupport::JSON.decode(auth_response.body)
    end
  end

  def get (option)
    @info[option] unless @info.nil? or @info[option].nil?
  end

  def get_session_params
    salt_prefix = 'PSRel2jsk51bK43MsZ8y'
    salt_postfix = 'm6Pm938H815GJx6fr5j5'
    password = Digest::SHA2.hexdigest("#{salt_prefix}#{self.get('id')}#{salt_postfix}").to_s[0..30]
    {:name => self.get('name'), :email => self.get('email'), :password => password, :password_confirmation => password, :options => 'oauth=true'}
  end
end