<cfinclude template="header.cfm" >
<cfif session.usertypeid eq 2>
	<!--- Allow --->
<cfelse>
	<cflocation url="index.cfm" addtoken="false" >
</cfif>


<script>
window.setTimeout(function() {
    $(".alert").fadeTo(200, 0).slideUp(200, function(){
        $(this).remove(); 
    });
}, 4000);
</script>

<cfparam name="url.ScholarshipID" default="0" >

<!--- Get scholarship Information --->
<cfinvoke method="get_scholarship_info" component="cfc.scholarship" returnvariable="getScholarshipInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>		



<!--- make sure they can only access their own scholarships --->
<cfif (getScholarshipInfo.companyID neq session.companyid) and url.scholarshipID neq 0>
	<div class="alert alert-danger" role="alert">
		Invalid ID
	</div>
<cfinclude template="footer.cfm" >  
<cfabort >
</cfif>


<cfif isdefined("form.ScholarshipID")>

	<cfparam name="form.content3" default="" >
	<cfparam name="form.content4" default="" >
	<cfparam name="form.content5" default="" >
	<cfif listfirst(form.ScholarshipID) eq 0>
		<!---Insert--->
		<cfinvoke method="insert_Scholarship" component="cfc.scholarship"  >
			  <cfinvokeargument name="ScholarshipName" 		value="#form.ScholarshipName#" />
			  <cfinvokeargument name="ScholarshipTypeID" 	value="#form.ScholarshipTypeID#" />
			  <cfinvokeargument name="ScholarshipAmount" 	value="#form.ScholarshipAmount#" />
			  <cfinvokeargument name="NumberofScholarships" value="#form.NumberofScholarships#" />
			  <cfinvokeargument name="ScholarshipAmount" 	value="#form.ScholarshipAmount#" />
			  <cfinvokeargument name="EnrollmentStartDate" 	value="#form.EnrollmentStartDate#" />
			  <cfinvokeargument name="EnrollmentEndDate" 	value="#form.EnrollmentEndDate#" />
			  <cfinvokeargument name="EnrollmentTypeID" 	value="#form.EnrollmentTypeID#" />
			  <cfloop index="x" from="1" to="6" >
				  <cfinvokeargument name="EligibilityQuestion#x#" 	value="#form["EligibilityQuestion" & x]#" />			  
			  </cfloop>	
			  <cfinvokeargument name="RequirementItemID" 	value="#form.RequirementItemID#" />
			  <cfinvokeargument name="heroImage" 			value="heroImage" />
			  <cfinvokeargument name="ContactPhone" 		value="#form.ContactPhone#" />
			  <cfinvokeargument name="ContactEmail" 		value="#form.ContactEmail#" />
			  <cfloop index="x" from="1" to="5" >
				  <cfinvokeargument name="Content#x#" 	value="#form["Content" & x]#" />			  
			  </cfloop>	
			  <cfinvokeargument name="scholarshipYear" 		value="#form.scholarshipYear#" />
		</cfinvoke>		
	<cfelse>

		<!---update --->	
		<cfinvoke method="update_Scholarship" component="cfc.scholarship"  >
			  <cfinvokeargument name="ScholarshipID" 		value="#listfirst(form.ScholarshipID)#" />
			  <cfinvokeargument name="ScholarshipName" 		value="#form.ScholarshipName#" />
			  <cfinvokeargument name="ScholarshipTypeID" 	value="#form.ScholarshipTypeID#" />
			  <cfinvokeargument name="ScholarshipAmount" 	value="#form.ScholarshipAmount#" />
			  <cfinvokeargument name="NumberofScholarships" value="#form.NumberofScholarships#" />
			  <cfinvokeargument name="ScholarshipAmount" 	value="#form.ScholarshipAmount#" />
			  <cfinvokeargument name="EnrollmentStartDate" 	value="#form.EnrollmentStartDate#" />
			  <cfinvokeargument name="EnrollmentEndDate" 	value="#form.EnrollmentEndDate#" />
			  <cfinvokeargument name="EnrollmentTypeID" 	value="#form.EnrollmentTypeID#" />
			  <cfloop index="x" from="1" to="6" >
				  <cfinvokeargument name="EligibilityQuestion#x#" 	value="#form["EligibilityQuestion" & x]#" />			  
			  </cfloop>	
			  <cfinvokeargument name="RequirementItemID" 	value="#form.RequirementItemID#" />
			  <cfinvokeargument name="heroImage" 			value="heroImage" />
			  <cfinvokeargument name="ContactPhone" 		value="#form.ContactPhone#" />
			  <cfinvokeargument name="ContactEmail" 		value="#form.ContactEmail#" />
			  <cfloop index="x" from="1" to="5" >
				  <cfinvokeargument name="Content#x#" 	value="#form["Content" & x]#" />			  
			  </cfloop>	
			  <cfinvokeargument name="scholarshipYear" 		value="#form.scholarshipYear#" />
		</cfinvoke>		
	</cfif>
</cfif>

