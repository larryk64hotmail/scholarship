<cfparam name="URL.ScholarshipID" default="0" >

<cfif isdefined("form.action")>
	<cfquery name="appdupecheck">
		SELECT  ApplicationID, UserID, ScholarshipID, ApplicationDate, ApplicationUpdateDate
		FROM zApplication
		Where UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#"> and 
				ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#">
	</cfquery>
	<cfif appdupecheck.recordcount eq 0>
		<cfquery name="insertApplication">
			INSERT INTO zApplication
            (UserID, ScholarshipID)
			VALUES     
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#">
			)
		</cfquery>
	</cfif>
	<cfloop index="x" from="1" to="15">
		<cfif StructKeyExists(Form,"REQUIREMENTITEMID#x#")>
			<!---here--->
			<cfif form["REQUIREMENTITEMID#x#"] neq "">
				<cfset thisfilepath = expandPath( "./studentdocs/#x#")>
				<cffile result="upload"
			    action="upload"
			    accept = "image/*,text/csv,application/msword,application/pdf,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.wordprocessingml.document"
			    filefield="form.REQUIREMENTITEMID#x#"
			    destination="#thisfilepath#"
			    nameconflict="makeunique" 
			    />		
			    <cfset imageName = upload.SERVERFILE>
				
			    <!--- insert  --->
				<cfquery name="insertDoc">
					INSERT INTO zScholarshipDocs
					(UserID, ScholarshipID, requirementItemId, CompanyID, originalfilename, serverfilename)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#x#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session.companyID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.imageName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.imageName#">
					)			    
				</cfquery>
			</cfif>
		</cfif>	
	</cfloop>
	
	<cfif isdefined("form.customquestions")>
		<cfloop list="#form.customquestions#" index="x">
			<cfset answer = form["question#x#"]>
			
			<cfquery name="GetAnswers" result="thisresult">
				SELECT CustomAnswerID, CustomQuestionID, ScholarshipID, UserID
				FROM   zCustomAnswer
				Where 	CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#x#"> and
						ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#"> and 
						UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">
			</cfquery>

			<cfif GetAnswers.recordcount eq 0>
				<!--- insert answers --->
				<cfquery name="InsertAnswers">
					insert into zCustomAnswer
					(CustomQuestionID, ScholarshipID, UserID, Answer)
					values
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#x#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.answer#">
					)
				</cfquery>
			<cfelse>
				<!--- update answers --->
				<cfquery name="UpdateAnswers" result="thisresult">
					UPDATE zCustomAnswer
					SET CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#x#">, 
						ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#">, 
						UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">, 
						Answer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.answer#">
					Where CustomAnswerID = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetAnswers.CustomAnswerID#">
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
</cfif>		


<!--- Get Eligibility Information --->
<cfinvoke method="get_eligibility_info" component="cfc.scholarship" returnvariable="getEligibilityInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>		

<!--- Get Requirement Information --->
<cfinvoke method="get_requirement_info" component="cfc.scholarship" returnvariable="getrequirementInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>	

<!--- Get Scholarship Information --->
<cfinvoke method="get_scholarship_info_site" component="cfc.scholarship" returnvariable="getScholarshipInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>	

<!--- eligibility check --->




<cfquery name="getCustomQuestion">
	SELECT CustomQuestionID, ScholarshipID, FieldName, FieldType, ActiveYN, InsertDate
	FROM  zCustomQuestions
	Where scholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.scholarshipid#">
			and activeYN = 1
</cfquery>

<!--- if this query comes back with data, then check boxes have been checked --->
<cfquery name="checkboxcheck" datasource="CBW">  
	SELECT       DocID, UserID, ScholarshipID, requirementItemId, CompanyID, originalfilename, serverfilename, filelocation, filedate, deleteYn, updatedate
	FROM            zScholarshipDocs 
    Where deleteYn = 'false' and 
    UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#"> and
    ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#"> 
</cfquery>  
<cfif checkboxcheck.recordcount eq 0>
	<cfset checkedboxes = 0>
<cfelse>
	<cfset checkedboxes = 1>
</cfif>

