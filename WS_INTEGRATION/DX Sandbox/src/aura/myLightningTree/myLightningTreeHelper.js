({
	callToServer : function(component, method, callback, params) {
        console.log('Calling helper callToServer function');
		var action = component.get(method);
        if(params){
            action.setParams(params);
        }
        console.log(JSON.stringify(params));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert('Processed successfully at server');
                callback.call(this,response.getReturnValue());
            }else if(state === "ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                }
                else {
                    alert("Unknown error");
                }
            }
        });
		$A.enqueueAction(action);
    }
})