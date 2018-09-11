<cfinclude template="header.cfm" >

<cfif isdefined("form.action")>
	<!--- update rank score --->
	<cfquery name="deleteRank" result="thisresult">
		DELETE 
		FROM zRank
		where 	userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.userid#"> and 
				scholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.scholarshipid#"> and 
				CommitteeUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.CommitteeUserID#">
	</cfquery>


	<cfquery name="getActiveRequirements">
		SELECT        requirementItemId, RequirementItem, activeYN, sortOrder, rankMultiplier
		FROM            zRequirementItems 
		Where activeYN = 1
	</cfquery>
	<cfset ranklist = ValueList(getActiveRequirements.requirementItemId)>
	<cfloop list="#ranklist#" index="x">
		<cfif isdefined("form.rank#x#")>
		<cfset rankscore = form["rank#x#"]>
			<cfif rankscore neq "">
			<cfquery name="insertRanks">
				INSERT INTO zRank
				(RequirementID, RankScore, UserID, ScholarshipID, CommitteeUserID)
				VALUES        
				(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#x#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#rankscore#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.userid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.Scholarshipid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CommitteeUserID#">
						
				)
			</cfquery>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<cfquery name="getApps">
    SELECT        zUser.UserID, zUser.FirstName, zUser.LastName, zScholarship.ScholarshipName, zApplication.ApplicationDate, 
    			zApplication.ApplicationID, zUser.Email, zUser.Password, zUser.phonenumber, zUser.Address, zUser.City, zUser.State, 
    			zUser.Zipcode, zUser.GPA, zScholarship.scholarshipid
	FROM            zApplication INNER JOIN
                         zScholarship ON zApplication.ScholarshipID = zScholarship.scholarshipID INNER JOIN
                         zUser ON zApplication.UserID = zUser.UserID
	Where companyID = #session.companyID# and applicationID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.Applicationid#">                         
</cfquery>	

<cfquery name="getCustomQuestion">
SELECT        zCustomQuestions.CustomQuestionID, zCustomQuestions.ScholarshipID, zCustomQuestions.FieldName, zCustomQuestions.FieldType, zCustomQuestions.ActiveYN, zCustomQuestions.InsertDate, 
                         zCustomAnswer.Answer
FROM            zCustomQuestions LEFT OUTER JOIN
                         zCustomAnswer ON zCustomQuestions.CustomQuestionID = zCustomAnswer.CustomQuestionID  
                         AND zCustomAnswer.UserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getApps.UserID#">
Where zCustomQuestions.scholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getApps.scholarshipid#">
		and activeYN = 1
</cfquery>

<cfquery  name="sumRankScore">
SELECT        zRank.CommitteeUserID, zRank.RankID, zRank.RequirementID, zRank.RankScore, zRank.UserID, zRank.ScholarshipID, zRank.UpdateDate, zRequirementItems.rankMultiplier * zRank.RankScore AS FullRankScore, 
                         zRequirementItems.rankMultiplier
FROM            zRank INNER JOIN
                         zRequirementItems ON zRank.RequirementID = zRequirementItems.requirementItemId
Where   zRank.ScholarshipID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getApps.scholarshipid#">
		and zRank.UserID =   <cfqueryparam cfsqltype="cf_sql_integer" value="#getApps.UserID#">                      	
		</cfquery>

<cfquery dbtype="query" name="getScore">
	Select sum (FullRankScore) as sumScore
	from sumRankScore
	Where CommitteeUserID = #Session.userid# and ScholarshipID = #getApps.scholarshipid# and UserID = #getApps.UserID#
</cfquery>                         

<cfquery  name="getRanking">
SELECT        SUM(zRequirementItems.rankMultiplier * zRank.RankScore) AS totalscore, zRank.UserID, 
			  DENSE_RANK() OVER (ORDER BY SUM(zRequirementItems.rankMultiplier * zRank.RankScore) DESC) AS Ranking
FROM          zRank INNER JOIN
              zRequirementItems ON zRank.RequirementID = zRequirementItems.requirementItemId
