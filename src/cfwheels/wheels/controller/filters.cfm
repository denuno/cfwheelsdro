<!--- PUBLIC CONTROLLER INITIALIZATION FUNCTIONS --->

<cffunction name="filters" returntype="void" access="public" output="false" hint="Tells Wheels to run a function before an action is run or after an action has been run. You can also specify multiple functions and actions."
	examples=
	'
		<!--- Always execute `restrictAccess` before all actions in this controller --->
		<cfset filters("restrictAccess")>

		<!--- Always execute `isLoggedIn` and `checkIPAddress` (in that order) before all actions in this controller except the `home` and `login` actions --->
		<cfset filters(through="isLoggedIn,checkIPAddress", except="home,login")>
	'
	categories="controller-initialization" chapters="filters-and-verification" functions="verifies">
	<cfargument name="through" type="string" required="true" hint="Function(s) to execute before or after the action(s).">
	<cfargument name="type" type="string" required="false" default="before" hint="Whether to run the function(s) before or after the action(s).">
	<cfargument name="only" type="string" required="false" default="" hint="Pass in a list of action names (or one action name) to tell Wheels that the filter function(s) should only be run on these actions.">
	<cfargument name="except" type="string" required="false" default="" hint="Pass in a list of action names (or one action name) to tell Wheels that the filter function(s) should be run on all actions except the specified ones.">
	<cfscript>
		var loc = {};

		arguments.through = $listClean(arguments.through);
		arguments.only = $listClean(arguments.only);
		arguments.except = $listClean(arguments.except);

		loc.iEnd = ListLen(arguments.through);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.filter = {};
			loc.filter.through = ListGetAt(arguments.through, loc.i);
			loc.filter.type = arguments.type;
			loc.filter.only = arguments.only;
			loc.filter.except = arguments.except;
			loc.filter.arguments = {};
			if (StructCount(arguments) > 4)
			{
				loc.dynamicArgument = loc.filter.through & "Arguments";
				if (StructKeyExists(arguments, loc.dynamicArgument))
				{
					loc.filter.arguments = arguments[loc.dynamicArgument];
				}
				for (loc.key in arguments)
				{
					if (!ListFindNoCase("through,type,only,except,#loc.dynamicArgument#", loc.key))
					{
						loc.filter.arguments[loc.key] = arguments[loc.key];
					}
				}
			}
			ArrayAppend(variables.wheels.filters, loc.filter);
		}
	</cfscript>
</cffunction>

<cffunction name="setFilterChain" returntype="void" access="public" output="false" hint="Use this function if you need a more low level way of setting the entire filter chain for a controller.">
	<cfargument name="chain" type="array" required="true" hint="The entire filter chain that you want to use for this controller.">
	<cfset variables.wheels.filters = arguments.chain>
</cffunction>

<!--- PUBLIC CONTROLLER CLASS FUNCTIONS --->

<cffunction name="filterChain" returntype="array" access="public" output="false" hint="Returns an array of all the filters set on this controller in the order in which they will be executed.">
	<cfargument name="type" type="string" required="false" default="all" hint="Use this argument to return only `before` or `after` filters.">
	<cfscript>
		var loc = {};

		if (!ListFindNoCase("before,after,all", arguments.type))
		{// invalid type
			$throw(type="Wheels.InvalidFilterType", message="The filter type of `#arguments.type#` is invalid.", extendedInfo="Please use either `before` or `after`.");
		}

		if (arguments.type eq "all")
		{// return all filters
			return variables.wheels.filters;
		}

		// loop over the filters and return all those that match the supplied type
		loc.returnValue = ArrayNew(1);
		loc.iEnd = ArrayLen(variables.wheels.filters);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			if (variables.wheels.filters[loc.i].type eq arguments.type)
				ArrayAppend(loc.returnValue, variables.wheels.filters[loc.i]);
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<!--- PRIVATE FUNCTIONS --->

<cffunction name="$runFilters" returntype="void" access="public" output="false">
	<cfargument name="type" type="string" required="true">
	<cfargument name="action" type="string" required="true">
	<cfscript>
		var loc = {};
		loc.filters = filterChain(arguments.type);
		loc.iEnd = ArrayLen(loc.filters);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.filter = loc.filters[loc.i];
			if ((!Len(loc.filter.only) && !Len(loc.filter.except)) || (Len(loc.filter.only) && ListFindNoCase(loc.filter.only, arguments.action)) || (Len(loc.filter.except) && !ListFindNoCase(loc.filter.except, arguments.action)))
			{
				if (!StructKeyExists(variables, loc.filter.through))
				{
					$throw(type="Wheels.filterNotFound", message="Wheels tried to run the `#loc.filter.through#` function as a #arguments.type# filter but could not find it.", extendedInfo="Make sure there is a function named `#loc.filter.through#` in the `#variables.wheels.name#.cfc` file.");
				}
				loc.arguments = loc.filter.arguments;
				loc.arguments.method = loc.filter.through;
				loc.result = $invoke(argumentCollection=loc.arguments);
				if ((StructKeyExists(loc, "result") && !loc.result) || StructKeyExists(request.wheels, "response") || StructKeyExists(request.wheels, "redirect"))
				{
					// the filter function returned false or rendered content so we skip the remaining filters in the chain
					break;
				}
			}
		}
	</cfscript>
</cffunction>