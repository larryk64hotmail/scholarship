<cfinclude template="header.cfm" >

<cfif isdefined("form.ScholarshipID")>
	<cfset thisUUID = CreateUUID()>
	<cfquery name="insertCommitteeinvite" datasource="CBW" result="insertitemid">
		INSERT INTO zCommitteeInvitation
        (CommitteeInviteID, CompanyID, ScholarshipIDs, Firstname, Lastname, Email)
        Values
        (
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#thisUUID#">,
        	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyID#">,
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ScholarshipID#">,
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Firstname#">,
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lastname#">,
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
        )		
	</cfquery>
	
	<cfmail from="info@conklin.com" subject="Committee Invitation" to="#form.email#" type="html" >
		<a href="https://#cgi.server_name#/2v/admin/regcommittee.cfm?invitation=#thisUUID#">
			Click here to register.
		</a>
	</cfmail>

</cfif>
<!--- todo: resend invitation --->
<!--- todo: disable invitation and access --->
<!--- todo: Manage committee members access to scholarship review --->

<cfquery name="getAllInvitations">
	SELECT        CommitteeInviteID, ScholarshipIDs, Firstname, Lastname, Email, invitedate, accessdate, activeyn
	FROM            zCommitteeInvitation
</cfquery>

<cfinvoke method="get_company_scholarships" component="cfc.scholarship" returnvariable="getscholarships" >
	  <cfinvokeargument name="companyid" value="#session.companyid#" />
</cfinvoke>	

<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item"><a href="userAdmin.cfm">User Admin</a></li>
  <li class="breadcrumb-item active">Invite Committee Members</li>
</ol>
<div class="clearfix"></div>
	<section class="dashboard-header section-padding">
		<div class="container-fluid">
          	<form action="" method="post" >	
			<div class="row">
	            <div class="col-lg-4 col-md-4">
	              	<div class="card">
	                	<div class="card-header d-flex align-items-left">
	                  		<h4>Invite Committee Member</h4>
	               	 	</div>
	                	<div class="card-body">
						  <div class="form-group">
						    <label for="formGroupInput">First Name</label>
						    <input type="text" name="firstname" class="form-control" id="formGroupInput" required="true" placeholder="First Name">
						  </div>
						  <div class="form-group">
						    <label for="formGroupInput2">Last Name</label>
						    <input type="text" name="lastname" class="form-control" id="formGroupInput2" required="true" placeholder="Last Name">
						  </div>
						  <div class="form-group">
						    <label for="formGroupInput3">Email Address</label>
						    <input type="email" name="email" class="form-control" id="formGroupInput3" required="true" placeholder="someone@email.com">
						  </div>
						</div>		
					</div>
				</div>	
	            <div class="col-lg-8 col-md-8">
	              	<div class="card">
	                	<div class="card-header d-flex align-items-left">
	                  		<h4>Committee Member Access</h4>
	               	 	</div>
	                	<div class="card-body">
							<div class="form-group">
								<label for="formGroupInput5">Select scholarship(s)</label><br>
								<select class="mdb-select" id="formGroupInput5" required="true" name="scholarshipid" size="5" multiple="true" >
								    <cfoutput query="getscholarships">
								    	<option value="#ScholarshipID#">#Scholarshipname#</option>
								    </cfoutput>
								</select>								
							</div>
						  	<div class="form-group">
						    	<input type="submit" class="btn btn-success" id="formGroupInput4" required="true" value="Add Committee Member">
						  	</div>
						</div>		
					</div>
				</div>	
			</div>
			</form>
			<div class="row">
				<div class="col-lg-12 col-md-12">
	              	<div class="card">
	                	<div class="card-header d-flex align-items-left">
	                  		<h4>Sent Invitations</h4>
	               	 	</div>
	                	<div class="card-body">
						<table class="table">
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Date Sent</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
							</tr>
							<cfoutput query="getAllInvitations">
							<tr>
								<td>#Firstname# #Lastname#</td>
								<td>#Email#</td>
								<td>#dateformat(invitedate,'mm/dd/yyyy')#</td>
								<td><a href="?resend=true&CommitteeInviteID=#CommitteeInviteID#">Resend</a></td>
								<td><a href="?delete=true&CommitteeInviteID=#CommitteeInviteID#">Delete</a></td>
							</tr>		
							</cfoutput>					
						</table>
						</div>		
					</div>
				</div>	
			</row>		
			</div>
		</div>
	</section>
<div class="clearfix"></div>
<cfinclude template="footer.cfm" >      