<cfif isdefined("form.password")>
	<cfset variables.hashedPassword = Hash(form.password, "SHA-512") />
	
	<cfinvoke method="get_login" component="cfc.user"  >
		  <cfinvokeargument name="Email" value="#form.Email#" />
		  <cfinvokeargument name="password" value="#variables.hashedPassword#" />
	</cfinvoke>	
	
	<cfif session.loggedin is "true">
		<cflocation url="index.cfm" addtoken="false">
	</cfif>
</cfif>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Scholarship Login</title>
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
            <div class="logo text-uppercase"><strong class="text-primary">Scholarship </span><span> Login</span></div>
            <p>Login to apply for Scholarship application</p>
            <form method="post" action="login.cfm" class="text-left form-validate">
              <div class="form-group-material">
                <input id="login-email" type="text" name="Email" required data-msg="Please enter your email address" class="input-material" required>
                <label for="login-email" class="label-material">Email</label>
              </div>
              <div class="form-group-material">
                <input id="login-password" type="password" name="Password" required data-msg="Please enter your password" class="input-material"  required>
                <label for="login-password" class="label-material">Password</label>
              </div>
              <div class="form-group text-center">
              	<input id="login" type="submit"  class="btn btn-primary" value="Login">
              	<!---<a id="login" href="index.cfm" class="btn btn-primary">Login</a>--->
                <!-- This should be submit button but I replaced it with <a> for demo purposes-->
              </div>
            </form>
            <a href="#" class="forgot-pass">Forgot Password?</a><small>Do not have an account? </small><a href="register.cfm" class="signup">Signup</a>
			<p style="color:#ffffff">Login forgot password signup link registration Login forgot password signup link registration </p>

          </div>
          <div class="copyrights text-center">
           <!--- <p>Design by <a href="https://bootstrapious.com" class="external">Bootstrapious</a></p>--->
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