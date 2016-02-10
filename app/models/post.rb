class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :text

  has_many :comments
end
