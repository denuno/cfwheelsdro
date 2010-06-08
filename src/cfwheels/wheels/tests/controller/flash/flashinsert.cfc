<cfcomponent extends="wheelsMapping.test">

	<cfset params = {controller="dummy", action="dummy"}>
	<cfset controller = $controller(name="dummy").$createControllerObject(params)>

	<cffunction name="test_flashInsert_valid">
		<cfset controller.flashInsert(success="Congrats!")>
		<cfset assert("session.flash.success IS 'Congrats!'")>
	</cffunction>
	
</cfcomponent>
