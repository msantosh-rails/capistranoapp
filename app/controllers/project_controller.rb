class ProjectController < ApplicationController
  $prgedit1=""
  $tedit1=""
  def addproject
  
   	@f=Project.new

        # Checking the values of parameters      
        if params[:pname].blank? || params[:orgid]=="Select Organization" || params[:orgid]=="Select project type"
      	
        	return flash[:error] = "Project Not Created"
        end
	
	# Adding project to the Projects table
  	@f.pname=params[:pname]
     	@f.projecttypes_id=params[:ptid]
     	@f.organization_id=params[:orgid]
	
	if @f.save
     		
#     		return flash[:notice] = "Project Created successfully"
		org=Organization.find_by_id(params[:orgid])
		pcountinc=org.pcount+1
		puts "===================="
		puts pcountinc
		org.pcount= pcountinc
		org.save
		flash[:notice] = "#{@f.pname} Project Created successfully"
		redirect_to projects_path
     	else
     		return flash[:error] = "Project Not Created"
  	end
  end
 
  def addtask
  
  	if params[:pid]=="Select Project"

     		return flash[:error] = "Please Choose A Project"
     	elsif params[:tname].empty?
     		return flash[:error] = "Task Not Created"
     	end
  
   		tsk=Task.new  		 			
		tsk.tname=params[:tname]
		tsk.project_id=params[:pid]
	  
	if tsk.save	
	  
		prj=Project.find_by_id(params[:pid])
		tcountinc=prj.tcount+1
		puts "===================="
		puts tcountinc
		prj.tcount= tcountinc
		prj.save
	       	
     		flash[:notice] = "One Task is Created successfully"
		redirect_to tasks_path
	else
	  	return flash[:error] = "Task Not Created"
  	end
	  
	  
	if params[:file]
  		last=Task.find_by_tname(params[:tname])
		id=last.id

        	params[:file].each do |file|

		multiple_attachment=Attachment.new
		multiple_attachment.attachment_name = file.original_filename
		multiple_attachment.task_id=id
		multiple_attachment.attach = file.read()
		multiple_attachment.save
		     
             end
	end
	
  
  end
 
  def addtasks

	a=Array.new
  	a << params[:tname1]
  	a << params[:tname2]
  	a << params[:tname3]  	  	
  	a << params[:tname4]
  	a << params[:tname5]  	  	
  	count=0
  	a.each do |value|
  			if !value.empty?

	  			@p=Task.new  		 			
	  			@p.tname=value
	  			@p.project_id=params[:pid]
				@p.save
				count=count+1
  			end
  	end
  
  		prj=Project.find_by_id(params[:pid])
		  	
  		  	
  	if params[:pid]=="Select Project"

     		return flash[:error] = "Please Choose A Project"

     	elsif count==0
     		
     		return flash[:error] = "Task Not Created"
		
     	elsif count >=1
		
		tcountinc=prj.tcount+count
		prj.tcount= tcountinc
		prj.save
     		
     		 flash[:notice] = "#{count} Tasks are Created successfully"
		 redirect_to tasks_path
  	end
  end
 
  def add
  end
  
  def projects
	
	@search=Project.page(params[:page]).per(3).search(params[:q])
	@project= @search.result	

	@s1=Projecttype.search(params[:q])
	@projecttypes =@s1.result
	
	
 end
  
  def attachment

     # Checking the values of parameters
	if params[:file].blank?
   	
   		return flash[:error] = "Please Choose a File "    

   	elsif params[:pid]=="Select Task"

   		return flash[:error] = "Please Choose a Task "       		
   	end
 
 
      pid= params[:pid]

	attachcount=0     
     params[:file].each do |file|

		multiple_attachment=Attachment.new
		multiple_attachment.attachment_name = file.original_filename
		multiple_attachment.task_id=pid
		multiple_attachment.attach = file.read()
		multiple_attachment.save
		attachcount=attachcount+1			     
     end
	
	if attachcount==0
     		
     		return flash[:error] = "File Not Attached"
     	elsif attachcount==1
     		flash[:notice] = "One File has been Attached successfully..."
     		redirect_to attachments_path
     	else
     		flash[:notice] = "#{attachcount} Files has been Attached successfully..."
     		redirect_to attachments_path     		
  	end     

     end
   
    def download
    
   	 attach_name = params[:name]
	 f = Attachment.find_by_attachment_name(attach_name)
	 send_data f.attach, :filename => "#{attach_name}" , :disposition => 'attachment'
 
    end
     
    def delete
    
	project_name =params[:name]

	prg=Project.find_by_pname(project_name)
	
	if prg.destroy
		org=Organization.find_by_id(prg.organization_id)
		pcountinc=org.pcount-1
		puts "===================="
		puts pcountinc
		org.pcount= pcountinc
		org.save

     		flash[:notice] = " #{prg.pname} Project Deleted Successfully"
		redirect_to projects_path
     	else
     		return flash[:error] = " #{prg.pname} Not Deleted"
  	end
    
    end
    
  
  def edit
  
 	 @prgdetails=Project.find_by_pname(params[:name])
	 $prgedit1=@prgdetails.pname
  end
  
  def prgedit
  
      prg1=Project.find_by_pname($prgedit1)

     # Checking the values of parameters      
      if params[:pname].blank? || params[:orgid]=="Select Organization" || params[:orgid]=="Select project type"
      		
      		return flash[:error] = "Project Not Updated"
      end
	
	# Adding project to the Projects table
  	prg1.pname=params[:pname]
     	prg1.projecttypes_id=params[:ptid]
     	prg1.organization_id=params[:orgid]
	
	if prg1.save

     		flash[:notice] = "#{prg1.pname} Project Updated successfully"
     		redirect_to projects_path
     	else
     		return flash[:error] = "Project Not Updated"
  	end
    
   end
   
   def tresult
   
   	#To Store Selected Project id
        @pid=params[:name].to_i

   	@pname=Project.find_by_id(@pid)
	# to Store organization id
	#@oid=params[:id]

   	if params[:id]
		@pid=params[:id].to_i
	end
	#@tnames=Kaminari.paginate_array(@p).page(params[:page]).per(2)
	@attachsearch=Attachment.page(params[:page]).per(14).search(params[:q])
	@attachment=@attachsearch.result
	#@p=Project.page(params[:page]).per(5)
	
   end

    def tdelete
    
	task_name =params[:name]
	
	task=Task.find_by_tname(task_name)
	if task.destroy
		
		prj=Project.find_by_id(task.project_id)
		tcountinc=prj.tcount-1
		prj.tcount= tcountinc
		prj.save
		
     		flash[:notice] = " #{task.tname}  Deleted"
     		redirect_to tasks_path
     	else
     		return flash[:error] = " #{task.tname} Not Deleted"
  	end
    
    end

  def tedit
  
  	@taskdetails=Task.find_by_tname(params[:name])
  	$tedit1=@taskdetails.tname
  end

 def taskedit
  
      		task1=Task.find_by_tname($tedit1)
	
		task1.tname=params[:tname]  
		task1.project_id=params[:pid]

			if task1.save
				flash[:notice] = "#{task1.tname} is Updated successfully"
				redirect_to tasks_path
			else
		     		return flash[:error] = "Task Not Updated"
		     	end
 end    
 
 before_filter :set_search

  def set_search
  
		@search  = Project.search(params[:q])
		@search1 = Task.search(params[:q])
  end

 def tasks
 
	@search = Task.page(params[:page]).per(6).search(params[:q])
	@pj = @search.result
	
 end
  
def attachments

        @search=Attachment.page(params[:page]).per(6).search(params[:q])
	@attach=@search.result
	#@att=Kaminari.paginate_array(@p1).page(params[:page]).per(3)
 end


end


