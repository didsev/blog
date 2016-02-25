class User < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :city

  has_and_belongs_to_many :posts
  
  def full_name
    "#{self.first_name} #{self.last_name} from #{self.city}"
  end
end
