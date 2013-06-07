class OrganizationController < ApplicationController
$orgedit1=""
  def home
  end

  def create
  
        
      # Checking the values of parameters
      if params[:organization]["org_name"].blank? || params[:organization]["name"].blank?
      	  		return flash[:error] = "Organization Not Created"
      end
     
      @organization = Organization.create(params[:organization])
     
     	if @organization
     		flash[:notice] = "#{params[:organization]["org_name"]}Organization Created successfully"
     		redirect_to organizations_path
     	else
     		return flash[:error] = "Organization Not Created"
  	end
  end
  
  def odelete
  	
	
	organization_name =params[:name]
	
	org=Organization.find_by_org_name(organization_name)
	if org.destroy
		
     		flash[:notice] = " #{org.org_name} Organization Deleted"
		redirect_to organizations_path
     	else
     		return flash[:error] = " #{org.org_name} Organization Not Deleted"
  	end

  end
  
  def oedit
  	@orgdetails=Organization.find_by_org_name(params[:name])
	  $orgedit1=@orgdetails.org_name
  end
  
  def orgedit
  
     # Creating Organization
 
     @org1=Organization.find_by_org_name($orgedit1)

     # Checking the values of parameters
      if params[:name].blank? || params[:orgname].blank?
      	
      		return flash[:error] = "Organization Not Updated"
      end
    
     @org1.name = params[:name]
     @org1.org_name= params[:orgname]
     
     	if @org1.save
     		
     		 flash[:notice] = "#{@org1.name} Updated successfully"
     		 redirect_to organizations_path
     	else
     		return flash[:error] = "Organization Not Updated"
  	end  
  
  end
  
  def organizations
  
	@search=Organization.page(params[:page]).per(6).search(params[:q])
	@org = @search.result
	@a=Array.new
	puts "=========================="
	
	o=Organization.all
	o.each do |t|
	@a << t.org_name
	@a << t.pcount.to_s 
	end
#	puts @a.map(&:inspect).join(', ').class

	puts "=========================="
  end
  def result
  
	  @oname=params[:name]
   
	  @v=@oname.to_i
  
 	 if params[:id]
		@v=params[:id].to_i
   	 end
  	
	  @search = Project.page(params[:page]).per(12).search(params[:q])
	  @project=@search.result
	  @projecttypes = Projecttype.all

   end
   
  def new
  end
end
