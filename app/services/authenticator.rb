# Service for authenticate requests to rss service
#
# @arguments:
#   host_config [Hash] config data about rss service, located in services.yml
#     host [String] host url
#     auth_path [String] a path ot authentication API
#     login [String] login
#     password [String] password
#
# @response:
#   token [String, Nil] an access token for rss service
#   error [String, Nil] an error message in case of auth failure
#
class Authenticator
  attr_reader :host_config
  attr_reader :token, :error

  def initialize(host_config)
    @host_config = host_config
    @token       = nil
    @error       = nil
  end

  def authenticate
    response = request_sender.send_request(:post, host_config[:auth_path], login:    host_config[:login],
                                                                           password: host_config[:password])
    if response.code != 200
      @error = response.body
      return
    end

    parsed_response = JSON.parse(response.body)

    @token = parsed_response['token']
  end

  def authenticated?
    error.blank?
  end

  private

  def request_sender
    @request_sender ||= ::RequestSender.new(host_config[:host])
  end
end
