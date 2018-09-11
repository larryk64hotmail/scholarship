<cfinclude template="header.cfm" >
<!--- update user info --->
<cfif isdefined("form.email")>
	<cfinvoke method="update_user_profile" component="cfc.user">
		  <cfinvokeargument name="firstname" value="#form.firstname#" />
		  <cfinvokeargument name="lastname" value="#form.lastname#" />
		  <cfinvokeargument name="Email" value="#form.Email#" />
		  <cfinvokeargument name="phonenumber" value="#form.phonenumber#" />
		  <cfinvokeargument name="Address" value="#form.Address#" />
		  <cfinvokeargument name="City" value="#form.City#" />
		  <cfinvokeargument name="State" value="#form.State#" />
		  <cfinvokeargument name="Zipcode" value="#form.Zipcode#" />
	</cfinvoke>	
</cfif>

<cfif isdefined("form.gpa")>
	<cfinvoke method="update_user_profile_academic" component="cfc.user">
		  <cfinvokeargument name="gpa" value="#form.gpa#" />
		  <cfinvokeargument name="status" value="#form.status#" />
	</cfinvoke>	
</cfif>

<!--- update user password --->
<cfif isdefined("form.password")>
<cfset variables.hashedPassword = Hash(form.currentpassword, "SHA-512") />	
<cfset variables.newhashedPassword = Hash(form.password, "SHA-512") />	

	<cfinvoke method="update_user_password" component="cfc.user">
		  <cfinvokeargument name="password" value="#variables.hashedPassword#" />
		  <cfinvokeargument name="newpassword" value="#variables.newhashedPassword#" />
	</cfinvoke>	
</cfif>

<!--- get user info --->
<cfinvoke method="get_user_info" component="cfc.user" returnvariable="getUserInfo" >
	  <cfinvokeargument name="userid" value="#session.userid#" />
</cfinvoke>	

<script>
window.setTimeout(function() {
    $(".alert").fadeTo(200, 0).slideUp(200, function(){
        $(this).remove(); 
    });
}, 4000);
</script>


