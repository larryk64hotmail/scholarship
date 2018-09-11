
<cfcomponent>

	<cfset this.name = "scholarshipApp">
	<cfset this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0)>
	<cfset this.datasource = "CBW">
	<cfset this.sessionManagement = true>
	<cfset this.setClientCookies = true>
	<cfset this.sessionTimeout = CreateTimeSpan(0, 15, 15, 15)>
	<cfset this.mappings["/cfc"] = getDirectoryFromPath(getCurrentTemplatePath())&"CFC">	

	<cfset this.scriptprotect = "all">

	<cffunction name="onApplicationStart">
	</cffunction>
	
	<cffunction name="onApplicationEnd">
	</cffunction>
	
	<cffunction name="onRequestStart">
	</cffunction>
	
	<cffunction name="onSessionStart">
	</cffunction>
	
	<cffunction name="onSessionEnd">
	</cffunction>
	
	<cffunction name="onMissingTemplate" returnType="boolean" output="true">
	    <cfargument type="string" name="targetPage" required=true/> 
	    <cfinclude template="missingtemplate.cfm" >
	    <cfreturn true />
	</cffunction>	
	

<cffunction name="onError">
    <cfargument name="Except" required=true/>
    <cfargument type="String" name = "EventName" required=true/>
    <!--- Log all errors in an application-specific log file. --->
    <cflog file="#This.Name#" type="error" text="Message: #except.message#">
    <!--- Throw validation errors to ColdFusion for handling. --->
    <cfif Find("coldfusion.filter.FormValidationException", Arguments.Except.StackTrace)>
        <cfthrow object="#except#">
    <cfelse>
        <cfoutput>
            <p>
			<TABLE>
			<TR>
			  <TH>Variable Name</TH>
			  <TH>Value</TH>
			</TR>
			<!--- loop over the Form structure and output all
			      of the variable names and their associated 
			      values --->
			<CFLOOP COLLECTION="#Form#" ITEM="VarName">
			  <CFOUTPUT>
			  <TR>
			    <TD>#VarName#</TD>
			    <TD>#Form[VarName]#</TD>
			  </TR>
			  </CFOUTPUT>
			</CFLOOP>
			</TABLE>         	
            </p>
            <p><h4>CGI Variables</h4></p>
            <p><cfdump var=#except#></p>
            <p><cfdump var="#session#" ></p>
            <p><cfdump var="#CGI#" ></p>
            <p><h4>Session Variables</h4></p>
        </cfoutput>
    </cfif>
</cffunction>
	
	
</cfcomponent>