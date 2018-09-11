
<cfinclude template="header.cfm" >

<cfif session.UserTypeID eq 2>
	<cfquery name="getAppliedfor">
		SELECT        count(*) as AppliedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#">
	</cfquery>
	
	<cfquery name="getreviewed">
		SELECT        count(*) as reviewedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#"> 
				 and ReviewComplete = 1
	</cfquery>
	
	<cfquery name="getUnreviewed">
		SELECT        count(*) as unreviewedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#"> 
				 and ReviewComplete = 0
	</cfquery>
	
	
      <!-- Counts Section -->
      <section class="dashboard-counts section-padding">
        <div class="container-fluid">
          <div class="row">
            <!-- Applications-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-user"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getAppliedfor.AppliedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
            <!-- Reviewed Applications-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Reviewed Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getreviewed.reviewedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
            <!-- Un-Reviewed Applications -->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Un-Reviewed Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getUnreviewed.unreviewedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Header Section-->
      <section class="dashboard-header section-padding">
        <div class="container">
          <div class="row d-flex align-items-md-stretch">
						<!-- Availiable scholarships-->
            <div class="col-lg-9 col-md-6">
                <div>
					<cfinclude template="scholarshipCard.cfm" >
                </div>
            </div>
          	            <!-- recent applications-->
            <div class="col-lg-3 col-md-6">
				<cfinclude template="recentApplicationCard.cfm" >
            </div>
          </div>
        </div>
      </section>
<cfelseif  session.UserTypeID eq 1>
	<cfquery name="getAppliedfor">
		SELECT        count(*) as AppliedCount
		FROM            zApplication
		Where UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.Userid#">
	</cfquery>
	
	<cfquery name="reviewComplete">
		SELECT        count(*) as reviewCompleteCount
		FROM            zApplication
		Where UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.Userid#"> and ReviewComplete = 0
	</cfquery>
	
	<cfquery name="reviewed">
		SELECT        count(*) as reviewedcount
		FROM            zApplication
		Where UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.Userid#"> and ReviewComplete = 1
	</cfquery>
	
	
      <!-- Counts Section -->
      <section class="dashboard-counts section-padding">
        <div class="container-fluid">
          <div class="row">	
		  	<h2>Application Status</h2>	
		  </div>
          <div class="row">
            <!-- Count item widget-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase">Applied</strong><span>Current Year - 2018</span>
                  <div class="count-number"><cfoutput>#getAppliedfor.AppliedCount#</cfoutput></div>
                </div>
              </div>
            </div>
            <!-- Count item widget-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase">Reviewed </strong><span>Current Year - 2018</span>
                  <div class="count-number"><cfoutput>#reviewed.reviewedcount#</cfoutput></div>
                </div>
              </div>
            </div>
            <!-- Count item widget-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase">Awaiting Review</strong><span>Current Year - 2018</span>
                  <div class="count-number"><cfoutput>#reviewComplete.reviewCompleteCount#</cfoutput></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>      
      
      <!-- Header Section-->
      <section class="dashboard-header section-padding">
        <div class="container">
          <div class="row d-flex align-items-md-stretch">
          	            <!-- recent applications-->
						<!-- Availiable scholarships-->
            <div class="col-lg-9 col-md-6" style="text-align:center;">
                <div>
					<cfinclude template="scholarshipCard.cfm" >
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
				<!---<cfinclude template="recentApplicationCard.cfm" >--->
            </div>
          </div>
        </div>
      </section>
<cfelse>
	<cfquery name="getAppliedfor">
		SELECT        count(*) as AppliedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#">
	</cfquery>
	
	<cfquery name="getreviewed">
		SELECT        count(*) as reviewedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#"> 
				 and ReviewComplete = 1
	</cfquery>
	
	<cfquery name="getUnreviewed">
		SELECT        count(*) as unreviewedCount
		FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID
		Where companyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyid#"> 
				 and ReviewComplete = 0
	</cfquery>
	
	
      <!-- Counts Section -->
      <section class="dashboard-counts section-padding">
        <div class="container-fluid">
          <div class="row">
            <!-- Applications-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-user"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getAppliedfor.AppliedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
            <!-- Reviewed Applications-->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Reviewed Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getreviewed.reviewedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
            <!-- Un-Reviewed Applications -->
            <div class="col-xl-4 col-md-4 col-6">
              <div class="wrapper count-title d-flex">
                <div class="icon"><i class="icon-padnote"></i></div>
                <div class="name"><strong class="text-uppercase"><a href="review.cfm" style="text-decoration: none;">Un-Reviewed Applications</a></strong><span>Period: 2018-2019</span>
                  <div class="count-number"><a href="review.cfm" style="text-decoration: none;"><cfoutput>#getUnreviewed.unreviewedCount#</cfoutput></a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Header Section-->
      <section class="dashboard-header section-padding">
        <div class="container">
          <div class="row d-flex align-items-md-stretch">
						<!-- Availiable scholarships-->
            <div class="col-lg-9 col-md-6">
                <div>
					<cfinclude template="scholarshipCard.cfm" >
                </div>
            </div>
          	            <!-- recent applications-->
            <div class="col-lg-3 col-md-6">
				<cfinclude template="recentApplicationCard.cfm" >
            </div>
          </div>
        </div>
      </section>
      </cfif>
<cfinclude template="footer.cfm" >