<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item active">My Account</li>
</ol>
      <section class="dashboard-header section-padding">
		<div class="container-fluid">
				<cfif isdefined("url.C")>
	            	<div class="alert alert-success" role="alert">	
	              		Please complete the Account and Academic sections before applying for scholarships.
					</div>
	            </cfif>
			<div class="row d-flex align-items-md-stretch">
	            <div class="col-lg-3 col-md-6">
	            	<form action="account.cfm" method="post" >
					<cfoutput >
	              	<div class="card">
	              		<cfif isdefined("url.account_update")>
	              		<div class="alert alert-success" role="alert">
							  Account Information Updated Successfully
						</div>
						</cfif>
	                	<div class="card-header d-flex align-items-center">
	                  		<h4>Account <span class="badge badge-danger" aria-describedby="accounthelp">required</span></h4> 
	               	 	</div>
	                	<div class="card-body">
		                    <div class="form-group">
		                      <label>First Name</label>
		                      <input type="text" name="firstname" placeholder="" value="#getUserInfo.firstname#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Last Name</label>
		                      <input type="text" name="lastname" placeholder="" value="#getUserInfo.lastname#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Email</label>
		                      <input type="email" name="email" placeholder="" value="#getUserInfo.email#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Contact Number</label>
		                      <input type="text" name="phonenumber" placeholder="" value="#getUserInfo.phonenumber#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Address</label>
		                      <input type="text" name="Address" placeholder="" value="#getUserInfo.Address#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>City</label>
		                      <input type="text" name="City" placeholder="" value="#getUserInfo.City#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>State</label>
		                      <input type="text" name="State" placeholder="" value="#getUserInfo.State#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Zip code</label>
		                      <input type="text" name="zipcode" placeholder="" value="#getUserInfo.zipcode#" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>&nbsp;</label>
		                      <input type="submit" name="update" placeholder="" value="Update" class="form-control" required="true">
		                    </div>
						</div>		
					</div>
					</cfoutput>
					</form>					
				</div>		
				
				<cfif session.UserTypeID eq 1>
	            <div class="col-lg-3 col-md-6">
	            	<form action="account.cfm" method="post" >
					<cfoutput >
	              	<div class="card">
	              		<cfif isdefined("url.academic_update")>
	              		<div class="alert alert-success" role="alert">
							  Account Information Updated Successfully
						</div>
						</cfif>
	                	<div class="card-header d-flex align-items-center">
	                  		<h4>Academic <span class="badge badge-danger">required</span></h4>
	               	 	</div>
	                	<div class="card-body">
		                    <div class="form-group">
		                      <label>Latest GPA</label>
		                      <input type="text" name="gpa" placeholder="Latest GPA" value="#decimalformat(getUserInfo.gpa)#" class="form-control" required="true">
		                    </div>
		                    
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status1" name="status" value="1" required="true" <cfif getUserInfo.status eq 1>checked</cfif>>
							  <label class="custom-control-label" for="status1"><small>I will be an incoming college freshman in the fall of 2018.</small></label>
							</div>
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status2" name="status" value="2" <cfif getUserInfo.status eq 2>checked</cfif>>
							  <label class="custom-control-label" for="status2"><small>I will graduate this Year.</small></label>
							</div>
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status3" name="status" value="3" <cfif getUserInfo.status eq 3>checked</cfif>>
							  <label class="custom-control-label" for="status3"><small>I have attended college, but have less than 32 college credit hours.</small></label>
							</div>
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status4" name="status" value="4" <cfif getUserInfo.status eq 4>checked</cfif>>
							  <label class="custom-control-label" for="status4"><small>I have attended college, but have at least 32 or more college credit hours.</small></label>
							</div>
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status5" name="status" value="5" <cfif getUserInfo.status eq 5>checked</cfif>>
							  <label class="custom-control-label" for="status5"><small>I am a Post Graduate Student</small></label>
							</div>
		                    <div class="custom-control custom-radio">
							  <input type="radio" class="custom-control-input" id="status6" name="status" value="6" <cfif getUserInfo.status eq 6>checked</cfif>>
							  <label class="custom-control-label" for="status6"><small>I am a GED graduate with no college credit hours.</small></label>
							</div>
		                    <div class="form-group">
		                      <label>&nbsp;</label>
		                      <input type="submit" name="update" placeholder="" value="Update" class="form-control" required="true">
		                    </div>
						</div>		
					</div>
					</cfoutput>
					</form>
				</div>	
				</cfif>
	            <div class="col-lg-3 col-md-6">
	            	<form action="account.cfm" method="post" >
					<cfoutput >
	              	<div class="card">
	              		<cfif isdefined("url.password_update")>
		              		<cfif url.password_update eq 1>	
			              		<div class="alert alert-success" role="alert">
									 Password Updated Successfully
								</div>
							<cfelse>
			              		<div class="alert alert-danger" role="alert">
									 Password Not Updated
								</div>
							</cfif>
						</cfif>
	                	<div class="card-header d-flex align-items-center">
	                  		<h4>Update Password</h4>
	               	 	</div>
	                	<div class="card-body">
		                    <div class="form-group">
		                      <label>Current Password</label>
		                      <input type="password" name="currentpassword" placeholder="Current Password" value="" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>New Password</label>
		                      <input type="password" id="password" name="password" placeholder="New Password" value="" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>Confirm New Password</label>
		                      <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm New Password" value="" class="form-control" required="true">
		                    </div>
		                    <div class="form-group">
		                      <label>&nbsp;</label>
		                      <input type="submit" name="update" placeholder="" value="Update" class="form-control" required="true">
		                    </div>
						</div>		
					</div>
					</cfoutput>
					</form>
				</div>	
				
			</div>
		</div>
	</section>
<div class="clearfix"></div>
<cfinclude template="footer.cfm" >      