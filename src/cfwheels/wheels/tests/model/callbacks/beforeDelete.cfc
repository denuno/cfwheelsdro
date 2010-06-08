<cfcomponent extends="wheelsMapping.test">

	<cffunction name="test_existing_object">
		<cfset model("tag").$registerCallback(type="beforeDelete", methods="callbackThatSetsProperty,callbackThatReturnsFalse")>
		<cfset loc.obj = model("tag").findOne()>
		<cfset loc.obj.delete()>
		<cfset model("tag").$clearCallbacks(type="beforeDelete")>
		<cfset assert("StructKeyExists(loc.obj, 'setByCallback')")>
	</cffunction>

	<cffunction name="test_existing_object_with_skipped_callback">
		<cfset model("tag").$registerCallback(type="beforeDelete", methods="callbackThatSetsProperty,callbackThatReturnsFalse")>
		<cfset loc.obj = model("tag").findOne()>
		<cfset loc.obj.delete(callbacks=false, transaction="rollback")>
		<cfset model("tag").$clearCallbacks(type="beforeDelete")>
		<cfset assert("NOT StructKeyExists(loc.obj, 'setByCallback')")>
	</cffunction>

</cfcomponent>