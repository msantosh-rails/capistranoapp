require 'factory_girl'

FactoryGirl.define :Organization do |f|
  f.id 201
  f.name "ss"
  f.org_name "org1"
  f.created_at 10
  f.updated_at 10
end



=begin
FactoryGirl.define do
factory :Organization do
  name "ss"
  org_name "org1"
end
Factory.define :baby do |f|
  f.name "Billy"
  f.age 12
=end

