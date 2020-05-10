require 'rails_helper'

describe Posts::Creator do
  subject { described_class.new(posts_data) }

  describe 'create_new_posts' do
    context 'when there is uniq data' do
      let(:posts_data) do
        [
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
          },
        ]
      end

      it 'creates two posts' do
        expect { subject.create_new_posts }.to change { Post.count }.from(0).to(2)
      end
    end

    context 'when there is some duplications' do
      let(:posts_data) do
        [
          {
            'title'        => 'Test title',
            'source'       => 'Test source',
            'source_url'   => 'http://test_source_url',
            'link'         => 'http://test_link',
            'publish_date' => '2020-05-09 13:40',
            'description'  => 'Test description'
          },
          {
            'title'        => 'Test title',
            'source'       => 'Test source',
            'source_url'   => 'http://test_source_url',
            'link'         => 'http://test_link',
            'publish_date' => '2020-05-09 13:40',
            'description'  => 'Test description'
          },
        ]
      end

      it 'creates one post' do
        expect { subject.create_new_posts }.to change { Post.count }.from(0).to(1)
      end
    end

    context 'when there is old data(already stored)' do
      let!(:old_post) { create(:post) }

      let(:posts_data) do
        [
          {
            'title'        => old_post.title,
            'source'       => old_post.source,
            'source_url'   => old_post.source_url,
            'link'         => old_post.link,
            'publish_date' => old_post.publish_date,
            'description'  => old_post.description
          }
        ]
      end

      it 'does not create a post' do
        expect { subject.create_new_posts }.to_not change { Post.count }
      end
    end
  end
end
