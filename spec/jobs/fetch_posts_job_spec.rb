require 'rails_helper'

describe FetchPostsJob do
  context 'when there is no urls directly' do
    let(:urls)      { nil }
    let(:url1)      { create(:feed_url, url: 'http://feeds.twit.tv/twit.xml') }
    let(:url2)      { create(:feed_url, url: 'http://wrong_url') }
    let!(:old_urls) { [url1, url2] }

    it 'calls posts handler and store fetched data to database' do
      VCR.use_cassette('correct_and_wrong_rss_feed_urls') do
        expect { subject.perform(urls) }.to change { Post.count }.from(0).to(10)
      end
    end
  end

  context 'when there are some urls directly' do
    let(:urls) { ['http://feeds.twit.tv/twit.xml', 'http://wrong_url'] }

    it 'calls posts handler and store fetched data to database' do
      VCR.use_cassette('correct_and_wrong_rss_feed_urls') do
        expect { subject.perform(urls) }.to change { Post.count }.from(0).to(10)
      end
    end
  end
end
