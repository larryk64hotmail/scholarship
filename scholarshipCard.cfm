
<!--- Get Company --->
<cfinvoke method="get_company" component="cfc.scholarship" returnvariable="get_company_info">
</cfinvoke>	
<!--- Get company scholarships--->
<cfinvoke method="get_company_scholarships" component="cfc.scholarship" returnvariable="getCompanyScholarships">
</cfinvoke>	

<cfinvoke method="get_student_applied_for_Scholarship" component="cfc.scholarship" returnvariable="GetStudentAppliedForScholarship">
	<cfinvokeargument name="userid" value="#session.userid#" />
</cfinvoke>	



		<div class="container"  style="text-align:center">
			<div class="row d-flex align-items-md-stretch">
			<!--- remove cfif if you want to display company info --->	
			<cfif session.companyid eq 0>
			<div class="col-lg-12 col-md-12" >
              	<div class="card">
                	<div class="card-body">
						<cfoutput >
				  			<h2>
				  				#get_company_info.CompanyName# #session.companyid#
				  			</h2>
				  		</cfoutput>
					</div>	
						
				</div>
			</div>		
			</cfif>
			<!--- Company --->
			<cfif session.usertypeid eq 2>	
				<cfoutput query="getCompanyScholarships" >
		            <div class="col-lg-6 col-md-12" style="min-width:18rem;">
		              	<div class="card">
		                	<div class="card-body">
							    <h5 class="card-title">#ScholarshipName#</h5>
							    <!---<h6 class="card-subtitle mb-2 text-muted">#get_company_info.CompanyName#</h6>--->
							    <p class="card-text">#NumberofScholarships# - #dollarformat(ScholarshipAmount)# Scholarships</p>
							    <p><a href="scholarshipmanage.cfm?scholarshipID=#scholarshipid#" class="btn btn-primary">Manage Scholarship</a></p>
							    <p><a href="scholarship/index.cfm?scholarshipID=#scholarshipid#" class="btn btn-primary" target="_blank" >Preview Scholarship</a></p>
							</div>		
						</div>
					</div>	
				</cfoutput>	
			<!--- Student --->	
			<cfelseif session.usertypeid eq 1>
				<cfoutput query="GetStudentAppliedForScholarship" >
		            <div class="col-lg-6 col-md-12" style="min-width:18rem;">
		              	<div class="card">
		                	<div class="card-body">
							    <h5 class="card-title">#ScholarshipName#</h5>
							    <!---<h6 class="card-subtitle mb-2 text-muted">#get_company_info.CompanyName#</h6>--->
							    <p class="card-text">#NumberofScholarships# - #dollarformat(ScholarshipAmount)# Scholarships</p>
							    
								<p>
                			<cfif session.profileComplete eq 1>
	                			<a href="ScholarshipApplication.cfm?ScholarshipID=#scholarshipID#" class="btn btn-primary">Select Scholarship</a>
							<cfelse>
								<a href="account.cfm?ScholarshipID=#scholarshipID#&C=1" class="btn btn-primary">Select Scholarship</a>
							</cfif>
								
									<!---<a href="ScholarshipApplication.cfm?ScholarshipID=#scholarshipid#" class="btn btn-primary">Select Scholarship</a>--->
								</p>
							</div>		
						</div>
					</div>	
				</cfoutput>	
			<cfelse>
			<!--- Committee Member --->
			</cfif>	
			</div>
		</div>



			




			

 	
