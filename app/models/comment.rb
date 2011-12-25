class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true

  validates_presence_of :user_name, :content

end
