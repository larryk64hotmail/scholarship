    <!-- Side Navbar -->
    <nav class="side-navbar">
      <div class="side-navbar-wrapper">
        <!-- Sidebar Header    -->
        <div class="sidenav-header d-flex align-items-center justify-content-center">
          <!-- User Info-->
          <div class="sidenav-header-inner text-center">
          	<cfif url.sid neq 4>
          	<img src="img/Charles045_250_WEB.jpg" alt="Charles W. Herbster" class="img-fluid rounded-circle">
          	<cfelse>	
          	<img src="img/JH_alt_250_WEB.jpg" alt="Judith A. Herbster" class="img-fluid rounded-circle">
          	</cfif>	
            <h2 class="h5">Scholarship Administration</h2>
            <cfif url.sid neq 4>
	            <span>Charles W. Herbster</span>
          	<cfelse>	
	            <span>Judith Ann Herbster</span>
            </cfif>
          </div>
          <!-- Small Brand information, appears on minimized sidebar-->
          <div class="sidenav-header-logo"><a href="index.cfm" class="brand-small text-center"> <strong>S</strong><strong class="text-primary">D</strong></a></div>
        </div>
        <!-- Sidebar Navigation Menus-->
        <div class="main-menu">
          <h5 class="sidenav-heading">Main</h5>
          <ul id="side-main-menu" class="side-menu list-unstyled">                  
            <li><a href="index.cfm"> <i class="icon-home"></i>Home</a></li>
            <li><a href="#selectScholarship" aria-expanded="false" data-toggle="collapse"> <i class="icon-interface-windows"></i>Select Scholarship </a>
              <ul id="selectScholarship" class="collapse list-unstyled ">
                <li><a href="Scholarship.cfm">+ Add New Scholarship</a></li>
                <li><a href="index.cfm?sid=1">Charles W. Herbster</a></li>
                <li><a href="index.cfm?sid=2">Charles W. Herbster<br>(Fall City)</a></li>
                <li><a href="index.cfm?sid=3">Charles W. Herbster<br>(School)</a></li>
                <li><a href="index.cfm?sid=4">Judith A. Herbster</a></li>
                
              </ul>
            </li>
            <li><a href="review.cfm"> <i class="icon-form"></i>Review Applications</a></li>
            <li><a href="forms.cfm"> <i class="fas fa-user"></i> &nbsp;User Administration</a></li>
            <!---<li><a href="tables.cfm"> <i class="icon-grid"></i>Tables</a></li>--->
            <li><a href="login.cfm"> <i class="fas fa-sign-in-alt"></i> &nbsp;Login page</a></li>
            <!---<li> <a href="#"> <i class="icon-mail"></i>Demo<div class="badge badge-warning">6 New</div></a></li>--->
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
                <li class="nav-item"><a href="login.cfm" class="nav-link logout"> <span class="d-none d-sm-inline-block">Logout &nbsp;</span><i class="fas fa-sign-out-alt"></i></a></li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
      