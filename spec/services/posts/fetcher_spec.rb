require 'rails_helper'

describe Posts::Fetcher do
  subject { described_class.new(urls) }

  describe 'fetch_posts' do
    context 'when rss service is available' do
      let(:urls) { ['test_utl_1', 'test_url_2'] }
      let(:response) { double(:response, body: response_body.to_json, code: 200) }
      let(:response_body) do
        {
          'items' => [
            {
              'title'        => 'Test title',
              'source'       => 'Test source',
              'source_url'   => 'http://test_source_url',
              'link'         => 'http://test_link',
              'publish_date' => '2020-05-09 13:40',
              'description'  => 'Test description'
            },
            {
              'title'        => 'Test title 2',
              'source'       => 'Test source 2',
              'source_url'   => 'http://test_source_url',
              'link'         => 'http://test_link',
              'publish_date' => '2020-05-09 13:40',
              'description'  => 'Test description'
            }
          ],
          'errors' => 'Some error'
        }
      end

      before(:each) do
        allow(Authenticator).to receive(:new).and_return(authenticator)
        RequestSender.any_instance
                     .stub(:send_request)
                     .with(:get, described_class::RSS_FEED_ITEMS_PATH, urls: urls, headers: {'Token' => '123'})
                     .and_return(response)
      end

      context 'when service is authenticated' do
        let(:authenticator) { double(:authenticator, authenticate: true, authenticated?: true, token: '123') }

        it 'returns posts and error' do
          posts, error = subject.fetch_posts

          expect(posts.size).to eq(2)
          expect(error).to eq('Some error')
        end
      end

      context 'when service is not authenticated' do
        let(:authenticator) { double(:authenticator, authenticate: true, authenticated?: false, error: 'Some auth error') }

        it 'returns empty array and auth error' do
          posts, error = subject.fetch_posts

          expect(posts.size).to eq(0)
          expect(error).to eq('Some auth error')
        end
      end
    end
  end
end
