class Project < ActiveRecord::Base
  attr_accessible :pname, :ptypeid,:tcount
  
  belongs_to :organization 
  belongs_to :projectype
  has_many :tasks,dependent: :destroy
  

  
  
  
end
