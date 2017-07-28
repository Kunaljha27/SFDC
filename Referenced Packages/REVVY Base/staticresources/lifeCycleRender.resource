var executeAction = function(objectId, actionId, namespaceLowerCase, needComments) {
    var isSF1 = (typeof sforce != 'undefined') && sforce && (!!sforce.one);
    var params = { "objectId":objectId, "actionId":actionId, "isSF1":isSF1 };
    if(needComments) {
        var commentModal = document.getElementById("commentModal");
        var submitButton = document.getElementById("submitComments");
        submitButton.setAttribute("onclick",
        "javascript:submitComments('" + objectId + "','" + actionId + "','" + namespaceLowerCase + "')");

        commentModal.style.display = 'block';
    } else {
        Visualforce.remoting.Manager.invokeAction(
            namespaceLowerCase+'CMnLifeCycleActionCtrl.executeAction',
            params,
            function(result, event){
                if (event.status) {
                    var redirectUrl = result.replace(/&amp;/g, '&');
                    if (isSF1) {
                        sforce.one.navigateToURL(redirectUrl, true);
                    } else {
                        window.top.location.replace(redirectUrl);
                    }
                } else {
                    alert(event.message);
                }
            },
            {escape: true}
        );

    }


};

var closePopUp = function() {
    var commentModal = document.getElementById('commentModal');
    commentModal.style.display = 'none';
};

var submitComments = function(objectId, actionId, namespaceLowerCase) {
    var isSF1 = (typeof sforce != 'undefined') && sforce && (!!sforce.one);
    var comment = document.getElementById("commentsText").value;
    var params = { "objectId":objectId, "actionId":actionId, "isSF1":isSF1 , "comment": comment};
    var commentModal = document.getElementById("commentModal");
    commentModal.style.display = 'none';
    Visualforce.remoting.Manager.invokeAction(
        namespaceLowerCase+'CMnLifeCycleActionCtrl.executeAction',
        params,
        function(result, event){
            if (event.status) {
                var redirectUrl = result.replace(/&amp;/g, '&');
                if (isSF1) {
                    sforce.one.navigateToURL(redirectUrl, true);
                } else {
                    window.top.location.replace(redirectUrl);
                }
            } else {
                alert(event.message);
            }
        },
        {escape: true}
    );


};

var getLifeCycleInformation = function(remotingObj, namespaceLowerCase, lifecycleObj, currentPhase, currentSubPhase) {

    if(lifecycleObj.lifeCycleId) {
        remotingObj.Manager.invokeAction(
            namespaceLowerCase+'CMnLifeCycleRemoter.getLifeCycleById',
            lifecycleObj,
            function(result, event){
                //phaseInformation = result;
                renderProgress(result, lifecycleObj.objectId, currentPhase, currentSubPhase, namespaceLowerCase);
            },
            {escape: true}
        );

    }
};


var renderProgress = function(phaseInformation, contractId, currentPhase, currentSubPhase, namespaceLowerCase) {

    if(phaseInformation) {
        var phases = phaseInformation.orderedPhases;
        var progressbar = document.getElementById("progressbar");
        var activePhaseIndex = -1;

        for(var i = 0; i < phases.length; i++){
            var phaseName = phases[i];
            var li = document.createElement("LI");
            var label = document.createElement("DIV");
            label.setAttribute("class", "phaseLabel");
            var t = document.createTextNode(phaseName);
            label.appendChild(t);
            var actionsDiv = document.createElement("DIV");
            actionsDiv.setAttribute("class", "actions");
            li.appendChild(label);
            var subPhases = phaseInformation.phasesToSubPhases[phaseName];
            if(currentPhase === null && currentSubPhase === null) {
                activePhaseIndex = 0;
                
                for(var j = 0; j < subPhases.length; j++){
                    if(subPhases[j].subPhase){
                        var span = document.createElement("SPAN");
                        span.textContent=subPhases[j].subPhase;

                        var actions = subPhases[j].actions;
                        actionsDiv.appendChild(span)
                        for(var k = 0; k < actions.length; k ++){
                            var a = document.createElement("A");
                            t = document.createTextNode(actions[k].name);
                            a.appendChild(t);
                            actionsDiv.appendChild(a);
                        }
                    }
                }

            } else {
                if(subPhases && phaseName === currentPhase) {
                    activePhaseIndex = i;

                    for(var j = 0; j < subPhases.length; j++){
                        if(subPhases[j].subPhase === currentSubPhase){
                            var span = document.createElement("SPAN");
                            span.setAttribute("class", "subphase-tooltip");
                            span.setAttribute("title", currentSubPhase);

                            li.appendChild(span);

                            var actions = subPhases[j].actions;
                            for(var k = 0; k < actions.length; k ++){
                                var a = document.createElement("A");
                                t = document.createTextNode(actions[k].name);
                                a.appendChild(t);
                                if(actions[k].enable) {
                                    a.setAttribute("class", "clickable");
                                    a.setAttribute("href", "javascript:void(0)");
                                    if(actions[k].needComments) {
                                        a.setAttribute("onclick", "javascript:executeAction('" +
                                            contractId + "','" + actions[k].actionId + "','" + namespaceLowerCase + "', true)");
                                    } else {
                                        a.setAttribute("onclick", "javascript:executeAction('" +
                                            contractId + "','" + actions[k].actionId + "','" + namespaceLowerCase + "', false)");
                                    }

                                    a.target = "_parent";
                                } else {
                                    a.setAttribute("class", "notclickable");
                                }
                                actionsDiv.appendChild(a);
                            }

                        }
                    }
                } else if(!subPhases){
                    alert("Current Sub Phase does not match any sub phase in the lifecycle. ");
                }
            }


            li.appendChild(actionsDiv);
            progressbar.appendChild(li);
        }

        var liArray = document.getElementsByTagName("LI");
        if(activePhaseIndex >= 0) {

            for(var i = 0; i < liArray.length; i++){
                if(i < activePhaseIndex) {
                    liArray[i].className = "done";
                } else if(i === activePhaseIndex){
                    if(currentSubPhase === "Terminated") {
                        liArray[i].className = "terminated";
                    } else {
                        liArray[i].className = "active";
                    }

                } else {
                    liArray[i].className = "notyet";
                }

            }
        } else {
            alert("Current Phase does not match any phase. ");
        }


    }

};
