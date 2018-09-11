

<cfinclude template="header.cfm" >
<!--- Get scholarship Information --->
<cfinvoke method="get_scholarship_info" component="cfc.scholarship" returnvariable="getScholarshipInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#url.ScholarshipID#" />			  
</cfinvoke>	
<cfparam name="url.CustomQuestionID" default="0" >
<cfif isdefined("url.enable")>
	<cfquery datasource="cbw" name="updateCustomQuestion">
		Update zCustomQuestions
		Set ActiveYN = 1
		Where CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.enable#">
	</cfquery>
</cfif>

<cfif isdefined("url.disable")>
	<cfquery datasource="cbw" name="updateCustomQuestion">
		Update zCustomQuestions
		Set ActiveYN = 0
		Where CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.disable#">
	</cfquery>
</cfif>

<cfif isdefined("form.scholarshipID")>
	<cfif form.CustomQuestionID eq 0>
		<cfquery datasource="cbw" name="insertCustomQuestion">
			INSERT INTO zCustomQuestions
			(ScholarshipID, FieldName, FieldType)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#url.scholarshipid#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FieldName#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#form.FieldType#">
			)    		
		</cfquery>
	<cfelse>
		<cfquery datasource="cbw" name="updateCustomQuestion">
			Update zCustomQuestions
			Set FieldName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FieldName#">,
				FieldType = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.FieldType#">
			Where CustomQuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.CustomQuestionID#">
		</cfquery>
	</cfif>	
</cfif>



<cfquery name="getCustomQuestions">
	SELECT CustomQuestionID, ScholarshipID, FieldName, FieldType, ActiveYN, InsertDate
	FROM  zCustomQuestions
	Where scholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.scholarshipid#">
</cfquery>

<cfquery name="getSelectedCustomQuestion">
	SELECT CustomQuestionID, ScholarshipID, FieldName, FieldType, ActiveYN, InsertDate
	FROM  zCustomQuestions
	Where scholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.scholarshipid#">
			and CustomQuestionID = #url.CustomQuestionID#
</cfquery>


<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item active"><cfoutput>#getScholarshipInfo.scholarshipName#</cfoutput></li>
</ol>
      <section class="dashboard-header section-padding">
      	<cfform action="?scholarshipID=#url.scholarshipID#" method="post" >
		<div class="container-fluid">
			<cfinclude template="scholarshipManageMenu.cfm" >
			<div class="tab-content">
				<div class="row d-flex align-items-md-stretch px-3">
					<p>Add fields to your scholarship application. fields will appear on the scholarship application.</p>
				</div>
				<div class="row d-flex align-items-md-stretch px-3">
					  <div class="form-group">
					    <label for="fieldname">Field Name</label>
					    <cfoutput >
					    <input type="text" class="form-control" id="fieldname" maxlength="25" name="fieldname" value="#getSelectedCustomQuestion.fieldname#" aria-describedby="FieldName" placeholder="Field Name" required="true">
					    </cfoutput>
					    <small id="fieldnamehelp" class="form-text text-muted">enter the name of the field you want to add to the application</small>
					  </div>
				</div>	  
				<div class="row d-flex align-items-md-stretch px-3">
	
					  <div class="form-group">
					    <label for="fieldType">Type of field: </label>
					   	Text 
					   	<input type="radio" name="fieldType" value="1" required="true" <cfif getSelectedCustomQuestion.fieldType eq 1>checked</cfif>> &nbsp;
					   	<input type="radio" name="fieldType" value="2" <cfif getSelectedCustomQuestion.fieldType eq 2>checked</cfif>> Text-Area
					    <small id="fieldTypehelp" class="form-text text-muted">Select text or text-area. Use "Text" for short answers, use "Text-Area" for longer answers.</small>
					  </div>
	  			</div>
				<div class="row d-flex align-items-md-stretch px-3">
					<cfoutput >
					<input type="hidden" name="CustomQuestionID" value="#url.CustomQuestionID#">	
					<input type="hidden" name="ScholarshipID" value="#url.scholarshipID#">
					</cfoutput>
					<cfif url.CustomQuestionID eq 0>
						<input type="submit" class="btn btn-primary" value="Add Custom Field">	  	
					<cfelse>
						<input type="submit" class="btn btn-primary" value="Update Custom Field">	  	
					</cfif>						
				</div>
				
				<div class="row d-flex align-items-md-stretch px-3">
					&nbsp;
				</div>
				<cfif getCustomQuestions.recordcount gt 0>
				<div class="row d-flex align-items-md-stretch px-3">
				<table class="table">
				  <thead>
				    <tr>
				      <th scope="col" colspan="2">Custom Fields</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<cfoutput query="getCustomQuestions" >
				    <tr>
				      <td><a href="?scholarshipID=#url.scholarshipID#&CustomQuestionID=#CustomQuestionID#">#FieldName#</a></td>
				      <td>
				      <cfif activeYN eq 1>
				      	<a href="?scholarshipID=#url.scholarshipID#&disable=#CustomQuestionID#">Disable</a> 
				      <cfelse>
				      	<a href="?scholarshipID=#url.scholarshipID#&enable=#CustomQuestionID#">Enable</a> 
				      </cfif>	
				      	|
				      	<a href="?scholarshipID=#url.scholarshipID#&CustomQuestionID=#CustomQuestionID#">Edit</a>
				      </td>
				    </tr>
				    </cfoutput>
				  </tbody>
				</table>
				</div>
				</cfif>
				
			</div>
		</div>
      	</cfform>
	</section>
<div class="clearfix"></div>
<cfinclude template="footer.cfm" >      