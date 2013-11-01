require 'spec_helper'

describe ProjectController do

describe "routing" do
	
		
	it " Routes to Tasks page" do
	
		expect(:get => "/tasks").to route_to(:controller => "project", :action => "tasks")
	
	end

	it " Routes to Attachments page" do
	
		expect(:get => "/attach").to route_to(:controller => "project", :action => "attach")
	
	end	
end
  
  describe "POST 'addproject'" do
    it "returns http success" do
      post 'addproject'
      response.should be_success
   
    end
  end

  describe "GET 'add'" do
    it "returns http success" do
      get 'add'
      response.should be_success
   
    end
  end

  describe "POST 'attachment'" do
    it "returns http success" do
      post 'attachment'
      response.should be_success
   
    end
  end

end
