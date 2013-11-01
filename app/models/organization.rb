class Organization < ActiveRecord::Base
  attr_accessible :name, :org_name, :pcount
  validates_uniqueness_of :org_name
  has_many :projects,dependent: :destroy
end
