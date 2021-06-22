({
    changeEntity: function(component, event, helper) {
        var action = component.get('c.getEntity');

        action.setParams({
            "entityType": component.get('v.componentString')
        });
        action.setCallback(this, function(a) {
            var state = a.getState(); // get the response state
            if (state == 'SUCCESS') {
                component.set('v.sObjList', a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})