<!--- Get scholarship Information --->
		
			<ul class="nav nav-tabs" id="myTab">
				<cfoutput >
				<li class="active">
					<a class="nav-link"  href="ScholarshipManage.cfm?scholarshipid=#url.scholarshipID#">Scholarship Application</a>
				</li>
				<li>
					<a class="nav-link"  href="ScholarshipManage.cfm?scholarshipid=#url.scholarshipID#">Scholarship Site</a>
				</li>
				<li>
					<a class="nav-link"  href="ScholarshipManage.cfm?scholarshipid=#url.scholarshipID###heroImage">Hero Image</a>
				</li>
				
				<cfif url.scholarshipid neq 0>
				
				<li>
					<a class="nav-link" target="_blank" href="scholarship/index.cfm?scholarshipid=#url.scholarshipID#">Preview Scholarship Site</a>
				</li>
				
				</cfif>
				<li>
					<a class="nav-link" href="ScholarshipManageAddField.cfm?scholarshipid=#url.scholarshipID###addfield">+Add Fields</a>
				</li>
				</cfoutput>
			</ul>