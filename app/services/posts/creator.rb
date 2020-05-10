# Service of storing new posts in batches in the database
#
# @arguments:
#   posts_data [Array<Hash>] array of posts(feeds items)
#     example:
#       [
#         {
#           "title"        => "Some Title",
#           "source"       => "Some Source",
#           "source_url"   => "http://soem_source_url",
#           "link"         => "http://some_link",
#           "publish_date" => "2020-05-09 12:45",   # can be nil
#           "description"  => "Some Description"
#         },
#       ]
#
#  @additional_info:
#    if there is some column missing this data will be ignored
#    if the post already stored in database then it will be ignored and don't be stored twice
#      it will be checked by title and source so these columns are unique together
#      validations will be skipped there
#
class Posts::Creator
  COLUMNS = %w(title source source_url link publish_date description).freeze

  attr_reader :posts_data

  def initialize(posts_data)
    @posts_data = posts_data
    @records    = []
  end

  def create_new_posts
    build_records_from_posts_data
    import_records_in_batches
  end

  private

  attr_reader :records

  def build_records_from_posts_data
    posts_data.each do |post_data|
      records << new_record(post_data) if post_data_valid?(post_data)
    end
  end

  def post_data_valid?(post_data)
    post_data.is_a?(Hash) && post_data.keys == COLUMNS
  end

  def new_record(post_data)
    post_data.values
  end

  def import_records_in_batches
    Post.import(COLUMNS, records, on_duplicate_key_ignore: { conflict_target: [:title, :source], columns: COLUMNS },
                                  validate: false)
  end
end
