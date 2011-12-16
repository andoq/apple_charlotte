class Comment < ActiveRecord::Base

  belongs_to :commentable

  validates_presence_of :user_name, :content

end
