class Blog
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title, type: String
  field :content, type: String
  field :status, type: Boolean, default: true

  has_mongoid_attached_file :image

  validates_presence_of :title, :content
  validates_uniqueness_of :title
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :comments, class_name: 'Blogs::Comment'
  belongs_to :user
end
