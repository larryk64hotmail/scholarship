<cfinclude template="header.cfm" >
<cfif isdefined("form.ScholarshipID")>
	<!---  --->
</cfif>

<!--- returns all scholarships for this company and select those scholarships that are associated with this user. --->
<cfinvoke method="get_Committee_scholarships" component="cfc.scholarship" returnvariable="getscholarships" >
	  <cfinvokeargument name="companyid" value="#session.companyid#" />
	  <cfinvokeargument name="userid" value="#url.userid#" />
</cfinvoke>	

<cfinvoke method="get_user_info" component="cfc.user" returnvariable="GetUserInfo" >
	  <cfinvokeargument name="userid" value="#url.userid#" />
</cfinvoke>	



<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item"><a href="userAdmin.cfm">User Admin</a></li>
  <li class="breadcrumb-item active">Manage Reviewers</li>
</ol>
<div class="clearfix"></div>
	<section class="dashboard-header section-padding">
		<div class="container-fluid">
			<div class="row d-flex align-items-md-stretch">
	            <div class="col-lg-3 col-md-5">
	              	<div class="card">
	                	<div class="card-header d-flex align-items-left">
	                  		<h4>Reviewer</h4>
	               	 	</div>
	                	<div class="card-body">
			            <form action="" method="post" >	
						  <div class="form-group">
						    <label for="formGroupInput">First Name</label>
						    <input type="text" class="form-control" id="formGroupInput" required="true" placeholder="First Name" value="<cfoutput>#GetUserInfo.firstname#</cfoutput>">
						  </div>
						  <div class="form-group">
						    <label for="formGroupInput2">Last Name</label>
						    <input type="text" class="form-control" id="formGroupInput2" required="true" placeholder="Last Name" value="<cfoutput>#GetUserInfo.Lastname#</cfoutput>">
						  </div>
						  <div class="form-group">
						    <label for="formGroupInput3">Email Address</label>
						    <input type="email" class="form-control" id="formGroupInput3" required="true" placeholder="someone@email.com" value="<cfoutput>#GetUserInfo.email#</cfoutput>">
						  </div>
						  <div class="form-group">
						    <input type="submit" class="btn btn-success" id="formGroupInput4" required="true" value="Update Access">
						  </div>
							
						</div>	
					</div>
				</div>		
	            <div class="col-lg-9 col-md-7">
	              	<div class="card">
	                	<div class="card-header d-flex align-items-left">
	                  		<h4>Review Access</h4>
	               	 	</div>
	                	<div class="card-body">
							<div class="form-group">
								<label for="formGroupInput5">Check or Un-check to add or remove from committee</label>
								<cfoutput query="getscholarships">	
								<div class="form-check">	
									<input class="form-check-input" 
									type="checkbox" 
									value="#ScholarshipID#" 
									id="defaultCheck#ScholarshipID#" 
									name="scholarshipid"
									<cfif val(selecteduserid) neq 0> checked="true"</cfif>
									>
									<label for="defaultCheck#ScholarshipID#">#Scholarshipname#</label>		
								</div>	
								</cfoutput>
							</div>
						</div>		
					</div>
				</form>

				</div>		
			</div>
		</div>
	</section>
<div class="clearfix"></div>
<cfinclude template="footer.cfm" >      