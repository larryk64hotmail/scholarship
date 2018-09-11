<cfinclude template="header.cfm" >
<cfparam name="form.ScholarshipID" default="0" >
<cfparam name="form.scholarshipYear" default="2018 - 2019" >


<cfquery name="getSelectedApps">
	SELECT        zUser.UserID, zUser.FirstName, zUser.LastName, zScholarship.ScholarshipName, zScholarship.ScholarshipID, zApplication.ApplicationID
	FROM            zApplication INNER JOIN
			zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID INNER JOIN
            zUser ON zApplication.UserID = zUser.UserID
	Where companyID = #session.companyID#  and zScholarship.ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ScholarshipID#">   
			  
	order by    zScholarship.ScholarshipName,  zUser.FirstName               
</cfquery>	

<cfquery name="GetScholarshipYears">
	SELECT         distinct(scholarshipYear) as DistScholarshipYear
	FROM            zScholarship
	Where 	companyID = #session.companyID# 
</cfquery>

<cfquery name="GetScholarships">
	SELECT         scholarshipID, datecreated, CompanyID, ScholarshipName
	FROM            zScholarship
	Where 	companyID = #session.companyID# and scholarshipYear = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.scholarshipYear)#">
</cfquery>


<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item active">Review Applications</li>
</ol>
      <!-- Header Section-->
      <section class="dashboard-header section-padding">
        <div class="container-fluid">
          <cfform action="" method="post">
          <div class="row d-flex align-items-md-stretch">
          <p>
          <div class="input-group">	
          	<select name="scholarshipYear" class="form-control" onchange="submit();">
          		<cfoutput query="GetScholarshipYears">
          			<option value="#DistScholarshipYear#"<cfif DistScholarshipYear is form.scholarshipYear> Selected</cfif>>
          				#DistScholarshipYear#
          			</option>
          		</cfoutput>
          	</select>
          </div>	
          </p>
          </div>
          </cfform>
          <cfform action="" method="post">
		  <div class="row d-flex align-items-md-stretch">
			<p>
			<div class="input-group">
				<select name="scholarshipID" onchange="submit();" class="custom-select" multiple="true">
			  		<cfoutput query="GetScholarships">
				      <option value="#scholarshipID#" <cfif form.scholarshipID eq scholarshipID>Selected</cfif>>#scholarshipyear# #ScholarshipName# </option>
			  		</cfoutput>
				</select>
				<div class="input-group-append">
					<cfoutput >
						<input type="hidden" name="scholarshipYear" value="#trim(form.scholarshipYear)#"></input>
					</cfoutput>
				</div>
			</p>
			</div>	  	
		  </div>
          </cfform>
        	
          <div class="row d-flex align-items-md-stretch">
            <!-- To Do List-->
            <cfif session.usertypeid eq 2 or session.usertypeid eq 3>
            <div class="col-lg-12 col-md-12">
              <p>
              <div class="card to-do">
              	<cfoutput query="getSelectedApps" group="ScholarshipID">
                <h3 class="display h3">#scholarshipyear# #ScholarshipName#</h3>
                <h4 class="display h4"><a href="ranking.cfm">Rankings</a></h4>
                <ul class="check-lists list-unstyled">
                  <cfoutput >
                  <li class="d-flex align-items-center"> 
                    <label for="list-1"><a href="reviewApplicant.cfm?applicationid=#ApplicationID#">#FirstName# #LastName#</a></label>
                  </li>
                  </cfoutput>	
                </ul>
				</cfoutput>
              </div>
              </p>
            </div>
            </cfif>
            </div>
        </div>
      </section>	
<cfinclude template="footer.cfm" >        