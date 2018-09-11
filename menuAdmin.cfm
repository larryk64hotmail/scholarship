<!--- get user info --->
<cfinvoke method="get_user_info" component="cfc.user" returnvariable="getUserInfo" >
	  <cfinvokeargument name="userid" value="#session.userid#" />
</cfinvoke>	

<!--- Get company scholarships--->
<cfinvoke method="get_company_scholarships" component="cfc.scholarship" returnvariable="getCompanyScholarships">
</cfinvoke>	

<cfinvoke method="get_student_applied_for_Scholarship" component="cfc.scholarship" returnvariable="GetStudentAppliedForScholarship">
	<cfinvokeargument name="userid" value="#session.userid#" />
</cfinvoke>	

    <!-- Side Navbar -->
    <nav class="side-navbar">
      <div class="side-navbar-wrapper">
        <!-- Sidebar Header    -->
        <div class="sidenav-header d-flex align-items-center justify-content-center">
          <!-- User Info-->
          <div class="sidenav-header-inner text-center">
          		<h2 class="h5"><a href="index.cfm">Scholarship Dashboard</a></h2>
          </div>
          <!-- Small Brand information, appears on minimized sidebar-->
          <div class="sidenav-header-logo"><a href="index.cfm" class="brand-small text-center"> <strong>&nbsp;</strong></a></div>
        </div>
        <!-- Sidebar Navigation Menus-->
        <div class="main-menu">
          <ul id="side-main-menu" class="side-menu list-unstyled">                  
            <li><a href="index.cfm"> <i class="icon-home"></i>Dashboard</a></li>
            
            <cfif session.UserTypeID eq 2 or session.UserTypeID eq 1>
            <li><a href="#selectScholarship" aria-expanded="false" data-toggle="collapse"> <i class="icon-interface-windows"></i>Select Scholarship </a>
              <ul id="selectScholarship" class="collapse list-unstyled ">
              	
              	<!--- Admin --->
              	<cfif session.UserTypeID eq 2>
	                <li><a href="ScholarshipManage.cfm?ScholarshipID=0">+ Add New Scholarship</a></li>
                	<cfoutput query="getCompanyScholarships" maxrows="4">
                		<li><a href="ScholarshipManage.cfm?ScholarshipID=#scholarshipID#">#ScholarshipName#</a></li>
                	</cfoutput>
                	<cfif getCompanyScholarships.recordcount gt 4>
                		<li><a href="selectScholarship.cfm">[More]</a></li>
                	</cfif>		
                </cfif>	
                
                
                <!--- Student --->
              	<cfif session.UserTypeID eq 1>
              		<cfif getUserInfo.zipcode neq "" and getUserInfo.gpa neq "">
	              		<cfset session.profileComplete = 1>
    				<cfelse>
	              		<cfset session.profileComplete = 0>
              		</cfif>
               		<cfoutput query="GetStudentAppliedForScholarship" maxrows="4">
                		<li>
                			<cfif session.profileComplete eq 1>
	                			<a href="ScholarshipApplication.cfm?ScholarshipID=#scholarshipID#">#ScholarshipName#</a>
							<cfelse>
								<a href="account.cfm?ScholarshipID=#scholarshipID#&C=1">#ScholarshipName#</a>
							</cfif>
                		</li>
                	</cfoutput>
                	<cfif GetStudentAppliedForScholarship.recordcount gt 4>
                		<li><a href="selectScholarship.cfm">[More]</a></li>
                	</cfif>		
                </cfif>
                
                
                
              </ul>
            </li>
            </cfif>

            <li>
            <cfif session.UserTypeID eq 2 or session.UserTypeID eq 3>
            	<a href="review.cfm"> <i class="icon-form"></i>Review Applications</a>
			<cfelse>
            	<!---<a href="index.cfm"> <i class="icon-form"></i>Review Applications</a>--->
            </cfif>
            </li>
            <cfif session.UserTypeID eq 2>
            	<li><a href="userAdmin.cfm"> <i class="fas fa-user"></i> &nbsp;User Administration</a></li>
			</cfif>
			<!---<li>&nbsp;</li>
          	<h5 class="sidenav-heading">Dev Links</h5>
            <li><a href="login.cfm"> <i class="fas fa-sign-in-alt"></i> &nbsp;Login page</a></li>
            <li><a href="scholarshipsAvailable.cfm"> <i class="fas fa-sign-in-alt"></i> &nbsp;User Entry Page</a></li>--->
          </ul>
        </div>

      </div>
    </nav>
        <div class="page">
      <!-- navbar-->
      <header class="header">
        <nav class="navbar">
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <div class="navbar-header"><a id="toggle-btn" href="#" class="menu-btn"><i class="icon-bars"> </i></a><a href="index.cfm" class="navbar-brand">
                  <div class="brand-text d-none d-md-inline-block"><span>Scholarship </span> <strong class="text-primary">Dashboard</strong></div></a></div>
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                <!-- Log out-->
                <li class="nav-item">
                	<cfoutput >
                		<a href="account.cfm" class="nav-link logout">#session.firstname# #session.lastname#</a>
                	</cfoutput>
                </li>
                <li class="nav-item">
                	<a href="index.cfm?logout=1" class="nav-link logout"> 
                		<span class="d-none d-sm-inline-block">Logout &nbsp;</span>
                		<i class="fas fa-sign-out-alt"></i>
                	</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
      