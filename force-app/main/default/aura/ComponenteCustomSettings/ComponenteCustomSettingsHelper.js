  ({
	componenteCustomSettingHelper : function(component, event, helper) {
		var action = component.get("c.metodoAdminStep");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var results= response.getReturnValue(); 
                //alert(JSON.stringify(results));
                component.set("v.adminStepList", results);
            }
        });
        $A.enqueueAction(action);
	}, 
    
})