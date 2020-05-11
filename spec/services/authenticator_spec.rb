require 'rails_helper'

describe Authenticator do
  subject { described_class.new(host_config) }

  let(:host_config) do
    {
      host:      'test_host',
      auth_path: '/authenticate',
      login:     'test',
      password:  'password'
    }
  end
  let(:response) { double(:response, body: response_body.to_json, code: response_code)}

  describe 'authenticate' do
    before(:each) do
      RequestSender.any_instance
                   .stub(:send_request)
                   .with(:post, host_config[:auth_path], login:    host_config[:login],
                                                         password: host_config[:password])
                   .and_return(response)
    end

    context 'when credentials are valid' do
      let(:response_body) do
        {
          login: host_config[:login],
          token: '123qwe'
        }
      end
      let(:response_code) { 200 }

      it 'sets token' do
        subject.authenticate

        expect(subject.authenticated?).to be true
        expect(subject.token).to eq('123qwe')
        expect(subject.error).to be nil
      end
    end

    context 'when credentials are not valid' do
      let(:response_body) { 'some auth error' }
      let(:response_code) { 401 }

      it 'sets error' do
        subject.authenticate

        expect(subject.authenticated?).to be false
        expect(subject.token).to be nil
        expect(subject.error).to eq('"some auth error"')
      end
    end
  end
end
