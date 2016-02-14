class User < ActiveRecord::Base
  has_many :posts
  def full_name
    "#{self.first_name} #{self.last_name} from #{self.city}"
  end
end