<!--- Get requirement items --->
<cfinvoke method="get_requirement_items" component="cfc.scholarship" returnvariable="getRequirementItems">
</cfinvoke>		

<!--- Get scholarship types --->
<cfinvoke method="get_scholarship_type" component="cfc.scholarship" returnvariable="getScholarshipTypeItems">
</cfinvoke>		

<!--- Get Eligibility Information --->
<cfinvoke method="get_eligibility_info" component="cfc.scholarship" returnvariable="getEligibilityInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>		

<!--- Get Requirement Information --->
<cfinvoke method="get_requirement_info" component="cfc.scholarship" returnvariable="getrequirementInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>	



<cfset EligibilityPlaceholder = "Applicant must be... ">

<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <cfif getScholarshipInfo.recordcount gt 0>
	  <li class="breadcrumb-item active"><cfoutput>#getScholarshipInfo.scholarshipName#</cfoutput></li>
  <cfelse>
  	<li class="breadcrumb-item active">Add New Scholarship</li>
  </cfif>
</ol>

      <section class="dashboard-header section-padding">
      <form action="scholarshipManage.cfm?scholarshipid=<cfoutput>#url.scholarshipID#</cfoutput>" method="post" enctype="multipart/form-data">	
		<cfif isdefined("url.invalidformat")>
	        <div class="alert alert-danger" role="alert">
			  Invalid Hero Image Format.
			</div>
		</cfif>
        <div class="container-fluid">
			<ul class="nav nav-tabs" id="myTab">
				<li class="active">
					<a class="nav-link" data-toggle="tab" href="#application">Scholarship Application</a>
				</li>
				<li>
					<a class="nav-link" data-toggle="tab" href="#site">Scholarship Site</a>
				</li>
				<li>
					<a class="nav-link" data-toggle="tab" href="#heroImage">Hero Image</a>
				</li>
				<cfoutput >
				<cfif url.scholarshipid neq 0>
				<li>
					<a class="nav-link" target="_blank" href="scholarship/index.cfm?scholarshipid=#getScholarshipInfo.scholarshipID#">Preview Scholarship Site</a>
				</li>
				
				</cfif>
				<li>
					<a class="nav-link" href="scholarshipManageAddField.cfm?scholarshipid=#getScholarshipInfo.scholarshipID#" id="addfield">+ Add Fields</a>
				</li>
				</cfoutput>
			</ul>
			
				<div class="tab-content">
					<div id="application" class="tab-pane fade in active">
						<!--- Scholarship Application --->
						<cfinclude template="scholarshipManageApplication.cfm" >
					</div>
					<div id="site" class="tab-pane fade">
						<!--- Scholarship Site --->
			           	<div class="row d-flex align-items-md-stretch">
				            <!-- Create/Update Scholarship-->
				            <div class="col-lg-12 col-md-12">
				              <div class="card">
				                <div class="card-header d-flex align-items-center">
				                  <h4>Scholarship Website</h4>
				                </div>
				                <div class="card-body">
				                    <div class="form-group">
				                      	<label>Scholarship Mission Statement - Describe why you are offering the scholarship</label>
										<textarea class="form-control" rows="5" id="summernote" name="Content1" placeholder="Describe the purpose of your scholarship."><cfoutput>#getScholarshipInfo.Content1#</cfoutput></textarea>

	    		                    </div>
				                    <div class="form-group">
		 		                      	 <label>About - Describe what the scholarship is about</label>
									     <textarea class="form-control" rows="5" id="summernote2" name="Content2" placeholder="Describe what the scholarship is about"><cfoutput>#getScholarshipInfo.Content2#</cfoutput></textarea>
	    		                    </div>
									<cfoutput >
				                    <div class="form-group" style="text-align:center">    
				                    <cfif url.ScholarshipID neq 0>	   
				                      <input type="submit" value="Update Scholarship" class="btn btn-primary">
								 		<cfoutput >
									  		<input type="hidden" name="ScholarshipID" value="#url.ScholarshipID#">	
				                   		</cfoutput>
									<cfelse>
				                      <input type="submit" value="Create Scholarship" class="btn btn-primary">
									  <input type="hidden" name="ScholarshipID" value="0">	
									</cfif> 
				                    </div>
								  </cfoutput>
			                    </div>
							</div>
							</div>
						</div>
					</div>
					<div id="heroImage" class="tab-pane fade in">
						<!--- Scholarship Application --->
						<cfinclude template="scholarshipmanageheroimage.cfm" >
					</div>
					
				</div>
			
		</div>
		</form>
      </section>  	
<script>
// Warning before leaving the page (back button, or outgoinglink)
var submitted = false;
 
$(document).ready(function() {
  $("form").submit(function() {
    submitted = true;
  });
 
  window.onbeforeunload = function () {
    if (!submitted) {
      return 'Do you really want to leave the page?';
    }
  }
});
</script>      
<script>
	$('#myTab a:first').tab('show');
</script>  
<cfinclude template="footer.cfm" >        