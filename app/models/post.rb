class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :text
  belongs_to :users
end
