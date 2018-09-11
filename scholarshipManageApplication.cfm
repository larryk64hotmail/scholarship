          
           <div class="row d-flex align-items-md-stretch">
            <!-- Create/Update Scholarship-->
            <div class="col-lg-3 col-md-6">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h4>Scholarship</h4>
                </div>
                <div class="card-body">
                  	<cfoutput >
                    <div class="form-group">
                      <label>Name of Scholarship</label>
                      <input type="text" name="ScholarshipName" placeholder="Name of Scholarship" value="#getScholarshipInfo.ScholarshipName#" class="form-control" required="true">
                    </div>
                    <div class="form-group">
                      <label>Scholarship Academic Year</label>
                      	<cfset lastYear = dateformat(dateadd("yyyy",4,now()),'yyyy')>
                      	
						<select name="scholarshipYear" class="form-control">
							<cfloop index="x" from="2018" to="#lastYear#" >
								<option value="#x# - #x + 1#" <cfif getScholarshipInfo.scholarshipYear is "#x# - #x + 1#">Selected</cfif>>#x# - #x + 1#</option>
							</cfloop>
						</select>
                    </div>
                    <div class="form-group">
                      <label>Type of Scholarship</label>
                      <select name="ScholarshipTypeID" class="form-control" required="true">
                      	<option value="">Scholarship Type</option>
                      	<cfloop query="getScholarshipTypeItems">
	                      	<option value="#ScholarshipTypeID#" <cfif getScholarshipInfo.ScholarshipTypeID eq ScholarshipTypeID>Selected</cfif>>#ScholarshipTypeDesc#</option>
                      	</cfloop>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Scholarship Amount - $</label>
                      <input type="number" name="ScholarshipAmount" placeholder="2000.00" value="#numberformat(getScholarshipInfo.ScholarshipAmount,"_.00")#" class="form-control" required="true">
                    </div>
                    <div class="form-group">
                      <label>Number of Scholarship(s)</label>
                      <input type="number" name="NumberofScholarships" placeholder="Number of Scholarship(s)" value="#getScholarshipInfo.NumberofScholarships#" class="form-control" required="true">
                    </div>
					<div class="form-group">
						<label>Enrollment Start Date</label>
                		<input type="date" value="#dateformat(getScholarshipInfo.EnrollmentStartDate,'yyyy-mm-dd')#" name="EnrollmentStartDate" placeholder="mm/dd/yyyy"   class="form-control" required="true">
                    </div>
					<div class="form-group">
						<label>Enrollment Close Date</label>
                		<input type="date"  value="#dateformat(getScholarshipInfo.EnrollmentEndDate,'yyyy-mm-dd')#" name="EnrollmentEndDate" placeholder="mm/dd/yyyy" class="form-control" required="true">
                    </div>
                    <div class="form-group">
                      <label>Contact Phone Number</label>
                      <input type="text" name="ContactPhone" placeholder="" value="#getScholarshipInfo.ContactPhone#" class="form-control" required="true">
                    </div>
                    <div class="form-group">
                      <label>Contact Email</label>
                      <input type="email" name="ContactEmail" placeholder="" value="#getScholarshipInfo.ContactEmail#" class="form-control" required="true">
                    </div>
					<!---<div class="form-group">
						<label>Enrollment Type</label>
                		<select name="EnrollmentTypeID" class="form-control" required="true">
                			<option value="">Select Enrollment Type</option>
                			<option value="1" <cfif getScholarshipInfo.EnrollmentTypeID eq 1>selected</cfif>>Private - Invitation only</option>
                			<option value="2" <cfif getScholarshipInfo.EnrollmentTypeID eq 2>selected</cfif>>Public</option>
                		</select>
                    </div>--->
                    <input type="hidden" name="EnrollmentTypeID" value="2">
                </div>
              </div>
        	</div>    
            <!-- Create/Update eligibility-->
            <div class="col-lg-4 col-md-6">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h4>Eligibility</h4>
                </div>
                <div class="card-body">
                <cfloop index="x" from="1" to="6">
                    <div class="form-group">
                      <label>Eligibility Item #x#</label>
                      <textarea name="EligibilityQuestion#x#" id="eligibility_question#x#" 
                      	class="form-control" 
                      	placeholder="#EligibilityPlaceholder#" 
                      	onfocus="this.placeholder = ''" 
                      	<cfif x eq 1>required="true"</cfif>>#getEligibilityInfo.EligibilityQuestion[x]#</textarea>	
                    </div>
				</cfloop>
                </div>
              </div>
        	</div>    
			</cfoutput>
            <!-- Create/Update Requirements-->
            <cfset requirementsList = valuelist(getRequirementInfo.requirementItemId)>
            <div class="col-lg-5 col-md-6">
              <div class="card">
                <div class="card-header d-flex align-items-center">
                  <h4>Requirements</h4>
                </div>
	                <div class="card-body">
	                	<ul>
	                		<cfoutput query="getRequirementItems">
	                		<li>
		                		<label class="form-check-label">
									<input type="checkbox" class="form-check-input" <cfif listfind(requirementsList,getRequirementItems.RequirementItemID)>checked</cfif>  id="checkboxSuccess" name="RequirementItemID" value="#RequirementItemID#"> #RequirementItem#
					    		</label>
	                		</li>
	                		</cfoutput>
	                	</ul>
					</div>
					<cfoutput >
                    <div class="form-group" style="text-align:center">    
                    <cfif url.ScholarshipID neq 0>	   
                      <input type="submit" value="Update Scholarship" class="btn btn-primary">
				 		<cfoutput >
					  		<input type="hidden" name="ScholarshipID" value="#url.ScholarshipID#">	
                   		</cfoutput>
					<cfelse>
                      <input type="submit" value="Create Scholarship" class="btn btn-primary">
					  <input type="hidden" name="ScholarshipID" value="0">	
					</cfif> 
                    </div>
				  </cfoutput>
                </div>
              </div>
        	</div>   