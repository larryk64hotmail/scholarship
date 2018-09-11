            <cfquery name="getApps">
            	SELECT   top 10     zUser.UserID, zUser.FirstName, zUser.LastName, zScholarship.ScholarshipName, zApplication.ApplicationID, zApplication.ApplicationDate
				FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID INNER JOIN
                         zUser ON zApplication.UserID = zUser.UserID
				Where companyID = #session.companyID#         
				order by  zApplication.ApplicationDate desc               
            </cfquery>	
            
             <div class="container">
              <div class="card to-do">
                <h2 class="display h4">Recent Applications</h2>
                <p>Select an application to review.</p>
                <ul class="check-lists list-unstyled">
                <cfoutput query="getApps">
                  <li class="d-flex align-items-center"> 
                    <label for="list-1"><a href="reviewApplicant.cfm?ApplicationID=#ApplicationID#">#dateformat(ApplicationDate,'mm/dd/yy')# - #FirstName# #LastName# <br> #ScholarshipName#</a></label>
                  </li>
                </cfoutput>	
                </ul>
              </div>
			</div>
			