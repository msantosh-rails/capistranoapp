class Task < ActiveRecord::Base
  attr_accessible :tname
  has_many :attachments,dependent: :destroy
  belongs_to :project
end
