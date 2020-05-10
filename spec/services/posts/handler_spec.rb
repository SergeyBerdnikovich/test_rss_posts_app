require 'rails_helper'

describe Posts::Handler do
  subject { described_class.new(urls) }

  describe 'call' do
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
    let(:fetcher) { double(:fetcher) }
    let(:creator) { double(:creator) }

    context 'when there are urls' do
      let(:urls) { ['url1', 'url2', 'url3'] }

      before(:each) do
        allow(Posts::Fetcher).to receive(:new).with(urls).and_return(fetcher)
        allow(fetcher).to receive(:fetch_posts).and_return([response['items'], response['errors']])

        allow(Posts::Creator).to receive(:new).with(response['items']).and_return(creator)
        allow(creator).to receive(:create_new_posts)
      end

      it 'fetches and stores data for these urls' do
        expect(fetcher).to receive(:fetch_posts).and_return([response['items'], response['errors']])
        expect(creator).to receive(:create_new_posts)

        subject.call
      end
    end

    context 'when there are no urls' do
      let(:urls)      { nil }
      let(:url1)      { create(:feed_url).url }
      let(:url2)      { create(:feed_url).url }
      let!(:old_urls) { [url1, url2] }

      before(:each) do
        allow(Posts::Fetcher).to receive(:new).with(old_urls).and_return(fetcher)
        allow(fetcher).to receive(:fetch_posts).and_return([response['items'], response['errors']])

        allow(Posts::Creator).to receive(:new).with(response['items']).and_return(creator)
        allow(creator).to receive(:create_new_posts)
      end

      it 'fetches and stores data for all urls in database' do
        expect(fetcher).to receive(:fetch_posts).and_return([response['items'], response['errors']])
        expect(creator).to receive(:create_new_posts)

        subject.call
      end
    end
  end
end
