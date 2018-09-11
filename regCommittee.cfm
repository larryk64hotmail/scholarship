<!--- for committee member registration --->
<cfif isdefined("form.password")>
	
	<cfquery name="getInvite">
		Select * from zCommitteeInvitation
		Where CommitteeInviteID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invitation#">
	</cfquery>
		
	<cfset variables.hashedPassword = Hash(form.password, "SHA-512") />
	<cfinvoke method="insert_users" component="cfc.user"  >
		  <cfinvokeargument name="firstName" value="#form.firstname#" />
		  <cfinvokeargument name="lastName" value="#form.lastName#" />
		  <cfinvokeargument name="Email" value="#form.Email#" />
		  <cfinvokeargument name="password" value="#variables.hashedPassword#" />
		  <cfinvokeargument name="scholarshipid" value="#form.scholarshipid#" />
		  <cfinvokeargument name="userrole" value="3" />
		  <cfinvokeargument name="committeemember" value="true" />
		  <cfinvokeargument name="companyID" value="#getInvite.companyID#" />
	</cfinvoke>
	<cflocation url="index.cfm" addtoken="no" >
</cfif>


<cfif isdefined("url.invitation")>
	<cfquery name="getInvite">
		Select * from zCommitteeInvitation
		Where CommitteeInviteID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.invitation#">
	</cfquery>
	
	<cfif getInvite.recordcount eq 0>
		<cflocation url="login.cfm" addtoken="false" >
	</cfif>
<cfelse>
	<cflocation url="login.cfm" addtoken="false" >
</cfif>

	<cfquery name="getInvite">
		Select * from zCommitteeInvitation
		Where CommitteeInviteID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.invitation#">
	</cfquery>



<!--- Get scholarship Information --->



<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><cfoutput>Committee</cfoutput>  Registration</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Fontastic Custom icon font-->
    <link rel="stylesheet" href="css/fontastic.css">
    <!-- Google fonts - Roboto -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
    <!-- jQuery Circle-->
    <link rel="stylesheet" href="css/grasp_mobile_progress_circle-1.0.0.min.css">
    <!-- Custom Scrollbar-->
    <link rel="stylesheet" href="vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="img/favicon.ico">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>

  <body>
  	
    <div class="page login-page">
      <div class="container">
        <div class="form-outer text-center d-flex align-items-center">
          <div class="form-inner">
            <div class="logo text-uppercase">
            	<span>Committee</span><strong class="text-primary"> Registration</strong> 
            </div>

            <form class="text-left form-validate" action="regCommittee.cfm" method="post" >
              <div class="form-group-material">
                <input id="register-firstname" type="text" name="firstname" required data-msg="Please enter your first name" value="<cfoutput>#getInvite.firstname#</cfoutput>" class="input-material">
                <label for="register-firstname" class="label-material">First Name</label>
              </div>
              <div class="form-group-material">
                <input id="register-lastname" type="text" name="lastname" required data-msg="Please enter your last name" value="<cfoutput>#getInvite.lastname#</cfoutput>" class="input-material">
                <label for="register-lastname" class="label-material">Last Name</label>
              </div>
              <div class="form-group-material">
                <input id="register-email" type="email" name="Email" required data-msg="Please enter a valid email address" value="<cfoutput>#getInvite.email#</cfoutput>" class="input-material">
                <label for="register-email" class="label-material">Email Address</label>
              </div>
              <div class="form-group-material">
                <input id="password" type="password" name="password" required data-msg="Please enter your password" class="input-material">
                <label for="password" class="label-material">Password</label>
              </div>
              <div class="form-group-material">
                <input id="confirm_password" type="password" name="confirm_password" required data-msg="Please confirm your password" class="input-material">
                <label for="confirm_password" class="label-material">Confirm Password</label>
              </div>
              <div class="form-group terms-conditions text-center">
                <input id="register-agree" name="registerAgree" type="checkbox" required value="1" data-msg="Your agreement is required" class="form-control-custom">
                <label for="register-agree">I agree with the terms and policy</label>
              </div>
              <div class="form-group text-center">
                <input id="register" type="submit" value="Register" class="btn btn-primary">
                <cfoutput >
					<input type="hidden" name="invitation" value="#url.invitation#">                	
					<input type="hidden" name="scholarshipID" value="#getInvite.scholarshipids#">                	
					<input type="hidden" name="CompanyID" value="#getInvite.CompanyID#">                	
                </cfoutput>	
              </div>
            </form>
            <cfoutput >
	            <small>Already have an account? </small><a href="login.cfm" class="signup">Login</a>
            </cfoutput>
			<p style="color:#ffffff">scholarship registration page scholarship registration page scholarship registration</p>
          </div>
          <div class="copyrights text-center">
            <!---<p>Design by <a href="https://bootstrapious.com" class="external">Bootstrapious</a></p>--->
            <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
          </div>
        </div>
      </div>
    </div>
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <!-- Main File-->
    <script src="js/front.js"></script>
  </body>
</html>