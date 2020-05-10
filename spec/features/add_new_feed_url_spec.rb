require 'rails_helper'

feature 'Fetch new posts', type: :feature do
  scenario 'create new feed url and parse feed items' do
    visit '/cp/feed_urls'
    click_link 'New feed url'
    fill_in 'Url', with: 'http://feeds.twit.tv/twit.xml'
    click_button 'Create Feed url'
    expect(page).to have_content 'FeedUrl was successfully created.'
    visit '/cp/posts'
    expect(page).to have_content 'Posts'
    expect(page.has_selector?('tbody tr')).to be true
  end
end
