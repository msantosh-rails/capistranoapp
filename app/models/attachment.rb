class Attachment < ActiveRecord::Base
  belongs_to :task
  attr_accessible :attach, :attachment_name
 
end