WHERE        (zRank.ScholarshipID = #getApps.scholarshipid#)
GROUP BY zRank.UserID
</cfquery>

<cfquery dbtype="query" name="getRank">
	select ranking 
	from getRanking
	Where userid = #getApps.userid#
</cfquery>



<!--- Get scholarship Information --->
<!---<cfinvoke method="get_latest_scholarship_docs" component="cfc.scholarship" returnvariable="getdocs">
	<cfinvokeargument name="applicationid" 	value="#url.Applicationid#" />			  
</cfinvoke>		--->

<!--- Get Requirement Information --->
<cfinvoke method="get_requirement_info" component="cfc.scholarship" returnvariable="getrequirementInfo">
	<cfinvokeargument name="ScholarshipID" 	value="#getApps.ScholarshipID#" />			  
</cfinvoke>	
<script>
window.setTimeout(function() {
    $(".alert").fadeTo(200, 0).slideUp(200, function(){
        $(this).remove(); 
    });
}, 4000);
</script>
<ol class="breadcrumb">
  <li class="breadcrumb-item"><a href="index.cfm">Home</a></li>
  <li class="breadcrumb-item"><a href="javascript:history.back()">Review Applications</a></li>
  <li class="breadcrumb-item active">Application</li>
</ol>

      <section class="dashboard-header section-padding">
        <div class="container-fluid">
        	<div class="row">
	        	<div class="col-lg-12">
	        		<cfoutput >
						<h3>#getApps.ScholarshipName# </h3>	        			
	        		</cfoutput>
	        		<p>&nbsp;</p>
	        	</div>
        	</div>
	        <div class="row">    
	            <div class="col-lg-4">
	              	<div class="card to-do">
	              		<cfoutput >
	                	<h2 class="display h4">#getApps.FirstName# #getApps.LastName#</h2>
	                	<p> 
	                		Applied: #dateformat(getApps.ApplicationDate,'mm/dd/yyyy')#
	                	</p>
	                	<p>
	                		#getApps.Address#<br>
	                		#getApps.city#, #getApps.State# #getApps.Zipcode#
	                	</p>    
	                	<p><a href="mailto:#getApps.Email#">#getApps.Email#</a></p>
	              		<p></p>
	              		</cfoutput>
	              		
	              		<cfoutput query="getCustomQuestion">
	              			<p>#FIELDNAME#: #ANSWER#</p>
	              		</cfoutput>
	              		
	              		
	              		
	            	</div> 
	              	<div class="card to-do">
	              		<cfoutput >
	                	<h2 class="display h4">Score: #val(getScore.sumScore)#</h2>
	                	<h2 class="display h4">Rank: #getRank.ranking#</h2>
	                	</cfoutput>
	            	</div> 
	            </div>	   
	            <form action="" method="post" >
	            <div class="col">
              		<cfif isdefined("form.action")>
	              		<div class="alert alert-success" role="alert">
							  Rank Updated Successfully
						</div>
					</cfif>
	            	<!---<cfdump var="#form#" >--->
	            	<cfoutput query="getrequirementInfo" >
					<!--- Get Requirement Information --->
					<cfinvoke method="get_scholarship_docs" component="cfc.scholarship" returnvariable="getScholarshipdocs">
						<cfinvokeargument name="Userid" value="#getApps.userid#" />			  
						<cfinvokeargument name="ScholarshipID" 	value="#getApps.ScholarshipID#" />			  
						<cfinvokeargument name="requirementItemID" 	value="#REQUIREMENTITEMID#" />			  
					</cfinvoke>			
					
					<!--- Get Document Rank Information --->
					<cfinvoke method="get_doc_rank" component="cfc.scholarship" returnvariable="getDocRank">
						<cfinvokeargument name="Userid" value="#getApps.userid#" />			  
						<cfinvokeargument name="ScholarshipID" 	value="#getApps.ScholarshipID#" />			  
						<cfinvokeargument name="requirementItemID" 	value="#REQUIREMENTITEMID#" />			  
						<cfinvokeargument name="CommitteeUserID" value="#session.userid#" />			  
					</cfinvoke>			
										
					<cfif getDocRank.recordcount eq 0>
						<cfset thisRankscore = "">
					<cfelse>
						<cfset thisRankscore = val(getDocRank.Rankscore)>
					</cfif>		
					<cfif getScholarshipdocs.originalfilename neq "">
						<cfset thisDisabled = "false">
					<cfelse>
						<cfset thisDisabled = "true">
					</cfif>	
					
					<h6 class="card-title">
						#Requirementitem# 
						<br>
						<select name="Rank#REQUIREMENTITEMID#" class="form-control custom-select custom-select-lg" <cfif thisDisabled is "true">disabled</cfif>>
							<cfif thisDisabled is "true">
								<option value="" style="color:red;">Ineligible for Rank - Missing File</option>
							<cfelse>	
								<option value="" style="color:red;">Select Rank</option>
							</cfif>
							
							<option value="0" <cfif thisRankscore eq 0>selected</cfif>>0 Points</option>
							<cfloop index="x" from="1" to="10">
								<option value="#x#" <cfif thisRankscore eq x>selected</cfif>>#x * rankMultiplier# Points</option>
							</cfloop>
						</select>
					</h6>
					<p class="card-text">
						<cfif getScholarshipdocs.originalfilename neq "">
						<a href="studentdocs/#REQUIREMENTITEMID#/#getScholarshipdocs.ORIGINALFILENAME#" target="_blank">
							#getScholarshipdocs.ORIGINALFILENAME#
						</a>
						<cfelse>
						<span style="color:red">
							Not Available
						</span>
						</cfif>
						<hr></hr>
					</p>
	               	</cfoutput>
	               	<p>
	               		<cfoutput >
	               		<button type="submit" class="btn btn-success" name="Update Rank">UPDATE #ucase(getApps.FirstName)# #ucase(getApps.lastname)#'S RANK</button>
	               		<input type="hidden" name="userid" value="#getApps.userid#">
	               		<input type="hidden" name="CommitteeUserID" value="#session.userid#">
	               		<input type="hidden" name="action" value="1" >	
	               		<input type="hidden" name="scholarshipid" value="#getApps.scholarshipid#" >	
	               		</cfoutput>
	               	</p>
				</div> 
            </form> 
			</div>	 
		</div>                	
      </section>  	
<cfinclude template="footer.cfm" >        