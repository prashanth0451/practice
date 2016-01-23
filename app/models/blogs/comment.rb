class Blogs::Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, type: String
  field :author,  type: String

  validates_presence_of :comment, :author

  belongs_to :blog
  belongs_to :user
end