<cfinclude template="header.cfm" >
<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item active">Current</li>
</ol>
      <section class="dashboard-header section-padding">
		<div class="container-fluid">
			<cfform action="" method="post" enctype="multipart/form-data">
			<div class="row d-flex align-items-md-stretch">
				<cfoutput><h3>#getScholarshipInfo.ScholarshipName#</h3></cfoutput>
				<ul class="list-group">
					<li class="list-group-item active" >Verify eligibility - Please verify you meet all qualifications and check all boxes</li>
					<cfoutput query="getEligibilityInfo">
				  		<li class="list-group-item">
					  		<input type="checkbox" required="true" aria-label="Checkbox for following text input" <cfif variables.checkedboxes eq 1>Checked</cfif>>
				  			#getEligibilityInfo.ELIGIBILITYQUESTION#
				  		</li>
					</cfoutput>
					<li class="list-group-item">
						<div class="row">
							<cfoutput query="getCustomQuestion">
							
							<cfquery name="GetThisAnswers" result="thisresult">
								SELECT Answer
								FROM   zCustomAnswer
								Where 	CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#CustomQuestionID#"> and
										ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ScholarshipID#"> and 
										UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">
							</cfquery>
							
							<div class="col-lg-6">
						    <div class="card">
						      <div class="card-body">
						        <h5 class="card-title">#FieldName#</h5>
						        
								<div class="input-group mb-3">
								  <div class="custom-file">
								    <input type="Text" id="question#CustomQuestionID#" name="question#CustomQuestionID#" value="#GetThisAnswers.Answer#">
								    <input type="hidden" name="customquestions" value="#CustomQuestionID#">	
								    <!---<label class="custom-file-label" id="REQUIREMENTITEMID" for="question1">Choose file</label>--->
								  </div>
								</div>						        
							 </div>
							</div>
							</div>
						</cfoutput>
						</div>
					</li>
					<li class="list-group-item">
						
						<div class="row">
						<cfoutput query="getrequirementInfo">
						<!--- Get Requirement Information --->
						<cfinvoke method="get_scholarship_docs" component="cfc.scholarship" returnvariable="getScholarshipdocs">
							<cfinvokeargument name="Userid" value="#session.userid#" />			  
							<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
							<cfinvokeargument name="requirementItemID" 	value="#REQUIREMENTITEMID#" />			  
						</cfinvoke>								
							<div class="col-lg-6">
						    <div class="card">
						      <div class="card-body">
						        <h5 class="card-title">#REQUIREMENTITEM#</h5>
						        
								<div class="input-group mb-3">
								  <div class="custom-file">
								    <input type="file" class="custom-file-input" id="inputGroupFile#REQUIREMENTITEMID#" name="REQUIREMENTITEMID#REQUIREMENTITEMID#">
								    <label class="custom-file-label" id="REQUIREMENTITEMID#REQUIREMENTITEMID#" for="inputGroupFile#REQUIREMENTITEMID#">Choose file</label>
								  </div>
								</div>						        
						        <!---<input type="file" name="REQUIREMENTITEMID#REQUIREMENTITEMID#"  class="btn btn-primary"></input>--->
						        <cfif getScholarshipdocs.originalfilename neq "">
						        <p class="card-text text-success" >
						        	<i class="far fa-file" title="#REQUIREMENTITEMID#"></i> 
						        	<a href="studentdocs/#REQUIREMENTITEMID#/#getScholarshipdocs.originalfilename#" target="_blank" >
						        		#REQUIREMENTITEM# Uploaded Successfully
						        	</a>
						        	<!---#getScholarshipdocs.originalfilename#--->
						        </p>
						        <cfelse>
						        <p class="card-text text-danger" >
						        	<i class="far fa-file" title="#REQUIREMENTITEMID#"></i> 
						        	#REQUIREMENTITEM# Required
						        	<!---#getScholarshipdocs.originalfilename#--->
						        </p>
						        </cfif>
						      </div>
						    </div>
						  </div>
						  </cfoutput>
						</div>						
					</li>	
					<li class="list-group-item active" >
						<input type="hidden" name="action" value="1">
						<input type="submit" class="btn btn-primary" name="submit" value="Update Application">
					</li>
				</ul>
			</cfform>
			</div>
		</div>
	</section>
<div class="clearfix"></div>
<script>
$(document).on('change', '.custom-file-input', function () {
let fileName = $(this).val().replace(/\\/g, '/').replace(/.*\//, '');
$(this).parent('.custom-file').find('.custom-file-label').text(fileName);
});
</script>
<cfinclude template="footer.cfm" >   