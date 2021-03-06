<cfcomponent extends="wheelsMapping.test">

	<cffunction name="test_$listClean_default_delim">
		<cfset loc.mylist = "tony,    per   ,  james    ,,, chris   , raul ,,,,  peter">
		<cfset loc.e = "tony,per,james,chris,raul,peter">
		<cfset loc.r = $listClean(loc.mylist)>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

	<cffunction name="test_$listClean_provide_delim">
		<cfset loc.mylist = "tony|    per   |  james    | chris   | raul |||  peter">
		<cfset loc.e = "tony|per|james|chris|raul|peter">
		<cfset loc.r = $listClean(loc.mylist, "|")>
		<cfset assert('loc.e eq loc.r')>
	</cffunction>

	<cffunction name="test_$listClean_return_array">
		<cfset loc.mylist = "tony,    per   ,  james    ,,, chris   , raul ,,,,  peter">
		<cfset loc.r = $listClean(list=loc.mylist, returnAs="array")>
		<cfset assert('IsArray(loc.r) and ArrayLen(loc.r) eq 6')>
	</cffunction>

	<cffunction name="test_$structDelete">
		<cfset loc.a = {}>
		<cfset loc.a.tony = "petruzzi">
		<cfset loc.a.per = "djurner">
		<cfset loc.a.james = "gibson">
		<cfset loc.a.raul = "the man">
		
		<cfset $structDelete(loc.a, "tony,per")>
		
		<cfset assert('structkeyexists(loc.a, "raul")')>
		<cfset assert('structkeyexists(loc.a, "james")')>
		<cfset assert('!structkeyexists(loc.a, "tony")')>
		<cfset assert('!structkeyexists(loc.a, "per")')>
		
	</cffunction>
	
</cfcomponent>