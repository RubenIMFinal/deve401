({
    handleShowActiveSectionName: function(cmp, event, helper) {
        alert(cmp.find("accordion").get('v.activeSectionName'));
    },
    handleSetActiveSectionC: function(cmp) {
        cmp.find("accordion").set('v.activeSectionName', 'C');
    },
    handleCancel: function(cmp, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },

    handleSubmit: function(cmp, event, helper) {
        event.preventDefault();
        var fields = event.getParam('fields');
        fields.AccountId = cmp.get("v.recordId");
        cmp.find('myform').submit(fields);
    },
    handleSuccess: function(cmp, event, helper) {
        // Success! Prepare a toast UI message
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Contact Saved",
            "message": "The new contact was created."
        });

        // Update the UI: close panel, show toast, refresh account page
        $A.get("e.force:closeQuickAction").fire();
        resultsToast.fire();

        // Reload the view
        $A.get("e.force:refreshView").fire();
    },
    handleChange: function(component, event) {
        alert(event.getParam('value'));
    }
});