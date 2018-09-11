<cfif isdefined("url.logout")>
	<cfset StructClear(Session)>
</cfif>

<!--- check to see if they are on a secure port --->
<cfset oRequest = getPageContext().getRequest() />

<cfif NOT oRequest.isSecure()>
	<cflocation url="https://#oRequest.getServerName()##oRequest.getRequestURI()#?#oRequest.getQueryString()#" addtoken="false" />
</cfif>

<cfparam name="session.loggedin" default="false" >
<cfparam name="session.companyid" default="0" >


<cfif
   (
	cgi.script_name neq "/2v/admin/login.cfm" 		or
	cgi.script_name neq "/2v/admin/register.cfm" 	or
	cgi.script_name neq "/2v/admin/registration.cfm"
	) 
	and session.loggedin neq "true">
	<cflocation url="login.cfm" addtoken="false" >
</cfif>

<!---  --->
