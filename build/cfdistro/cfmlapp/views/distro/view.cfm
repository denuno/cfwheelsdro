<cfset local.distro = rc.distro>
<cfset local.id = rc.distro.getId()>
<cfset local.depts = rc.departments>
<div class="item">

	<div class="date">
		<div>DSTRO</div>
		<span>01</span>
	</div>
	
	<div class="content">
	
<h1>Distro Info</h1>
	
		<div class="body">



<cfoutput>
<form id="distroForm" class="familiar medium" method="post" action="#resp.encodeURL('index.cfm?action=distro.save')#">

	<input type="hidden" name="id" value="#local.id#">

	<p><cfoutput>#rc.message#</cfoutput></p>
	<div class="field">
		Distrobution: #local.distro.getDistroName()#
		<a href="#resp.encodeURL('index.cfm?action=distro.form&id=#local.id#')#">Edit</a>
	</div>

	<div class="field">
		Build File: #local.distro.getBuildDirectory()#<br />
		<cfif local.distro.buildFileExists()>
			<a href="#resp.encodeURL('index.cfm?action=distro.build&id=#local.id#&target=runwar.start')#">Start</a> |
			<a href="#resp.encodeURL('index.cfm?action=distro.build&id=#local.id#')#">Build</a> |
	 		<a href="#resp.encodeURL('index.cfm?action=distro.cfdistroinstall&id=#local.id#')#">Update CFDistro</a> | 
	 		<a href="#resp.encodeURL('index.cfm?action=distro.build&target=tests.build.start.run.stop&id=#local.id#')#">tests.build.start.run.stop</a> |
	 		<a href="#resp.encodeURL('index.cfm?action=distro.build&target=tests.build.start.run.stop.both&id=#local.id#')#">tests.build.start.run.stop.both</a>
 	<cfelse>
	 		<a href="#resp.encodeURL('index.cfm?action=distro.cfdistroinstall&id=#local.id#')#">Install CFDistro</a>
		</cfif>
	</div>

<!---
	<div class="field">
		<label for="email" class="label">Email:</label>
		<input type="text" name="email" id="email" value="#local.distro.getEmail()#">
	</div>

	<div class="field">
		<label for="departmentId" class="label">Department:</label>
		<select name="departmentId" id="departmentId">
			<cfloop collection="#local.depts#" item="local.id">

				<cfset local.dept = local.depts[local.id]>

				<!--- when editing a distro we need to set the dept that distro currently has --->
				<cfif local.id EQ local.distro.getDepartmentId()>
					<option value="#local.id#" selected="selected">#local.dept.getName()#</option>
				<cfelse>
					<option value="#local.id#">#local.dept.getName()#</option>
				</cfif>
            </cfloop>
		</select>
	</div>
 --->
</form>
</cfoutput>

		</div>
	
	</div>

</div>



