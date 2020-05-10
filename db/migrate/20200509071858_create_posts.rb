class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string    :title,        null: false, default: ''
      t.string    :source,       null: false, default: ''
      t.string    :source_url,   null: false, default: ''
      t.string    :link,         null: false, default: ''
      t.datetime  :publish_date
      t.text      :description,  null: false, default: ''

      t.index [:title, :source], unique: true
    end
  end
end
