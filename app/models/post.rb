# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  description  :text             default(""), not null
#  link         :string           default(""), not null
#  publish_date :datetime
#  source       :string           default(""), not null
#  source_url   :string           default(""), not null
#  title        :string           default(""), not null
#
# Indexes
#
#  index_posts_on_title_and_source  (title,source) UNIQUE
#
class Post < ApplicationRecord
end
