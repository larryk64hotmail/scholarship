<cfinclude template="header.cfm" >
<cfparam name="form.scholarshipYear" default="2018 - 2019" >
<cfquery name="getCommittee">	
SELECT        zCommittee.CommitteeID, zCommittee.ScholarshipID, zCommittee.UserID, zCommittee.CompanyID, zCommittee.activeYN, 
			zCommittee.dateAdded, zUser.FirstName, zUser.LastName, zScholarship.ScholarshipName, 
                         zUserRole.UserTypeID
FROM            zCommittee INNER JOIN
                         zScholarship ON zCommittee.ScholarshipID = zScholarship.scholarshipID INNER JOIN
                         zUser ON zCommittee.UserID = zUser.UserID INNER JOIN
                         zUserRole ON zUser.UserID = zUserRole.UserID
WHERE        <!---(zCommittee.UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">) and---> 
		        (zUserRole.UserTypeID IN (2,3)) and zCommittee.CompanyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#">
		        and zScholarship.scholarshipYear = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.scholarshipYear#">
		        order by scholarshipID desc
</cfquery>

<cfquery name="GetScholarshipYears">
	SELECT         distinct(scholarshipYear) as DistScholarshipYear
	FROM            zScholarship
	Where 	companyID = #session.companyID# 
</cfquery>

<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item active">User Admin</li>
</ol>
<section>
	<div class="container-fluid">
		<div class="row d-flex align-items-md-stretch">
			<div class="col-lg-6 col-md-6">
				<div class="card">
					<cfform action="" method="post">	
					<div class="input-group">
			          	<select name="scholarshipYear" class="form-control" onchange="submit();">
			          		<cfoutput query="GetScholarshipYears">
			          			<option value="#DistScholarshipYear#"<cfif DistScholarshipYear is form.scholarshipYear> Selected</cfif>>
			          				Scholarship Year #DistScholarshipYear#
			          			</option>
			          		</cfoutput>
			          	</select>
					</div>
					</cfform>

				  <div class="card-header">
				    Committee Members
				  </div>
				  <div class="card-body">
					  	<cfoutput query="getCommittee" group="scholarshipID">
						<h5>#ScholarshipName#</h5>					  		
						<ul>
					  		<cfoutput >
								<li><a href="reviewerManage.cfm?reviewer=1&userid=#UserID#&companyid=#companyid#&scholarshipid=#scholarshipid#">#FirstName# #LastName# </a></li>
					  		</cfoutput>
						</ul>
					  	</cfoutput>
				  </div>
				</div>			
			</div>
			<div class="col-lg-6 col-md-6">
				<div class="card">
				  <div class="card-header">
				    Scholarship Review Committee
				  </div>
				  <div class="card-body">
				    <h5 class="card-title">Add Committee Member</h5>
				    <p class="card-text">Add a committee member to review scholarship applications.</p>
				    <a href="committeeinvite.cfm?reviewer=add" class="btn btn-primary">Add Committee Member</a>
				  </div>
				</div>			
			</div>
		</div>
	</div>
</section>  	
<div class="clearfix"></div>
<cfinclude template="footer.cfm" >      
