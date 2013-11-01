require 'spec_helper'

describe "Static pages" do

it "should goto Organizations Page" do
	
	visit 'organization/home'
	
		click_link "Organizations"
		
		response.should contain("List of all Organizations")

end

   
   it "should Attch a File" do

	visit  'project/attach'
	
	attach_file "file", "#{Rails.root}/spec/fixtures/files/Sample.txt"

	click_button "Attach"
	
   end

it "should add an Organization" do
  	
  	visit 'organization/new'

	fill_in "name",with: "New Org"
	fill_in "orgname",with: "Organization"

	expect do

		click_button "Create"
	
	end.to change(Organization, :count).by(1)
end


it "should add a Project" do
  	
  	visit 'project/add'

	response.should contain("Create")  	
	fill_in "pname", with: "New Project"
	select "Santosh Org", :from => "orgid"

	expect do

		click_button "Create"
	
	end.to change(Project, :count).by(1)
end

it "should add  Tasks" do
  	
  	visit 'project/tasks'

	fill_in "tname1",with: "Task1"
	fill_in "tname2",with: "Task2"
	fill_in "tname3",with: "Task3"		
	fill_in "tname4",with: "Task4"
	fill_in "tname5",with: "Task5"

	expect do

		click_button "Create"
	
	end.to change(Task, :count).by(5)


end

# Test Case for Delete a Project
it "should destroy a Project" do
	
	visit 'organization/result'
 	expect { click_link('Delete') }.to change(Project, :count).by(-1)
end

# Test Case for Delete a Project
it "should destroy an Organization" do
	
	visit 'organization/organizations'
	expect { click_link('Delete') }.to change(Organization, :count).by(-1)
end


# Test Case for Delete a Task
it "should destroy a Task" do
	
	visit 'project/tresult'
	response.should contain("Tasks")
	
 	expect { click_link('Delete') }.to change(Task, :count).by(-1)
end

# Test Case For Update Project Details
it "should Update the Project Details" do
	
	visit 'organization/result'
	click_link('Edit')
	response.should contain("Update")
	fill_in "pname",with:"JAVA"
	select "Santosh Org", :from => "orgid"
	select "Large Scale", :from => "ptid"
	
	expect do
	
		click_button "Update"
		
	end.to change(Project, :count).by(0)
end

#Test Case For Update Organization Details
it "should Update an Organization Details" do
	
	visit 'organization/organizations'
	click_link('Edit')
	response.should contain("Update")
	fill_in "name",with:"Raju"
	fill_in "orgname",with:"Raju Org"
	
	expect do
	
		click_button "Update"
		
	end.to change(Organization, :count).by(0)
end


# Test Case For Update Task Details
it "should Update Task Details" do
	
	visit 'project/tresult'
	click_link('Edit')
	response.should contain("Update")
	fill_in "tname",with:"Add Footer"
	select "Project1", :from => "pid"
	
	expect do
	
		click_button "Update"
		
	end.to change(Organization, :count).by(0)
end


end
