require 'rails_helper'

describe Posts::Fetcher do
  subject { described_class.new(urls) }

  describe 'fetch_posts' do
    context 'when rss service is available' do
      let(:urls) { ['test_utl_1', 'test_url_2'] }
      let(:response) do
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
        RequestSender.any_instance
                     .stub(:send_request)
                     .with(:get, described_class::RSS_FEED_ITEMS_PATH, urls: urls)
                     .and_return(response.to_json)
      end

      it 'returns posts and error' do
        posts, error = subject.fetch_posts

        expect(posts.size).to eq(2)
        expect(error).to eq('Some error')
      end
    end
  end
end
