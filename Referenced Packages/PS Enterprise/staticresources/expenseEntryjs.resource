// EVENT HANDLERS
var _AssignmentLookupHandler = {
    overlay : null,
    overlayContainer : null, 
    overlayEscKeyHandle : null,
    lastSearchString : null,
    rowBaseId : null,
    rowBaseUnEscId : null,
    assigCache : new Object(),
    config : {
    	toggleEditOverlay : true,
    	columnLabelManager : {
    		// commented as a fix for B-3466
    		//isLabelsLoaded : function(){ return _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels != null && _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels.length > 0 ;},
    		isLabelsLoaded : function(){ return false; },
    		assignColumnLabels : new Array(),
    		projColumnLabels : new Array()
    		}
    },
    prepare : function () {
        /* Create Overlay from script, this time. With no footer */
        _AssignmentLookupHandler.overlay = new _yui.Overlay({
            contentBox : "#assigORProjOverlay", 
            width : "100%",
            zIndex:2
        });
        
        /* Center overlay in viewport */
        _AssignmentLookupHandler.overlay.set("centered", true);
        _AssignmentLookupHandler.overlay.render();
        _AssignmentLookupHandler.overlay.show();
        
         
        //FIXME: TODO all() might not be required, as DOM will change here 
        //FIXME: TODO remove this completely use direct image onclick stuff
        _yui.on('key', function(e) {e.preventDefault(); _AssignmentLookupHandler.search(true);}, '#assigORProjSearchString', 'down:13', _yui);
        _AssignmentLookupHandler.overlayContainer = _yui.one('#assigORProjOverlayContainer'); 
    },
    
    show : function (projectSelector) {
        /*IE 7 bug fix*/
        validateZIndexForOverlay(true);
        if(_AssignmentLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        }
        
    // TODO: see if we can remove _AssignmentLookupHandler prefix here, as the this context is not there.
        _AssignmentLookupHandler.rowBaseId = sfdcToJSID(projectSelector.id.substring(0, projectSelector.id.lastIndexOf(':') + 1));
        _AssignmentLookupHandler.rowBaseUnEscId = (projectSelector.id.substring(0, projectSelector.id.lastIndexOf(':') + 1));
        _AssignmentLookupHandler.overlayContainer.setStyle('display', 'block');
        _AssignmentLookupHandler.overlay.set("centered", true);
        stablizeOverlay(_AssignmentLookupHandler.overlay);
        _AssignmentLookupHandler.overlayEscKeyHandle = _yui.on('key', _AssignmentLookupHandler.hide, document, 'down:27', _yui);
        /*Set focus to the search field.*/
        assigORProjSearchControl = _yui.one('#assigORProjSearchString');
        if(assigORProjSearchControl){
            assigORProjSearchControl.focus();
        }
    },

    hide : function() {
        _AssignmentLookupHandler.overlayContainer.setStyle('display', 'none');
        _AssignmentLookupHandler.overlayEscKeyHandle.detach();  
        
        /*@TODO @TEMP fix for IE sidebar issue*/
        validateZIndexForOverlay(false);
        if(_AssignmentLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        }  
    },
    
    search : function (listAll) {
        var searchString = listAll ? _yui.one('#assigORProjSearchString').get('value') : '';
        _yui.one("#assignmentLoadWaitImageID").set('style.visibility', 'visible');
        //var week = _yui.one("#currentWeekendInMillis").get('value');
        var rid = _yui.one(document.getElementById(_VFComponent.expForm_selectedResourceId)).get('value');
        var requestURL = _ajaxBrokerURL + encodeURI('?s=' + encodeURIComponent(searchString)) + '&action=loadAssignments' + '&rid='+rid + '&loadLabels=' + ! _AssignmentLookupHandler.config.columnLabelManager.isLabelsLoaded();
        requestURL = requestURL + '&core.apexpages.devmode.url=1';
        _yui.io(requestURL, { method:"GET", on:{success:_AssignmentLookupHandler.onAssignmentsLoad, failure:failureHandler} } );        
    },

   onAssignmentsLoad : function (id, o) {
		var yuiAssigmentRequestResultPanel = _yui.one('#yuiAssigmentRequestResultPanel');
	    yuiAssigmentRequestResultPanel.set("text", '');
	    
	    var root = o.responseXML.documentElement;
	    var assignmentTags = root.getElementsByTagName('assignmentDetail');
	    var assignMappingTag = root.getElementsByTagName('assignmentMapping');
	    var projMappingTag = root.getElementsByTagName('projectMapping');
	    
	    if(assignmentTags.length > 0){
	    	var assignmentList = new Array();
	    	var projectList = new Array();	    	
	        for(i= 0 ; i < assignmentTags.length ; i++){
	        	var isAssignment = assignmentTags[i].getElementsByTagName('isAssignment')[0].firstChild.nodeValue;
	        	if(isAssignment == 'true') {
	        		assignmentList.push(assignmentTags[i]);
	        	} else {
	        		projectList.push(assignmentTags[i]);
	        	}
	        }
	        
	         /*Check if column labels are loaded for columns, If not then load them now*/
	         if(!_AssignmentLookupHandler.config.columnLabelManager.isLabelsLoaded()){
	           
	            // For Assignment mapping 
	        	if(assignMappingTag.length > 0){
	        	   assignMappingTag = assignMappingTag[0];
	        	   var assignLabelsTag = assignMappingTag.getElementsByTagName('label');
	        	
		           if(assignLabelsTag != null && assignLabelsTag.length > 0){
			            _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels = new Array();
			            for(i= 0 ; i < assignLabelsTag.length ; i++){
			                _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels.push(assignLabelsTag[i].firstChild.nodeValue);
			            }
		           }
	        	}
	        	
	        	// For Project mapping 
	        	if(projMappingTag.length > 0){
	        	   projMappingTag = projMappingTag[0];
	        	   var projLabelsTag = projMappingTag.getElementsByTagName('label');
	        	
		           if(projLabelsTag != null && projLabelsTag.length > 0){
			            _AssignmentLookupHandler.config.columnLabelManager.projColumnLabels = new Array();
			            for(i= 0 ; i < projLabelsTag.length ; i++){
			                _AssignmentLookupHandler.config.columnLabelManager.projColumnLabels.push(projLabelsTag[i].firstChild.nodeValue);
			            }
		           }
	        	}
	         } // end of mapping loading loop
	         
		     // Code for child panel of Assignments 
		     if(assignmentList.length > 0) {
		     	var assignmentSecTags = root.getElementsByTagName('assignment');
				yuiAssigmentRequestResultPanel.appendChild(_AssignmentLookupHandler.createAjaxResultsTable(assignmentList,_AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels,assignmentSecTags,true));
		    }
		    
		    // Code for child panel of global projects 
		    if(projectList.length > 0) {
		    	var projectSecTags = root.getElementsByTagName('project');
		        yuiAssigmentRequestResultPanel.appendChild(_AssignmentLookupHandler.createAjaxResultsTable(projectList,_AssignmentLookupHandler.config.columnLabelManager.projColumnLabels,projectSecTags,false));
		     }
		  
	    }else{
	    	var resultTable = _yui.Node.create('<table id="assigORProjResultTable" width="100%" cellspacing="0"></table>');
         	resultTable.addClass('list');
         	var resultTbody = _yui.Node.create('<tbody></tbody>');
   		 	resultTable.appendChild(resultTbody);
	        var tr = _yui.Node.create('<tr></tr>');
	        tr.appendChild(_yui.Node.create('<td colspan="4">'+_Label.noResultsFound+'</td>'));
	        resultTbody.appendChild(tr);
	        yuiAssigmentRequestResultPanel.appendChild(resultTable);
	        isDataFound = false;
	    }
	  
	    _yui.one("#assignmentLoadWaitImageID").set('style.visibility', 'hidden');
	    _yui.one('#searchResultsLink').simulate("click", { relatedTarget: document.body });
	    
	},
    
    doSelectAssignment: function(aid){
         var root = _AssignmentLookupHandler.assigCache[aid];
         var aname = escape(root.getElementsByTagName('name')[0].firstChild.nodeValue);
         var nickName = escape(root.getElementsByTagName('nickName')[0].firstChild.nodeValue);
         var isAssignment = (root.getElementsByTagName('isAssignment')[0].firstChild.nodeValue == 'true');
         var isBillable = (root.getElementsByTagName('billable')[0].firstChild.nodeValue == 'true');
         var pid = root.getElementsByTagName('projectId')[0].firstChild.nodeValue;
         var toolTip = escape(root.getElementsByTagName('tooltip')[0].firstChild.nodeValue);
         var selectedMilestoneID =  root.getElementsByTagName('selectedMilestoneID')[0].firstChild.nodeValue;   
         var currencyIsoCode =  root.getElementsByTagName('currencyIsoCode')[0].firstChild.nodeValue;  
         _AssignmentLookupHandler.refreshAssigDependentDetails(aid,aname, nickName, isAssignment, isBillable, pid, toolTip, selectedMilestoneID, currencyIsoCode);      
    },
    
    nickNamecache : new Object(),
    
    toNickNameCache : function (assigID, nickName)
    {
         _AssignmentLookupHandler.nickNamecache[assigID] = nickName;
    },
    
    fromNickNameCache : function (assigID)
    {
         return _AssignmentLookupHandler.nickNamecache[assigID];  
    },
    
    toggleNicknameEdit : function (aid, editVal, nickNameHolder, isEditable){
        encodedEditVal = editVal;
        editVal= isStringNotEmpty(editVal) ? unescape(editVal) : editVal;
        nickNameHolder.set('text','');
        if(isEditable){
            var lastVal = (editVal == 'Add') ? '' : editVal;
            var nickNameTextInput = _yui.Node.create('<textarea style="width:95px;height:17px" type="text" maxlength="255"/>');
            
            nickNameTextInput.set('value',lastVal);
            
            var nickNameCancleBtn = _yui.Node.create('<button class="btn" onclick="_AssignmentLookupHandler.onNickNameCancleAction(\''+aid+'\',\''+encodedEditVal+'\',this);" >'+_Label.cancel+'</button>'); 
             
            var nickNameSaveBtn = _yui.Node.create('<button class="btn" onclick="_AssignmentLookupHandler.onNickNameSaveAction(\''+aid +'\',this);" >'+_Label.save+'</button>');        
            
            nickNameHolder.appendChild(nickNameTextInput);
            nickNameHolder.appendChild(nickNameCancleBtn);
            nickNameHolder.appendChild(nickNameSaveBtn);
            /*Set focus on the nickname edit text box
           
            Attach event like esc key calls cancel and enter key save*/
            nickNameTextInput.focus();
                
            
            var cancleNNSaveEvent = _yui.on('key', function(e, assigID, encodedEditVal, nickNameCancleBtnDOM){
                                                        e.halt();
                                                        _AssignmentLookupHandler.onNickNameCancleAction(assigID,encodedEditVal,nickNameCancleBtnDOM);
                                                        cancleNNSaveEvent.detach();
                                                    }, nickNameTextInput, 'down:27', _yui, aid,encodedEditVal,_yui.Node.getDOMNode(nickNameCancleBtn));
            var saveNNSaveEvent = _yui.on('key', function(e, assigID, nickNameCancleBtnDOM){
                                                        e.halt();
                                                        _AssignmentLookupHandler.onNickNameSaveAction(assigID,nickNameCancleBtnDOM);
                                                        saveNNSaveEvent.detach();
                                                    }, nickNameTextInput, 'down:13', _yui, aid,_yui.Node.getDOMNode(nickNameCancleBtn));

        }else{
            
            var nickNameContent; 
            if(editVal == 'Add'){
                nickNameContent = _yui.Node.create('<div style="text-decoration:underline;" onclick="_AssignmentLookupHandler.doEnterNickName(\''+aid +'\', this);return false;"></div>');
            }else{
                nickNameContent = _yui.Node.create('<div onclick="_AssignmentLookupHandler.doEnterNickName(\''+aid +'\', this);return false;"></div>');
            }
            nickNameContent.set('text', editVal);
            nickNameContent.appendChild(_yui.Node.create('<img class="editNickNameImageHolder" title="Edit Nickname" alt="Edit Nickname" src="/s.gif" >'));/*in xtml place </img>*/
            
            nickNameHolder.appendChild(nickNameContent);
            
        }
    },
    doEnterNickName: function(aid, nickNameDiv) {
        _yui.one(nickNameDiv).one('img').remove();
        var lastVal = _yui.one(nickNameDiv).get('text');
        var nickNameHolder = _yui.one(nickNameDiv).ancestor('div');
        _AssignmentLookupHandler.toggleNicknameEdit(aid, escape(lastVal), nickNameHolder,true);
    },
    
    onNickNameCancleAction : function(aid,oldVal, cancleButton) {
        var nickNameHolder = _yui.one(cancleButton).ancestor('div');
        _AssignmentLookupHandler.toggleNicknameEdit(aid, oldVal, nickNameHolder,false);
    },
    
    onNickNameSaveAction : function(aid,saveButton,oldInnerHTML) {
        var nickNHolder = _yui.one(saveButton).ancestor('div'); 
        var nickNameVal = nickNHolder.one('textarea').get('value');
        
        var currentRow = _yui.one(saveButton).ancestor('tr');
        
        _yui.one(document.getElementById(_VFComponent.nickNameSection_assignmentId)).set('value', aid );
        _yui.one(document.getElementById(_VFComponent.nickNameSection_nickName)).set('value', nickNameVal);
       
        jsUpdateAssignmentNickName();
        
        _AssignmentLookupHandler.toNickNameCache(aid,escape(nickNameVal));

        
        //==============Update the assignment name where-ever possible===============\\
        /*We need to refresh the assignment nickname in other locations (recent list/search assignments list), if any*/
        allNickNameTDs = _yui.all('#assigORProjOverlay .'+aid);
        for(i = 0; i < allNickNameTDs.size() ; i++){
            nickNameTD = allNickNameTDs.item(i);
            _AssignmentLookupHandler.toggleNicknameEdit(aid, isStringEmpty(nickNameVal) ? _Label.add : escape(nickNameVal), nickNameTD.one('.nickNameHolder'),false);
        }
        /*========  Now check if the assignment is selected in timecard row, 
            if so then replace assignment name there also ====================================*/
        /*  Check if nickname is blank, if so it means user is trying to delete the existing nickname. 
            In this case we need to show assignment name*/

        if(isStringEmpty(nickNameVal)){
            nickNameVal = currentRow.one('.assigNameTD').get('text').replace(/^\s+|\s+$/, '');
        }   

        // added to support assignment nick name change support on nickname change. 
        /*if(_yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignId)).get('value') == aid){
            _yui.one(document.getElementById(_VFComponent.expForm_assignmentSelect)).set('text',nickNameVal);       
            _yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignName)).set('value',nickNameVal);
        } */
        allRowBaseIdSpanNodes = _yui.all('.fakeSelectorClassForRowBaseId');
        for(i = 0; i < allRowBaseIdSpanNodes.size() ; i++){
        	assigIDHiddenNode = allRowBaseIdSpanNodes.item(i).one('input');
        	if(assigIDHiddenNode.get('value') == aid){
        		assigIDHiddenNodeID = assigIDHiddenNode.get('id');
        		rowBaseID = assigIDHiddenNodeID.substring(0, assigIDHiddenNodeID.lastIndexOf(':') + 1);
            	
        		_yui.one(document.getElementById(rowBaseID + "assignmentnamePanel")).set('text',nickNameVal);
        		_yui.one(document.getElementById(rowBaseID + "projectOrAssignmentNameHidden")).set('value',nickNameVal);
        		
        	} 
        } 
    },
    
    onNickNameMouseOver : function(nickNameHolder){
        editImage = _yui.one(nickNameHolder).one('img');
        if(editImage != null){
            editImage.addClass('editNickNameImageActive');
        }
    },
    onNickNameMouseOut : function(nickNameHolder){
    editImage = _yui.one(nickNameHolder).one('img');
        if(editImage != null){
            editImage.replaceClass('editNickNameImageActive','editNickNameImageHolder');
        }
    },
    //@TODO isBillable is not in use
    refreshAssigDependentDetails: function (aid,aname, nickName, isAssignment, isBillable, pid,toolTip, sMilestoneID, currencyIsoCode) {
	     aname= isStringNotEmpty(aname) ? unescape(aname) : aname;
	     toolTip = isStringNotEmpty(toolTip) ? unescape(toolTip) : toolTip;
	     
	     /*Check if nickname was updated if so then load from JS cache*/
	     nName = _AssignmentLookupHandler.fromNickNameCache(aid);
	     
	     if(isStringNotEmpty(nName)){
	     	nickName = nName;
	     }
	     nickName= isStringNotEmpty(nickName) ? unescape(nickName) : nickName;
	     if(_AssignmentLookupHandler.rowBaseUnEscId == null || isSelectDefaultAssignmentCall == 'true' ){
	      	_AssignmentLookupHandler.rowBaseUnEscId = _VFComponent.defaultAssignmentRowId;
	      }
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "infoImage")).set('alt', toolTip);
	      
	      // Changes done as fix for Agile Task: AT9165
	      if(_Config.displayBillable) {
	      	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLine")).set('checked', isBillable);
	      } else {
	      	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableHiddenLine")).set('checked', isBillable);
	      }
	      
	      document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "currencyISOCodeInput").value =  currencyIsoCode;
	      
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "assignmentnamePanel")).set('text',isStringNotEmpty(nickName) ? nickName : aname);
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projOrAssig")).set('value',isAssignment ? 'a' : 'p');
	      
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectOrAssignmentId")).set('value',aid);
	      
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectId")).set('value',pid);
	      
	      
	      _hasUnsavedChanges = true;
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "statusValue")).set('text','Unsaved');
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "dirtyHidden")).set('value','true');
	      if(isSelectDefaultAssignmentCall != 'true'){
	      	_AssignmentLookupHandler.hide();
	      }
	      isSelectDefaultAssignmentCall = 'false';
	      markRowEnabled(_AssignmentLookupHandler.rowBaseUnEscId);
	     
	      // Update the hidden field to keep track of the right value
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'hiddenMilestone')).set('value', sMilestoneID);
	      
	      // Fetch Milestones now !
	     rid = _yui.one(document.getElementById(_VFComponent.expForm_selectedResourceId)).get('value'); 
	     
		 //Changes done for Story:4742
	  	 if(aid == pid){
	    	var requestURL = _ajaxBrokerURL + '?action=loadAssignmentDetail&pid='+pid + '&rid='+rid ;
	  	 }else{
	    	var requestURL = _ajaxBrokerURL + '?action=loadAssignmentDetail&pid='+pid+'&aid='+aid + '&rid='+rid ;	
	  	 }
	  	 
	  	 // Method the load the expense rate/limits for the new selected project. 
	  	 jsLoadExpenseRateLimits();
	     
	     requestURL = requestURL + '&core.apexpages.devmode.url=1';
	     _yui.io(requestURL, { method:"GET", on:{success:_AssignmentLookupHandler.onAssignmentDetailLoad, failure:failureHandler } ,arguments:{selectedMilestoneID:sMilestoneID,projectId:pid}} );
	},
	onAssignmentDetailLoad : function(id, o, arguments) {
	    var milestoneOptions = new Array();
	    var methodologyOptions = new Array();
	    var phaseOptions = new Array();
	    
	    var root = o.responseXML.documentElement;
	    var milestoneParentTags = root.getElementsByTagName('milestones');
	    var milestoneTags = milestoneParentTags[0].getElementsByTagName('milestone');
	    var selectedValue = arguments['selectedMilestoneID'];
	    
	    var projId = arguments['projectId'];
	    var expenseRatesTags = root.getElementsByTagName('expenseRates');
	    var expenseRateTags = expenseRatesTags[0].getElementsByTagName('expenseRate');
	    populateExpenseRatesMap(projId,expenseRateTags);
	    
	    var expLimitCurrencyRatesTags = root.getElementsByTagName('expLimitCurrencyRates');
	    var expLimitCurrencyRateTags = expLimitCurrencyRatesTags[0].getElementsByTagName('expLimitCurrencyRate');
	    populateExpenseCurrencyRatesMap(projId,expLimitCurrencyRateTags);
	    
	    for(var  i= 0 ; i < milestoneTags.length ; i++){
	        var milestoneIDTag = milestoneTags[i].getElementsByTagName('id')[0].firstChild; 
	        var milestoneNameTag = milestoneTags[i].getElementsByTagName('name')[0].firstChild;
	        
	        var value = milestoneIDTag != null ? milestoneIDTag.nodeValue : '';
	        var label = milestoneIDTag != null ? milestoneNameTag.nodeValue : '';
	        var selectOption = new Option(label, value);
	        if(selectedValue == value){
	            selectOption.selected = true;
	        }
	        milestoneOptions.push(selectOption);
	    }
	    _MilestonesHandler.toCache(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'), milestoneOptions);
	    
	    /*@todo config _Config.showMilestoneOnFrontPage*/
	    if(!_Config.showMilestoneOnPopup){
	        var milestoneSelect = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'milestoneListPanel')).get('children').item(0);
	        var milestoneHtmlElemSelect = _yui.Node.getDOMNode(milestoneSelect);
	        _MilestonesHandler.copyTo(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'), milestoneHtmlElemSelect, selectedValue);
	    }
	    
	    /*Check if there is notes row belongs to the current row. Which is currentlly visible to the user
	     If so then check if milestone field is visible on notest popup. If found refresh the milestone options*/
	    //
	    //if (_Config.showMilestoneOnPopup && _NotesHandler.currentRowInEditing != null && toRowBaseIdFromRowIndex(_NotesHandler.currentRowInEditing) == _AssignmentLookupHandler.rowBaseId) {
	    /*@todo add _Config.showMilestoneOnPopup*/
	    if ( _Config.showMilestoneOnPopup && _NotesHandler.currentRowInEditing != null && toRowBaseIdFromRowIndex(_NotesHandler.currentRowInEditing) == _AssignmentLookupHandler.rowBaseId) {
	     	sRowBaseID = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
	    	_MilestonesHandler.copyTo(document.getElementById(sRowBaseID +'rowIndex').value, _yui.Node.getDOMNode(_yui.one('#milestoneSelect')), selectedValue);
		}
		
		/* Code added for story : 5210 */
		if(_Config.displayMethodology){
			var methodologyParentTags = root.getElementsByTagName('methodologies');
		    var methodologyTags = methodologyParentTags[0].getElementsByTagName('methodology');
			for(var  i= 0 ; i < methodologyTags.length ; i++){
		        var methodologyIDTag = methodologyTags[i].getElementsByTagName('id')[0].firstChild; 
		        var methodologyNameTag = methodologyTags[i].getElementsByTagName('name')[0].firstChild;
		        
		        var value = methodologyIDTag != null ? methodologyIDTag.nodeValue : '';
		        var label = methodologyIDTag != null ? methodologyNameTag.nodeValue : '';
		        var selectOption = new Option(label, value);
		        /*if(selectedValue == value){
		            selectOption.selected = true;
		        }*/
		        methodologyOptions.push(selectOption);
		    }
		    _MethodologiesHandler.toCache(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'), methodologyOptions);
		    
		    if(!_Config.showMethodologyOnPopup){
		        var methodologySelect = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'methodologyListPanel')).get('children').item(0);
		        var methodologyHtmlElemSelect = _yui.Node.getDOMNode(methodologySelect);
		        _MethodologiesHandler.copyTo(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'),methodologyHtmlElemSelect, '');
		    }
		    
		    if ( _Config.showMethodologyOnPopup && _NotesHandler.currentRowInEditing != null && toRowBaseIdFromRowIndex(_NotesHandler.currentRowInEditing) == _AssignmentLookupHandler.rowBaseId) {
		     	sRowBaseID = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
		    	_MethodologiesHandler.copyTo(document.getElementById(sRowBaseID +'rowIndex').value, _yui.Node.getDOMNode(_yui.one('#methodologySelect')), '');
			}
		}
		if(_Config.displayPhase){
			var phaseParentTags = root.getElementsByTagName('phases');
    		var phaseTags = phaseParentTags[0].getElementsByTagName('phase');
			for(var  i= 0 ; i < phaseTags.length ; i++){
		        var phaseIDTag = phaseTags[i].getElementsByTagName('id')[0].firstChild; 
		        var phaseNameTag = phaseTags[i].getElementsByTagName('name')[0].firstChild;
		        
		        var value = phaseIDTag != null ? phaseIDTag.nodeValue : '';
		        var label = phaseIDTag != null ? phaseNameTag.nodeValue : '';
		        var selectOption = new Option(label, value);
		        /*if(selectedValue == value){
		            selectOption.selected = true;
		        }*/
		        phaseOptions.push(selectOption);
		    }
		   _PhasesHandler.toCache(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'), phaseOptions);
		    
		    if(!_Config.showPhaseOnPopup){
		        var phaseSelect = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'phaseListPanel')).get('children').item(0);
		        var phaseHtmlElemSelect = _yui.Node.getDOMNode(phaseSelect);
		        _PhasesHandler.copyTo(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'rowIndex')).get('value'),phaseHtmlElemSelect, '');
		    }
		    
		    if ( _Config.showPhaseOnPopup && _NotesHandler.currentRowInEditing != null && toRowBaseIdFromRowIndex(_NotesHandler.currentRowInEditing) == _AssignmentLookupHandler.rowBaseId) {
		     	sRowBaseID = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
		    	_PhasesHandler.copyTo(document.getElementById(sRowBaseID +'rowIndex').value, _yui.Node.getDOMNode(_yui.one('#phaseSelect')), '');
			}
		}
	},
    //////////////////////////////////////////
    createAjaxResultsTable  : function (assignmentList, columnLabels, projAssignSectionTags, isAssignmentTable)
	{
        /*This is to decide columns width*/
        var totalColumns = columnLabels.length;
        var nameColumn_Width = 100/(totalColumns +1);
        var otherColumn_Width = nameColumn_Width;    
        var tableDiv = _yui.Node.create('<div style="overflow: auto !important; min-width:100%;"></div>')
        var table = isAssignmentTable ? _yui.Node.create('<table width="100%" id="assignmentResultsTable" cellspacing="0"></table>') : _yui.Node.create('<table width="100%" id="projectResultsTable" cellspacing="0"></table>') ;
        var tbody = _yui.Node.create('<tbody></tbody>');
        var tableTypeHeaderTR = _yui.Node.create('<tr class="projAssigDemarcation"></tr>');
        var isDataFound = true;
        var assignment = projAssignSectionTags;
        if(assignment != null && assignment.length > 0){
            for(i= 0 ; i < assignment.length ; i++){
                var aid = assignment[i].getElementsByTagName('id')[0].firstChild.nodeValue;
                var aname = assignment[i].getElementsByTagName('name')[0].firstChild.nodeValue;
        		
        		_AssignmentLookupHandler.assigCache[aid] = assignmentList[i];
            	var tr = _yui.Node.create('<tr onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}"></tr>');
				var nameTd = _yui.Node.create('<td class="assigNameTD" width="'+nameColumn_Width+'%"></td>');
                var assignmentSelectLink = _yui.Node.create('<a href="#" onclick="_AssignmentLookupHandler.doSelectAssignment(\''+aid +'\',\''+escape(aname)+'\');return false;" class="YUIFakeSelectorClassForResourceSelection"></a>');
                assignmentSelectLink.set('text',aname);
                nameTd.appendChild(assignmentSelectLink);
				tr.appendChild(nameTd);
				
				//To get nick name index id
				var nickNameIndex = -1;  
				if(isAssignmentTable)
				{
        		   for(var k = 0; k < columnLabels.length; k++) {
                       if(columnLabels[k].toString() == 'Nick Name') {
                       		nickNameIndex = k;
                       }
                   }
                }
				
				var fieldTags = assignment[i].getElementsByTagName('field');
        		for(j = 0 ; j < fieldTags.length ; j++){
        		    var fieldValue = fieldTags[j].firstChild.nodeValue;
        		    if( j == nickNameIndex)
        		    {
        		        var nickName = fieldValue;
			            var nickNameTd = _yui.Node.create('<td class="assigNickNameTD '+aid+'"></td>');
			           
			            var nickNameHolder;
			            if (_Config.nicknameEditable) {
			            	nickNameHolder = _yui.Node.create('<div class="nickNameHolder" onmouseover="_AssignmentLookupHandler.onNickNameMouseOver(this)" onmouseout="_AssignmentLookupHandler.onNickNameMouseOut(this)"></div>');
			            } else {
			            	nickNameHolder = _yui.Node.create('<div class="nickNameHolder"></div>');
			            }
			            nickNameTd.appendChild(nickNameHolder);
			            
			            if(nickName == null || nickName == '') {
			            	nickName = _Label.add;            	           	
			            }
						_AssignmentLookupHandler.toggleNicknameEdit(aid, escape(nickName), nickNameHolder,false);
			            tr.appendChild(nickNameTd);  
        		    }else{
        		    	fieldValue = ( fieldValue == null || fieldValue == 'null' || isStringEmpty(fieldValue)) ? '--' : fieldValue;
        			    var tdToAdd = _yui.Node.create('<td width="'+otherColumn_Width+'%">' + fieldValue + '</td>');
        			    tr.appendChild(tdToAdd);
        			}		
        		} 
        		
                tr.addClass('dataRow');
                tr.addClass(( i%2 == 0 ? 'even' : 'odd'));
                if(i == 0){tr.addClass(' first');}
                if(i == assignment.length-1){tr.addClass(' last');}
                tbody.appendChild(tr);
                    
            }
            var resultDemarcationTh = isAssignmentTable ? _yui.Node.create('<th colspan='+fieldTags.length+1+'> '+_Label.myAssignments+' </th>') :  _yui.Node.create('<th colspan='+fieldTags.length+1+'> '+_Label.globalProjects+' </th>'); 
   		    tableTypeHeaderTR.appendChild(resultDemarcationTh);
            var columnHeadLabels = new Array(_Label.name).concat(columnLabels);
            var thead = createThead(columnHeadLabels,0, tableTypeHeaderTR);
            table.appendChild(thead);
        }
        
        table.appendChild(tbody);
        table.addClass('list')
        _yui.all('#assignmentResultsTable td').addClass('dataCell');
       
        /*To sort the assignment by name*/
        if(isDataFound){
            _TableSortHandler.sortTable(thead.all('th').item(1),0);
        }
        tableDiv.appendChild(table);
        return tableDiv;
	}
    
}

var _AttachmentLookupHandler = {
    overlay : null,
    overlayContainer : null, 
    overlayEscKeyHandle : null,
    lastSearchString : null,
    rowBaseId : null,
    rowBaseUnEscId : null,
    assigCache : new Object(),
    config : {
    	toggleEditOverlay : true
    },
    prepare : function () {
        /* Create Overlay from script, this time. With no footer */
        _AttachmentLookupHandler.overlay = new _yui.Overlay({
            contentBox : "#attachmentOverlay", 
            width : "100%",
            zIndex:2
        });
        
        /* Center overlay in viewport */
        _AttachmentLookupHandler.overlay.set("centered", true);
        _AttachmentLookupHandler.overlay.render();
        _AttachmentLookupHandler.overlay.show();
        
        _AttachmentLookupHandler.overlayContainer = _yui.one('#attachmentOverlayContainer'); 
    },
    
    show : function (projectSelector, expenseId) {
    	document.getElementById('expenseAttachmentFrame').src = _expEntryFileAttacherURL+"?expid="+expenseId;
    	
        /*IE 7 bug fix*/
        validateZIndexForOverlay(true);
        if(_AttachmentLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        }
        
        _AttachmentLookupHandler.overlayContainer.setStyle('display', 'block');
        _AttachmentLookupHandler.overlay.set("centered", true);
        stablizeOverlay(_AttachmentLookupHandler.overlay);
        _AttachmentLookupHandler.overlayEscKeyHandle = _yui.on('key', _AttachmentLookupHandler.hide, document, 'down:27', _yui);
        
    },

    hide : function() {
        _AttachmentLookupHandler.overlayContainer.setStyle('display', 'none');
        _AttachmentLookupHandler.overlayEscKeyHandle.detach();  
       
        validateZIndexForOverlay(false);
        if(_AttachmentLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        } 
        document.getElementById('expenseAttachmentFrame').src = '';
        // calling method to update the attachment count info on expense line.
        updateAttachmentCount();  
    }
}

//======================================================================================
/* Handler for attachment tooltip 
Must have a image with alt text define and image class name should be [attachmentImage]
Added for Agile Task: AT6971   Dated : 3 Nov, 2012   
*/
var _AttachmentTooltipHandler = {
	toolTipOverlay : null,
	
    onMouseOver : function (e)
    {	
    	if(this.hasClass('attachmentImageOff')){
    		this.replaceClass('attachmentImageOff','attachmentImageOn');
    	}
        _AttachmentTooltipHandler.toolTipOverlay.set("bodyContent", this.get('alt'));
        _AttachmentTooltipHandler.toolTipOverlay.set("align", {node:this, 
                 points:[_yui.WidgetPositionAlign.BR, _yui.WidgetPositionAlign.TR]});
        _AttachmentTooltipHandler.toolTipOverlay.show();
        e.preventDefault();
    },
    onMouseOut : function (e)
    {
        if(this.hasClass('attachmentImageOn')){
    		this.replaceClass('attachmentImageOn','attachmentImageOff');
    	}
        _AttachmentTooltipHandler.toolTipOverlay.hide();
        e.preventDefault();
    },

    prepare : function() {
    	_yui.one('body').append(_yui.Node.create('<div id="attachmenttoolTipDiv" class="toolTipOverlay"></div>'));
        _AttachmentTooltipHandler.toolTipOverlay = new _yui.Overlay({
	        contentBox:"#attachmenttoolTipDiv",
	        visible:false
	    });
	    _AttachmentTooltipHandler.toolTipOverlay.render();
    },
    bindTooltip : function() {
		_yui.on("mouseover", _AttachmentTooltipHandler.onMouseOver, ".attachmentImage");
		_yui.on("mouseout", _AttachmentTooltipHandler.onMouseOut, ".attachmentImage");
	}
} 
//================== Ends here ============================


function doSelectResource(rid,rname){
    // changes done for agile task : 000011238   dated: 28/12/2011
    var doChange = _hasUnsavedChanges ? confirm(_Label.confirmUnsavedChanges) : true;
    if(doChange){
	    _yui.one(document.getElementById(_VFComponent.expForm_selectedResourceId)).set('value',rid);
	    _yui.one(document.getElementById(_VFComponent.expForm_resourceSelect)).set('text',unescape(rname));
	    _ResourceLookupHandler.hide();
	    beforeAjaxCall();
	    jsChangeResource();
	}
}

function onCancelClick(){
	var doCancel = _hasUnsavedChanges ? confirm(_Label.confirmUnsavedChanges) : true;
	if(doCancel){
		jsdoCancel();
	}
}

var failureHandler = function (id, o){
    alert("Error:"+ o.status + " " + o.statusText);
}




///////////////////////////////////////////////////////////////////////////
//---Following methods are extension/customization-----------------------//
//---of jsComponent.js's row highlighting and Notes section Script-------// 
///////////////////////////////////////////////////////////////////////////
//override for expense UI
_RowsHandler.getLinkLabel = function (newlyHoveredRowIndex){
	//_Label.editDetails : _Label.viewDetails;
	return _Label.editDetails;
}

_RowsHandler.getRowID = function (rowRef){
	return (_yui.one(rowRef)).get('id');
}
_RowsHandler.onRenderingExtension = function (currNode,currNodeIdx,allRows){
	currNode.set('id','rowForHighlighting'+currNodeIdx);
	
	currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
	//if (_yui.one(document.getElementById(currRowBaseId + 'type')).get('value') == '') {
	if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') == 'n') {
		markRowEnableORDisabled(currRowBaseId, 'disabled');
	}else{
		/*We are not using milestone field as input field so we need to push the milestone data manually on load of saaved expense*/
		// This logic should be executed if we have some project or assignment id selected.
		projectOrAssignmentId = _yui.one(document.getElementById(currRowBaseId + 'projectOrAssignmentId')).get('value');
		rowIndex = _yui.one(document.getElementById(currRowBaseId + 'rowIndex')).get('value');
		if (!_Config.showMilestoneOnPopup) {
			var milestoneForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenMilestone')).get('value');
			milestoneListPan = _yui.one(document.getElementById(currRowBaseId + 'milestoneListPanel'));
			if(milestoneListPan != null){
				milestoneNode = milestoneListPan.get('children').item(0);
				milestoneSelectList = _yui.Node.getDOMNode(milestoneNode);
				_MilestonesHandler.copyTo(rowIndex, milestoneSelectList, milestoneForThisRow);
			}
		}
		
		if (!_Config.showMethodologyOnPopup && _Config.displayMethodology) {
			var methodologyForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenMethodology')).get('value');
			methodologyListPan = _yui.one(document.getElementById(currRowBaseId + 'methodologyListPanel'));
			if(methodologyListPan != null){
				methodologyNode = methodologyListPan.get('children').item(0);
				methodologySelectList = _yui.Node.getDOMNode(methodologyNode);
				_MethodologiesHandler.copyTo(rowIndex, methodologySelectList, methodologyForThisRow);
			}
		}
		
		if (!_Config.showPhaseOnPopup && _Config.displayPhase) {
			var phaseForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenPhase')).get('value');
			phaseListPan = _yui.one(document.getElementById(currRowBaseId + 'phaseListPanel'));
			if(phaseListPan != null){
				phaseNode = phaseListPan.get('children').item(0);
				phaseSelectList = _yui.Node.getDOMNode(phaseNode);
				_PhasesHandler.copyTo(rowIndex, phaseSelectList, phaseForThisRow);
			}
		}
	}
}
_RowsHandler.isRowHighlightable = function(newlyHoveredRowIndex){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	if(_yui.one(document.getElementById(rowBaseId + 'projOrAssig')).get('value') == 'n'){
		return false;
	}
	
	return true;
}
_NotesHandler.setRowNumberToRetriveDataFromServer = function (forRowId) {
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	rowNumber = rowBaseIdFromRowIndexUnEscaped.slice(0,rowBaseIdFromRowIndexUnEscaped.lastIndexOf(":"));
	rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1);
	document.getElementById(_VFComponent.notesSection_selectedLineID).value = rowNumber;
}
 
_NotesHandler.setRowNumberToSaveDataToTheServer = function (forRowId) {
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	rowNumber = rowBaseIdFromRowIndexUnEscaped.slice(0,rowBaseIdFromRowIndexUnEscaped.lastIndexOf(":"));
	rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1);
	document.getElementById(_VFComponent.notesSection_selectedLineToSaveNoteDataID).value = rowNumber;
}	
_NotesHandler.copyNotesToRow = function (forRowId) {
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	saveNotesDialogData(rowBaseId);
}
_NotesHandler.copyRowToNotes = function (forRowId){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	//_NotesHandler.copyRowToNotes(rowBaseId);
	prepareNotesDialogData(rowBaseId);
}
	
_NotesHandler.resetNotesRowdata = function () {
	_yui.all('.fakeSelectorClassForNotesInput').set('value','');
	//there is new class for checkbox fakeSelectorClassForNotesInputCheckBox
	
	if(_Config.displayNonReimbursable && _Config.displayNonReimbursableOnPopup){
		_yui.one('.nonReimFieldFakeYUIStyle').set('checked',false);
	}
	//_yui.one('#billableAmountDiv').set('text','0.0');
	if(_Config.displayTaxNonBillable){
		_yui.one('.taxNonBillableFieldFakeYUIStyle').set('checked',_Config.defaultTaxNonBillable);
	}
}

function saveNotesDialogData(selectedRowBaseID) {
    /* don't update approved or submitted timecards. Check if current row is editable or not*/
    var bool_isRowEditable = document.getElementById(selectedRowBaseID + "isRowEditable").value == "true" ? true : false;
    if (!bool_isRowEditable){
        return;
    }
    setDirty(selectedRowBaseID + "statusValue", selectedRowBaseID + "dirtyHidden");
    
    if (_Config.showMilestoneOnPopup) {
		milestone = _yui.one('#milestoneSelect').get('value');
		/*
		if(milestone != null && milestone!= ''){
			document.getElementById(selectedRowBaseID + "hiddenMilestone").value = milestone;
		}
		*/
		//document.getElementById(selectedRowBaseID + "hiddenMilestone").value = (milestone == '' ? null : milestone);
		document.getElementById(selectedRowBaseID + "hiddenMilestone").value = (milestone == null || milestone == 'undefined' ? '' : milestone);
	}
	
	if (_Config.showMethodologyOnPopup && _Config.displayMethodology) {
		methodology = _yui.one('#methodologySelect').get('value');
		document.getElementById(selectedRowBaseID + "hiddenMethodology").value = (methodology == null || methodology == 'undefined' ? '' : methodology);
	}
	
	if (_Config.showPhaseOnPopup && _Config.displayPhase) {
		phase = _yui.one('#phaseSelect').get('value');
		document.getElementById(selectedRowBaseID + "hiddenPhase").value = (phase == null || phase == 'undefined' ? '' : phase);
	}
}
/*We need this to calculate billable amount*/
_NotesHandler.prepareNotesRowExtension = function (forRowId){
	_TooltipHandler.bindTooltip();
	// Added for Agile Task: AT6971   Dated : 3 Nov, 2012   
	_AttachmentTooltipHandler.bindTooltip();
	_yui.all(".amountFieldsStyle").on("key", function (e) { e.preventDefault();}, 'down:13', _yui);
	
	billabeAmountField = null;
	if(_NotesHandler.currentRowInEditing != null) {
		currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
		billabeAmountField = currentRow.one('.amountInputFieldFakeYUIStyle');
		
		calculateBillableAmountOnAmountChange(billabeAmountField);
		calculateAmountUsingExchangeRate(getExpenseRowByAnyInput(billabeAmountField));
		
		rowBaseId = toRowBaseIdFromRowIndexUnEscaped(forRowId);
		billableCheckboxInput = _Config.displayBillable ? currentRow.one('.billableLineInputStyle') : _yui.one(document.getElementById(rowBaseId +'billableHiddenLine'));
		
		markNonBillableAmountEnableOrDisable(billableCheckboxInput);
	}
}

// TODO : need to test
function prepareNotesDialogData(selectedRowBaseID ){
	//Check if current row is editable or not
	var bool_isRowEditable = document.getElementById(selectedRowBaseID + "isRowEditable").value == "true" ? true : false;
	//IF row is not editable then disable all editable fields or vice-versa on notes popup
	_yui.all('.fakeSelectorClassForNotesInput').set('disabled',!bool_isRowEditable);
	_yui.all('.fakeSelectorClassForNotesInputCheckBox').set('disabled',!bool_isRowEditable);
	
	//Check if Milestones options are renedred or not
	if (_Config.showMilestoneOnPopup) {
	    isCurrentRowMSClosed = document.getElementById(selectedRowBaseID + "hiddenIsMSClosed").value == "true" ? true : false;
	    if(!bool_isRowEditable && isCurrentRowMSClosed){
	    	msName = document.getElementById(selectedRowBaseID + "hiddenMilestoneName").value;
			_yui.Node.getDOMNode(_yui.one('#milestoneSelect')).options[0] = new Option(msName,'',''); 		 	    	
	    }else{
	    	var assigMilestone = document.getElementById(selectedRowBaseID + "hiddenMilestone").value;
		    _MilestonesHandler.copyTo(document.getElementById(selectedRowBaseID +'rowIndex').value, 
										_yui.Node.getDOMNode(_yui.one('#milestoneSelect')), assigMilestone);
		    
		    if(isStringNotEmpty(assigMilestone))
		    	document.getElementById('milestoneSelect').value = assigMilestone;
		}   
	}
	
	if (_Config.showMethodologyOnPopup && _Config.displayMethodology) {
	    if(!bool_isRowEditable){
	    	methName = document.getElementById(selectedRowBaseID + "hiddenMethodologyName").value;
			_yui.Node.getDOMNode(_yui.one('#methodologySelect')).options[0] = new Option(methName,'',''); 		 	    	
	    }else{
	    	var assigMethodology = document.getElementById(selectedRowBaseID + "hiddenMethodology").value;
		    _MethodologiesHandler.copyTo(document.getElementById(selectedRowBaseID +'rowIndex').value, 
										_yui.Node.getDOMNode(_yui.one('#methodologySelect')), assigMethodology);
		    
		    if(isStringNotEmpty(assigMethodology))
		    	document.getElementById('methodologySelect').value = assigMethodology;
		}   
	}
	
	if (_Config.showPhaseOnPopup && _Config.displayPhase) {
	    if(!bool_isRowEditable){
	    	psName = document.getElementById(selectedRowBaseID + "hiddenPhaseName").value;
			_yui.Node.getDOMNode(_yui.one('#phaseSelect')).options[0] = new Option(psName,'',''); 		 	    	
	    }else{
	    	var assigPhase = document.getElementById(selectedRowBaseID + "hiddenPhase").value;
		    _PhasesHandler.copyTo(document.getElementById(selectedRowBaseID +'rowIndex').value, 
										_yui.Node.getDOMNode(_yui.one('#phaseSelect')), assigPhase);
		    
		    if(isStringNotEmpty(assigPhase))
		    	document.getElementById('phaseSelect').value = assigPhase;
		}   
	}
	
	
}

//comehere
var _focusedExpenseTypeOldValue;
function onExpenseTypeChange(typeObj){
    if(_focusedExpenseTypeOldValue != '' && typeObj.value != ''){
    	return;
    }
    
    rowYUINode = _yui.one(typeObj).ancestor('tr');
    if(typeObj.value == ''){
    	//markRowEnableORDisabled(toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id')),'disabled');
    	if(_NotesHandler.currentRowInEditing == rowYUINode.get('id')){
    	   	beforeAjaxCall();
	   	}else{
	   		_yui.one(document.getElementById(_RowsHandler.hoveredRowIndex)).replaceClass('onRowSelected' , '');
	        // remove the edit overlay too.
	        if (_RowsHandler.editOverlay != null && _RowsHandler.editOverlay.get('visible')) {
	            _RowsHandler.editOverlay.hide();
	        }
	   	}
			
	}else{
		//markRowEnableORDisabled(toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id')),'');
		_RowsHandler.hoveredRowIndex = null;		
		rowYUINode.simulate("mouseover", { relatedTarget: document.body });
		
		//Done changes as fix for agile task: 000009272   Dated: 10/26/2010    By:Ashok
		// Added code for Non Reimbursable handling on front page for Agile Task : 000011014  Dated : 28 April,2011   By: Aditi
		var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
		if(_Config.displayBillable){
	        _yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).focus();
	    } else if (_Config.displayNonReimbursable && !_Config.displayNonReimbursableOnPopup) {
	    	// Added above first check as fix for Agile task: AT0779
	     	_yui.one(document.getElementById(rowBaseIDForYUI +'nonReimburOnFrontPage')).focus();
	    } else {
	    	_yui.one(document.getElementById(rowBaseIDForYUI +'descr')).focus();
	    }
	}
	
	_focusedExpenseTypeOldValue = typeObj.value;	
  	/* 	
	   	
    }else{
    	//This means we are enabling this for first time
    	if(_focusedExpenseTypeOldValue == ''){
    		markRowEnableORDisabled(toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id')),'');
    		_RowsHandler.hoveredRowIndex = null;
    	}
	}
	_RowsHandler.hoveredRowIndex = null;	
	rowYUINode.simulate("mouseover", { relatedTarget: document.body });
	*/	

	    	    	
}

function markNonBillableAmountEnableOrDisable(billableFieldYUINode) {
		
		isBillable = billableFieldYUINode.get('checked');
		/*
			Now enable/disable "Non-Billable Amount" 
			Blank out non-billable value only if exoense line is marked as nonbillable.
			Changes done as fix for agile task: 000008053   Dated: 09/09/2010
		*/
		// Added this new if condition, found error while testing AT0376  By:Aditi  Dated:20 March 2012
		if (_Config.displayTaxNonBillable) {
			_yui.one('.taxNonBillableFieldFakeYUIStyle').set('disabled', '');
		}
		if(!isBillable) {
			_Config.displayNonBillableIncurred ? _yui.one('.nonBillableIncurredAmountFieldFakeYUIStyle').set('value', '') : '';
						
			incurredTaxAmount = _yui.one('.incurredTaxAmountFieldFakeYUIStyle').get('value');
			
			// Done changes as fix for agile task: 000008016    Dated: 09/09/2010   By:Ashok
			if(_Config.displayTaxNonBillable) {
				if(isStringNotEmpty(incurredTaxAmount) && incurredTaxAmount > 0) {
					_yui.one('.taxNonBillableFieldFakeYUIStyle').set('checked', true);
					_yui.one('.taxNonBillableFieldFakeYUIStyle').set('disabled', 'disabled');
				}
			}
		}

		_Config.displayNonBillableIncurred ? _yui.one('.nonBillableIncurredAmountFieldFakeYUIStyle').set('disabled', isBillable ? '' : 'disabled') : '';
}

function markRowEnableORDisabled(rowBaseIDForYUI, disabledStatus){
	// Done changes for Agile Task: AT10961  Dated: 25 March, 2013
	_yui.one(document.getElementById(rowBaseIDForYUI +'expenseSelector')).set('disabled', disabledStatus);
    if(_Config.displayBillable){
        _yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).set('disabled', disabledStatus);
    }
    // Added code for Non Reimbursable handling on front page for Agile Task : 000011014  Dated : 28 April,2011   By: Aditi
    if (_Config.displayNonReimbursable && !_Config.displayNonReimbursableOnPopup) {
    	// Added above first check as fix for Agile task: AT0779
    	_yui.one(document.getElementById(rowBaseIDForYUI +'nonReimburOnFrontPage')).set('disabled', disabledStatus);
    }
    
    _yui.one(document.getElementById(rowBaseIDForYUI +'date')).set('disabled', disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI +'type')).set('disabled', disabledStatus);
    
    if(!_Config.showMilestoneOnPopup) {
    	_yui.one(document.getElementById(rowBaseIDForYUI +'milestoneListPanel')).one('select').set('disabled', disabledStatus);
    }
    if(!_Config.showMethodologyOnPopup && _Config.displayMethodology) {
    	_yui.one(document.getElementById(rowBaseIDForYUI +'methodologyListPanel')).one('select').set('disabled', disabledStatus);
    }
    if(!_Config.showPhaseOnPopup && _Config.displayPhase) {
    	_yui.one(document.getElementById(rowBaseIDForYUI +'phaseListPanel')).one('select').set('disabled', disabledStatus);
    }
    
    _yui.one(document.getElementById(rowBaseIDForYUI +'amountText')).set('disabled', disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI +'currencyISOCodeInput')).set('disabled', disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI +'descr')).set('disabled', disabledStatus);
    if(!_Config.showTaxtypeOnPopup) {
    _yui.one(document.getElementById(rowBaseIDForYUI +'expTaxType')).set('disabled', disabledStatus);
    }
    
    var parentNode = document.getElementById(rowBaseIDForYUI +'descr').parentNode;
    var grandParentNode = parentNode.parentNode;
    var nodes = grandParentNode.getElementsByClassName('disableExpenseAdditionalEditableFields');
    for (var i = 0, length = nodes.length; i < length; i++) {
     	_yui.one(nodes[i]).set('disabled', disabledStatus);
	}
}

function toRowBaseIdFromRowIndex(rowIndex) {
    hiddenElemId = _yui.one('#'+rowIndex + ' .hiddenTCInputCell input').get('id');
    return sfdcToJSID(hiddenElemId.substring(0, hiddenElemId.lastIndexOf(':') + 1));
}

function toRowBaseIdFromRowIndexUnEscaped(rowIndex) {
	anyInputInRow = _yui.one('#'+rowIndex + ' .hiddenTCInputCell input');
	if(anyInputInRow == null) return;
    hiddenElemId = anyInputInRow.get('id');
    return hiddenElemId.substring(0, hiddenElemId.lastIndexOf(':') + 1);
}

function markRowEnabled(rowBaseIDForYUI){
    markRowEnableORDisabled(rowBaseIDForYUI,'');
}

function toRowBaseIdFromAnyInput(anyInputDOMNode) {
    anyInputInRow = _yui.one(anyInputDOMNode);
    hiddenElemId = anyInputInRow.get('id');
    return hiddenElemId.substring(0, hiddenElemId.lastIndexOf(':') + 1);
}





function stablizeOverlay(overlayObj) {
        if(overlayObj.get('y') < 80) {
           overlayObj.set('y', 80);
        }
}


///////////////////////Editexpense page's utility method//////////////////////////////

function calculateBillableAmountForRow(rowYUINode){
	calculateBillableAmount(rowYUINode.one('.amountInputFieldFakeYUIStyle'),null,null,null,null) ;
}

function calculateBillableAmountOnAmountChange(amountFieldDOMNode){
	calculateBillableAmount(amountFieldDOMNode,null,null,null,null) ;
}

function calculateBillableAmount(amountInputField,nonBillableIncurredAmountParam, inncurredTaxParam, isBillableField, isTaxNonBillableField) {
    calculatedBillableAmount = 0.0;
    selectedRowCurrencyCode = null;
    currentRow = null;
    amount = 0.0;
    isBillable = true;
    ZeroValueField = 0.0   //added to set zero value in amount field.
    
    isTaxNonBillable = _Config.displayTaxNonBillable ? _yui.one('.taxNonBillableFieldFakeYUIStyle').get('checked') : false;
    nonBillableIncurredAmount = _Config.displayNonBillableIncurred ? _yui.one('.nonBillableIncurredAmountFieldFakeYUIStyle').get('value') : 0;
    
    //value changed according to specific locale.
    ZeroValueField = number_format(number_unformat(ZeroValueField), 2, _DEC_SEP, _THO_SEP);
    
    //incurredTaxAmount = isTaxNonBillable ?  _yui.one('.incurredTaxAmountFieldFakeYUIStyle').get('value') : 0;
    
    // Modified as fix for agile task: 000011239, Dated: Feb 4 2012 
    incurredTaxAmount = _yui.one('.incurredTaxAmountFieldFakeYUIStyle').get('value') ;
    
    //Modified as fix for agile task: 000010879, Dated: Jan 05 2011, Added By: Nitin Jain
    nonBillableIncurredAmount = number_unformat(nonBillableIncurredAmount);
    if(_Config.displayNonBillableIncurred){
    	var input_nonBillableIncurredAmount = _yui.one('.nonBillableIncurredAmountFieldFakeYUIStyle');
    	input_nonBillableIncurredAmount.set('value', number_format(number_unformat(input_nonBillableIncurredAmount.get('value')), 2, _DEC_SEP, _THO_SEP));
    }
    
    //Modified as fix for agile task: 000010879, Dated: Jan 05 2011, Added By: Nitin Jain
    incurredTaxAmount = number_unformat(incurredTaxAmount);
    var input_incurredTaxAmount = _yui.one('.incurredTaxAmountFieldFakeYUIStyle');
    input_incurredTaxAmount.set('value', number_format(number_unformat(input_incurredTaxAmount.get('value')), 2, _DEC_SEP, _THO_SEP));
    
    if(amountInputField != null){
        amountInputField = _yui.one(amountInputField);
        currentRow = amountInputField.ancestor('tr');
        if(currentRow.get('id') != _NotesHandler.currentRowInEditing){
            return;
        }
        amount = amountInputField.get('value');
    }else if(nonBillableIncurredAmountParam != null){
        currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
        amount = currentRow.one('.amountInputFieldFakeYUIStyle').get('value') ;
        selectedRowCurrencyCode = currentRow.one('.currencyCodeInputFieldFakeYUIStyle').get('value');
    }else if(inncurredTaxParam != null){
        currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
        amount = currentRow.one('.amountInputFieldFakeYUIStyle').get('value') ;
    }else if(isBillableField != null){
        isBillableField = _yui.one(isBillableField);
        currentRow = isBillableField.ancestor('tr');
        if(currentRow.get('id') != _NotesHandler.currentRowInEditing){
            return;
        }
        amount = currentRow.one('.amountInputFieldFakeYUIStyle').get('value');
    }else if(isTaxNonBillableField != null){
        currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
        amount = currentRow.one('.amountInputFieldFakeYUIStyle').get('value') ;
    }
    
    if(amount != null) {
    	// TODO: Look for some other fix as replacing commo is not always correct.
     	//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
     	//amount = amount.replace(/,/g,""); 
     	amount = number_unformat(amount);
    }
	
    rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
	billableCheckboxInput = _Config.displayBillable ? currentRow.one('.billableLineInputStyle') : _yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped +'billableHiddenLine'));

    if(billableCheckboxInput != null){
        isBillable = billableCheckboxInput.get('checked');
    }
    
    if(nonBillableIncurredAmount == null || nonBillableIncurredAmount < 0) {
     	nonBillableIncurredAmount = 0;
     	if(_Config.displayNonBillableIncurred){
     		input_nonBillableIncurredAmount.set('value', ZeroValueField);
     	}
    }else if(incurredTaxAmount == null || incurredTaxAmount < 0){
    	incurredTaxAmount = 0;
    	input_incurredTaxAmount.set('value', ZeroValueField);
    }	
    
    // Added as fix for agile task: 000011239, Dated: Jan 31 2012    
    if(isBillable){ 
    	if(isTaxNonBillable){
    		calculatedBillableAmount = amount - nonBillableIncurredAmount - incurredTaxAmount;
    	}else{
    		calculatedBillableAmount = amount - nonBillableIncurredAmount;
    	}
    }
    
    // Added as fix for agile task: 000011239, Dated: Feb 2 2012

    if(amount < 0 ){ 
     
    	// Added as fix for agile task: AT0376, Dated: Mar 19 2012
    	if(_Config.displayNonBillableIncurred){
    		input_nonBillableIncurredAmount.set('value', ZeroValueField);
    	}
    	input_incurredTaxAmount.set('value', ZeroValueField);
    	if(isBillable){
    		calculatedBillableAmount = (-1) * (amount);
    	}else{
    		calculatedBillableAmount = ZeroValueField;	
    	}
    }else if(calculatedBillableAmount < 0.0 ){
    	if(!isTaxNonBillable){
    		// Added as fix for agile task: AT0376, Dated: Mar 19, 2012
    		// case where "If" results in fail never happens at this point, but still applying it for safer side.
    		if(_Config.displayNonBillableIncurred){
    			input_nonBillableIncurredAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
    		}
    		input_incurredTaxAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
    		calculatedBillableAmount = ZeroValueField;
    	}
    	// Added as fix for agile task: AT0376, Dated: 20 March, 2012
    	else if(isTaxNonBillable) {
    		if (_Config.displayNonBillableIncurred) {
    			alert(_Label.invalidExpenseSubtotal);
    			if (nonBillableIncurredAmount > amount) {
    				input_nonBillableIncurredAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
    				nonBillableIncurredAmount = amount;
    			}
    			input_incurredTaxAmount.set('value', ZeroValueField);
    			calculatedBillableAmount = amount - nonBillableIncurredAmount;
    		} else { 
    			alert(_Label.invalidIncurredTaxAmount);
    			input_incurredTaxAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
    			calculatedBillableAmount = ZeroValueField;
    		}
    		input_incurredTaxAmount.focus();	
    	}
    }else if(incurredTaxAmount > amount){
    	input_incurredTaxAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
    }
    
    
    // get the selected row currency code.
    selectedRowCurrencyCode = currentRow.one('.currencyCodeInputFieldFakeYUIStyle').get('value');
    
    if(calculatedBillableAmount == null || calculatedBillableAmount <= 0){
        calculatedBillableAmount = 0.0;
    }
    billableAmountDivNode = _yui.one(document.getElementById('billableAmountDiv'));
    if(billableAmountDivNode != null){
    	//Modified as fix for agile task: 000009297, Dated: Dec 29 2010, Added By: Nitin Jain
    	//billableAmountDivNode.set('text',calculatedBillableAmount + ' ' + selectedRowCurrencyCode);
    	
    	
    	// Added as fix for agile task: 000011239, Dated: Feb 2 2012 
    	if(amount < 0.0 && isBillable){
    		billableAmountDivNode.set('text', ' - ' + number_format(calculatedBillableAmount, 2, _DEC_SEP, _THO_SEP) + ' ' + selectedRowCurrencyCode);
    	}
    	else{
    		billableAmountDivNode.set('text', number_format(calculatedBillableAmount, 2, _DEC_SEP, _THO_SEP) + ' ' + selectedRowCurrencyCode);
    	}	
    	
	}    
  
}

function displayExchangeRateSection(selectedExpenseRowCurrencyCode) {
	selectedResCurrencyCode = _yui.one('#selectedResourceCurrencyCode').get('value');
	if(selectedExpenseRowCurrencyCode != null) {
		if(selectedExpenseRowCurrencyCode != selectedResCurrencyCode) {
			return true;
		}
	}
	return false;
}

//--------- On change event handler functions -------------------

// Done changes as fix for agile task: 000008016    Dated: 09/09/2010   By:Ashok
function onIncurredTaxAmountChange(incurredTaxParamField) {
	if(_NotesHandler.currentRowInEditing != null) {
		currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
		
		// Done changes for fixing Agile task: AT10059   Dated: 7 Feb, 2013
		rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
		billableCheckboxInput = _Config.displayBillable ? currentRow.one('.billableLineInputStyle') : _yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped +'billableHiddenLine'));
		markNonBillableAmountEnableOrDisable(billableCheckboxInput);
	}	
	calculateBillableAmount(null,null,incurredTaxParamField,null,null);
}

//----------added this method as fix for B-3432---------------------
function setProjectAssignmentNameToHiddenVariable() {
	_yui.all("#editDetailRowParentTbody tr").each(
		function (currNode, currNodeIdx, allRows){
			if(isStringEmpty(currNode.get('id'))){return;}
			currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
			if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') != 'n' 
				&& _yui.one(document.getElementById(currRowBaseId + 'isRowEditable')).get('value') == 'true') {
				
				var projAssgName = _yui.one(document.getElementById(currRowBaseId + "assignmentnamePanel")).get('innerHTML');
                isRowDirty = _yui.one(document.getElementById(currRowBaseId + 'dirtyHidden')).get('value');
                if(isRowDirty == 'true'){
                	_yui.one(document.getElementById(currRowBaseId + 'projectOrAssignmentNameHidden')).set('value',projAssgName);
                }
    	    } 
		}
	)
}

//-------------added as fix for B-3432----------------------------------
function updateAttachmentCount() {
	prepareNotesDataToSaveBeforeAnyAction(); 
	setProjectAssignmentNameToHiddenVariable();
	beforeAjaxCall();
	jsUpdateAttachmentCount();
}

//Changes done as a fix for Agile Task : AT9943
function onSaveClick(){
	if(isSimilarAjaxRequestDisabled) {
		wait(true);
		setTimeout("finalSaveCall()", _Config.uiAjaxTimeoutMs + 3000);
	} else {
		finalSaveCall();
	}
}

function finalSaveCall() {
	prepareNotesDataToSaveBeforeAnyAction(); 
	setProjectAssignmentNameToHiddenVariable();
	beforeAjaxCall();
	jsOnSaveExpenses();
}

function onSubmitClick() {
	var isAnyRowSelected = checkIsAnySelected();
    if (isAnyRowSelected) {
		if(isSimilarAjaxRequestDisabled) {
			wait(true);
			setTimeout("finalSubmitCall()", _Config.uiAjaxTimeoutMs + 2000);	
		}else{
			finalSubmitCall();
		}		
	} else {
		alert(_Label.noRowSelectedForSubmit);
	}
}

function finalSubmitCall() {
	prepareNotesDataToSaveBeforeAnyAction();
	setProjectAssignmentNameToHiddenVariable();
	beforeAjaxCall();
	// Added as fix for Bug: B-2949  Dated: 29 Jan, 2013
	wait(true);
	jsOnSubmitExpenses();	
}

function onDeleteRowsClick(){
    var isAnyRowSelected = checkIsAnySelected();
    if (isAnyRowSelected) {
	    if (!confirm(_Label.confirmDeleteRows))
	        return;
	    // Added as fix for Agile task: AT2244  Dated: 27 July, 2012
	    prepareNotesDataToSaveBeforeAnyAction();
	    setProjectAssignmentNameToHiddenVariable();
		beforeAjaxCall();
	    jsDeleteRows();
	} else {
		alert(_Label.noRowSelectedForDelete);
	}
}
function onAddRowsClick(){
	// Added as fix for Agile task: AT2244  Dated: 27 July, 2012
	prepareNotesDataToSaveBeforeAnyAction();
	setProjectAssignmentNameToHiddenVariable();
	beforeAjaxCall();
	jsOnAddRows();
}
function onNewRowBeforedomupdate(){
}

function onExpenseBillableStatusChange(billableFieldObj){
	if(getExpenseRowIDByAnyInput(billableFieldObj) != _NotesHandler.currentRowInEditing){
            return;
    }
	calculateBillableAmount(null,null,null,billableFieldObj,null);	
	billableFieldYUINode = _yui.one(billableFieldObj);
	markNonBillableAmountEnableOrDisable(billableFieldYUINode);
}


/*Methods called after Ajax action completes*/
function onDeleteRowsDone(){
    bindAll();
}

//-- On change handler for exchange Rate field ---------
function onExpenseDateChange(exchangeDateDOMNode){
	updateDate(exchangeDateDOMNode);
	/*This calls server method to re-construct exchange rate map*/
	if (exchangeDateDOMNode.value == '')
		exchangeDateDOMNode.value = new Date();
	
	// Added changes as fix for AT: AT13302 to set focus on next field. 
	rowYUINode = _yui.one(exchangeDateDOMNode).ancestor('tr');
	var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
	_yui.one(document.getElementById(rowBaseIDForYUI +'type')).focus();
	
	disableSimilarAjaxRequest();
	jsOnExpenseDateChange();
}

//-- On change handler for exchange Rate field ---------
function onExchangeRateChange(exchangeRateDOMNode){
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
	udExchangeRate = exchangeRateDOMNode.value == 0 ? '' :exchangeRateDOMNode.value;
	_yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped + 'exchangeRateResDefined')).set('value',udExchangeRate);
	
	calculateAmountUsingExchangeRate(_yui.one('#'+_NotesHandler.currentRowInEditing));
}

//-- On change handler for Currency Type field ---------
function onExpenseCurrencyChange(expenseCurrencyDOMNode, isExpenseRateType, expTypeId, expUnitFieldId, distTextId, projFieldId){
	disableSimilarAjaxRequest();
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromAnyInput(expenseCurrencyDOMNode);
	_yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped + 'exchangeRateResDefined')).set('value','');
	
	// Added below as fix for agile task:000011036    Dated: 24 May, 2011
	if(isExpenseRateType) {
		convertExpenseAmountForRateExpType(expenseCurrencyDOMNode.value, expTypeId, expUnitFieldId,
									distTextId, getExpenseRowByAnyInput(expenseCurrencyDOMNode), projFieldId);
	}
	
	if(isExpenseRowIsInEditing(expenseCurrencyDOMNode)) {
		/*This is to refresh total billable amount*/
		calculateBillableAmountForRow(getExpenseRowByAnyInput(expenseCurrencyDOMNode));
		
		exchangeRateInputField = _yui.one('.exchangeRateFieldFakeYUIStyle');
		exchangeRateInputField.set('value', 0);
		calculateAmountUsingExchangeRate(getExpenseRowByAnyInput(expenseCurrencyDOMNode));
	}
	jsOnExpenseCurrencyChange();
}

// Added below as fix for agile task:000011036    Dated: 24 May, 2011
function convertExpenseAmountForRateExpType(selectedCurrencyCode, expTypeId, expUnitFieldId, distTxtId, editingRowYUINode, projFieldId) {

	amountYUINode = editingRowYUINode.one('.amountInputFieldFakeYUIStyle'); 
	rowNumber = getExpenseRowLineNumber(amountYUINode);
    amount = amountYUINode.get('value');
    
    var distTxt = document.getElementById(distTxtId);
    var val = number_unformat(distTxt.value);
    distTxt.value = number_format(val.toFixed(2), 2, _DEC_SEP, _THO_SEP);
    
    if (val == null || val == '')
        val = '0';
    if (!isNaN(parseFloat(val)))
    {
    	var projField = document.getElementById(projFieldId);
        if (projField == null || projField.value == null || projField.value == '')
            return;
            
        var unitField = document.getElementById(expUnitFieldId);
        if (unitField == null || unitField.value == null || unitField.value == '')
            return;
        var typeField = document.getElementById(expTypeId);
        if (typeField == null || typeField.value == null || typeField.value == '')
            return;
		
		var proj_expType = projField.value + '_' + typeField.value;            
        
        var rate = null;
        if(_expenseRatesByExpenseRowMap[rowNumber] == null) 
        {
        	rate = expenseRatesMap[proj_expType][unitField.value];
        	rateCurrencyISOCode = expenseRatesMap[proj_expType][unitField.value+'_code'];
        }
        else 
        {
        	rate = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value];
        
	        // If expense rate by date corresponding to the selected row is undefined, get the rate 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rate)  == "undefined"){
	        	rate = expenseRatesMap[proj_expType][unitField.value];
	        }
	        
	        var rateCurrencyISOCode = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value +'_code'];
	         
	        // If expense rate code by date corresponding to the selected row is undefined, get the code 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rateCurrencyISOCode)  == "undefined"){
	        	rateCurrencyISOCode = expenseRatesMap[proj_expType][unitField.value+'_code'];
	        }
	   	}
        
        if (rate == null)
            return;
        
        var oldAmtVal = amountYUINode.get('value');
        var amt = rate * parseFloat(val);
        if(selectedCurrencyCode != null) {
        	
        	// Done below changes as fix for AT: AT5085    Dated: 23 Aug, 2012
        	var exchangeRateForSelectedRowCurrency = 0;
        	var exchangeRateForRateCurrency = 0;
        	if(_Config.expenseDateToConvertRatesLimits) 
        	{
        		exchangeRateForSelectedRowCurrency = _currencyExchangeRatesMap[rowNumber][selectedCurrencyCode];
        		exchangeRateForRateCurrency = _currencyExchangeRatesMap[rowNumber][rateCurrencyISOCode];
        	}
        	 else 
        	{
	        	var xIndex = projField.value +'_' + typeField.value + '_' + unitField.value;
	        	if(_expenseRatesCurrencyRateByExpenseRowMap[rowNumber] == null) 
        		{
        			exchangeRateForSelectedRowCurrency = expenseRatesCurrencyRateMap[xIndex][selectedCurrencyCode];
			        exchangeRateForRateCurrency = expenseRatesCurrencyRateMap[xIndex][rateCurrencyISOCode];
        		} 
        		else 
        		{
			        exchangeRateForSelectedRowCurrency = _expenseRatesCurrencyRateByExpenseRowMap[rowNumber][selectedCurrencyCode];
        			exchangeRateForRateCurrency = _expenseRatesCurrencyRateByExpenseRowMap[rowNumber][rateCurrencyISOCode];
        			
        			if(typeof(exchangeRateForSelectedRowCurrency)  == "undefined" 
	        			|| typeof(exchangeRateForRateCurrency)  == "undefined" ) {
			        	exchangeRateForSelectedRowCurrency = expenseRatesCurrencyRateMap[xIndex][selectedCurrencyCode];
			        	
			        	// Done below changes as fix for AT: AT2684    Dated: 31 July, 2012
			        	exchangeRateForRateCurrency = expenseRatesCurrencyRateMap[xIndex][rateCurrencyISOCode];
			        }
        		}
	        }
	        amt = amt * (exchangeRateForSelectedRowCurrency/exchangeRateForRateCurrency);
        } 
        formatedAmt = number_format(amt.toFixed(2), 2, _DEC_SEP, _THO_SEP);
        amountYUINode.set('value', formatedAmt);
        amt = amountYUINode.get('value');
        
        /*This is to fire amount change so that we can recalculate the total amount and the billable amount*/
       /*
        if(oldAmtVal != null && oldAmtVal != amt) {
            onExpenseAmountChange(amountYUINode);
        }*/
    }
}

//-- On change handler for Amount field ---------
function onExpenseAmountChange(expenseAmountDOMNode){
	//Added as fix for agile task: 000009297, Dated: Dec 24 2010, Added By: Nitin Jain
	//---------------------------------Added Code of Lines----------------------------
	//var newAmountDOMNodeValue = toFloat(('' + expenseAmountDOMNode.value).replace(_THO_SEP, ''));
	var newAmountDOMNodeValue = number_unformat(expenseAmountDOMNode.value);
	//expenseAmountDOMNode.value = (newAmountDOMNodeValue.toFixed(2)).replace(".", _DEC_SEP);
	//expenseAmountDOMNode.value = formatNumber(newAmountDOMNodeValue.toFixed(2), 2, _THO_SEP, _DEC_SEP, '', '', '', '');
	
	expenseAmountDOMNode.value = number_format(newAmountDOMNodeValue, 2, _DEC_SEP, _THO_SEP);
	//---------------------------------Added Code of Lines----------------------------
	
	disableSimilarAjaxRequest();
	//To recalculate total expense amount
	jsOnExpenseAmountChange();
	
	// If current expense row is in editing then recaluclate reimbersment
	// amount and billable amount
	if(isExpenseRowIsInEditing(expenseAmountDOMNode)) {
		calculateBillableAmountOnAmountChange(expenseAmountDOMNode);
		calculateAmountUsingExchangeRate(getExpenseRowByAnyInput(expenseAmountDOMNode));
	}
}

function onExpenseDateChangeDone(){
	if(_NotesHandler.currentRowInEditing != null) {
		exchangeRateInputField = _yui.one('.exchangeRateFieldFakeYUIStyle');
		exchangeRateInputField.set('value', 0);
		calculateAmountUsingExchangeRate(_yui.one('#'+_NotesHandler.currentRowInEditing));
	}

	// -----------------Code block added which executes for each non blank row. Added as fix for B-3404--------------------
	_yui.all("#editDetailRowParentTbody tr").each(function(currNode, currNodeIdx, allRows) {
	        var disabledStatus = '' ;
	        rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
	        
	        var projOrAssigInputEl = document.getElementById(rowBaseIDForYUI + 'projOrAssig');
	        if (projOrAssigInputEl != null) {
	        	if(_yui.one(projOrAssigInputEl).get('value')  != 'n' ){
	        		_yui.one(document.getElementById(rowBaseIDForYUI + 'exchangeRateResDefined')).set('value','');
					expTypeId = _yui.one(document.getElementById(rowBaseIDForYUI +'type')).get('id');
					expUnitFieldId = _yui.one(document.getElementById(rowBaseIDForYUI +'unitField')).get('id');
					distTextId = _yui.one(document.getElementById(rowBaseIDForYUI +'distText')).get('id');
					selectedCurrencyCode = _yui.one(document.getElementById(rowBaseIDForYUI +'currencyISOCodeInput')).get('value');
					projectId = _yui.one(document.getElementById(rowBaseIDForYUI +'projectId')).get('id');
					
					convertExpenseAmountForRateExpType(selectedCurrencyCode, expTypeId, expUnitFieldId, distTextId, currNode, projectId);		
		        }
		    }
	});
	
	jsOnExpenseCurrencyChange();
	enableSimilarAjaxRequest();
}

function onResourceChangeDone(){
	bindAll();
	autoAssignmentSelect();
}

function onExpenseAmountChangeDone(){ 
	enableSimilarAjaxRequest();
}

function onExpenseCurrencyChangeDone(){
	enableSimilarAjaxRequest();
}



function calculateAmountUsingExchangeRate(editingRowYUINode) {
	exchangeRate = 0;	
	amount = 0;
    selectedRowCurrencyCode = null;
    currentRow = editingRowYUINode;
    
    amountYUINode = currentRow.one('.amountInputFieldFakeYUIStyle'); 
    amount = amountYUINode.get('value');
    
	selectedRowCurrencyCode = currentRow.one('.currencyCodeInputFieldFakeYUIStyle').get('value');
    
    if(amount != null) {
    	// TODO: Look for some other fix as replacing commo is not always correct.
    	//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
     	//amount = amount.replace(/,/g,""); 
     	amount = number_unformat(amount); 
    }
    
    exchangeRateInputField = _yui.one('.exchangeRateFieldFakeYUIStyle');
    if(exchangeRateInputField != null) {
    	//exchangeRate = exchangeRateInputField.get('value'); 
		rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(currentRow.get('id'));
		exchangeRate = _yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped + 'exchangeRateResDefined')).get('value');
		//Added as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
		exchangeRate = number_unformat(exchangeRate);
    }
    
    selectedResCurrencyCode = _yui.one('#selectedResourceCurrencyCode').get('value');
    
    if(displayExchangeRateSection(selectedRowCurrencyCode) == false) {    	
    	toggleExchangeRateSection(false);
    	exchangeRateInputField != null ? exchangeRateInputField.set('value', '') : '';
    	//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
    	//_yui.one('#ReimbursableAmountDiv').set('text', '0.0' + ' '+selectedResCurrencyCode);
    	_yui.one('#ReimbursableAmountDiv').set('text', number_format(0, 2, _DEC_SEP, _THO_SEP) + ' '+selectedResCurrencyCode); 
    	return;
    }
    	 
	rowNumber = getExpenseRowLineNumber(amountYUINode);
	
	// Done changes to support Agile Task: AT5085    Dated: 23 Aug, 2012
	var resCurrencyExchangeRate = _currencyExchangeRatesMap[rowNumber][selectedResCurrencyCode];
	var selectedRowCurrencyExchangeRate = _currencyExchangeRatesMap[rowNumber][selectedRowCurrencyCode];
	sysExchangeRate = (resCurrencyExchangeRate/selectedRowCurrencyExchangeRate);
	
	// appending the sysexchange rate to the fromtoExchange label
	
	//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
	//innerHTMLVal = selectedRowCurrencyCode +' to '+ selectedResCurrencyCode + ' (' + sysExchangeRate + ')';     
	innerHTMLVal = selectedRowCurrencyCode +' to '+ selectedResCurrencyCode + ' (' + number_format(sysExchangeRate, 6, _DEC_SEP, _THO_SEP) + ')';
    
    _yui.one('#fromToCurrencyCode').set('text', innerHTMLVal);
    
    isNonReimbursable = false;
    
    if(_Config.displayNonReimbursable){
		if (_Config.displayNonReimbursableOnPopup) {
			//Check if NonReimbursable fields is configured to display on popup
			isNonReimbursable = _yui.one('.nonReimFieldFakeYUIStyle').get('checked');
		}else{
			isNonReimbursable = currentRow.one('.nonReimFieldFakeYUIStyle').get('checked');
		}
	}
    
    if(!isNonReimbursable) {
	    if(exchangeRate != null && exchangeRate != '' && exchangeRate != 0) {
		    reimbursableAmount = amount*exchangeRate;
		    //Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain     
		    //exchangeRateInputField.set('value', exchangeRate);
		    exchangeRateInputField.set('value', number_format(exchangeRate, 6, _DEC_SEP, _THO_SEP));
		} else {
			//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
			//exchangeRateInputField.set('value', sysExchangeRate);
			exchangeRateInputField.set('value', number_format(sysExchangeRate, 6, _DEC_SEP, _THO_SEP));
			reimbursableAmount = amount*sysExchangeRate;  
		}
		// rounding to 2 decimal places. 
	    roundedReimbursableAmount = Math.round(reimbursableAmount*Math.pow(10,2))/Math.pow(10,2) ;
	    //Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
	    //_yui.one('#ReimbursableAmountDiv').set('text',roundedReimbursableAmount+' '+selectedResCurrencyCode);
	    _yui.one('#ReimbursableAmountDiv').set('text', number_format(roundedReimbursableAmount, 2, _DEC_SEP, _THO_SEP) + ' ' + selectedResCurrencyCode);
	} else {
		if(exchangeRate == null || exchangeRate == '' || exchangeRate == 0) {
			exchangeRateInputField.set('value', sysExchangeRate);
		}else{
			exchangeRateInputField.set('value', exchangeRate);
		}
		//Modified as fix for agile task: 000009297, Dated: Dec 28 2010, Added By: Nitin Jain
		//_yui.one('#ReimbursableAmountDiv').set('text', 0.0 +' '+selectedResCurrencyCode);
		_yui.one('#ReimbursableAmountDiv').set('text', number_format(0, 2, _DEC_SEP, _THO_SEP) + ' ' + selectedResCurrencyCode);
	}
	
	// setting from and to currency code for the selected row. Making this call at the ends 
	// as to show the section only after update with new values.
	toggleExchangeRateSection(true); 
}

function toggleExchangeRateSection(isVisible){
	_yui.all('.fakeSelectorClassForExchangeRateSection').set('style.visibility', isVisible ? '' : 'hidden');
}

function isExpenseRowIsInEditing(anyInputDOMNode){
	rowID = getExpenseRowIDByAnyInput(anyInputDOMNode);
	return (_NotesHandler.currentRowInEditing == rowID);
}
function getExpenseRowIDByAnyInput(anyInputDOMNode){
	return _yui.one(anyInputDOMNode).ancestor('tr').get('id');
}

function getExpenseRowByAnyInput(anyInputDOMNode){
	return _yui.one(anyInputDOMNode).ancestor('tr');
}
function getExpenseRowLineNumber(anyInputDOMNode){
	amountYUINode = _yui.one(anyInputDOMNode);
	var objId = amountYUINode.get('id');
    var rowNumber = objId.slice(0,objId.lastIndexOf(":"));
    rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1); 
    return rowNumber;
}    
/*change this*/
function onNonReimbursableChange(ifFieldOnMainUIThenTriggredNode) {
	isNonReimbursable = false
	selectedResCurrencyCode = _yui.one('#selectedResourceCurrencyCode').get('value');
	//Check if NonReimbursable fields is configured to display
	if(_Config.displayNonReimbursable){
		if (_Config.displayNonReimbursableOnPopup) {
			//Check if NonReimbursable fields is configured to display on popup
			isNonReimbursable = _Config.displayNonReimbursable ? _yui.one('.nonReimFieldFakeYUIStyle').get('checked') : false;
		}else{
			if(ifFieldOnMainUIThenTriggredNode != null){
				/*Check if this checkbox belongs to the any editable notes row*/
				if(getExpenseRowIDByAnyInput(ifFieldOnMainUIThenTriggredNode) != _NotesHandler.currentRowInEditing){
	            	return;
	    		}
				isNonReimbursable = ifFieldOnMainUIThenTriggredNode.checked;
			}
		}
	}
	 
	if(isNonReimbursable) {
		_yui.one('#ReimbursableAmountDiv').set('text', 0.0 +' '+selectedResCurrencyCode); 
	} else {
		calculateAmountUsingExchangeRate(_yui.one('#'+_NotesHandler.currentRowInEditing));
	}
}

///////////////////////////////////////////////////////////////ENDS EE utility





function beforeAjaxCall(){
    //This means notes detail section is opened, we need to close to prevent it from lost due to VF ajax rerender
    if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
        _NotesHandler.currentNotesInEditingDirty = false;
        _NotesHandler.onOK(true);
    }
}

function prepareNotesDataToSaveBeforeAnyAction(){
	if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
		/*Save notes data for the opend row*/
		if(_NotesHandler.currentNotesInEditingDirty){
			_NotesHandler.setRowNumberToSaveDataToTheServer(_NotesHandler.currentRowInEditing);
			_NotesHandler.copyNotesToRow(_NotesHandler.currentRowInEditing);
		}
	}
}

function bindAll(){
	/*@TODO may be another solution for this*/
	_yui.all(".amountFieldsStyle").on("key", function (e) { e.preventDefault();}, 'down:13', _yui); 
	
	_TooltipHandler.bindTooltip();
	// Added for Agile Task: AT6971   Dated : 3 Nov, 2012   
	_AttachmentTooltipHandler.bindTooltip();
    // For each row calulate if it needs to be disabled.
    _yui.all("#editDetailRowParentTbody tr").each(_RowsHandler.onRendering);
    //_yui.all(".dialogTextArea").on("keypress", validateNotesLength); 
    _NotesHandler.reset();
    _NotesHandler.inlineNotesTemplate = _yui.one('#notesContainer');

    _RowsHandler.reset();
    
    /*This is done to hide the edit detail link overlay.
    As the rerendering of table removes highlighted row but overlay.*/
    if(_RowsHandler.editOverlay.get('visible'))  {
		_RowsHandler.editOverlay.hide();
	}
	
	//------------code added as fix for B-3432  Dated: 15 May, 2013  By: Aditi--------
	_yui.all("#editDetailRowParentTbody tr").each(
		function (currNode, currNodeIdx, allRows){
			if(isStringEmpty(currNode.get('id'))){return;}
			currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
			if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') != 'n' 
				&& _yui.one(document.getElementById(currRowBaseId + 'isRowEditable')).get('value') == 'true') {
				
				var hiddenName = _yui.one(document.getElementById(currRowBaseId + 'projectOrAssignmentNameHidden')).get('value');
                isRowDirty = _yui.one(document.getElementById(currRowBaseId + 'dirtyHidden')).get('value');
                if(isRowDirty == 'true'){
                	_yui.one(document.getElementById(currRowBaseId + 'assignmentnamePanel')).set('value',hiddenName);
                	_yui.one(document.getElementById(currRowBaseId + 'assignmentnamePanel')).set('text',hiddenName);
                }
    	    } 
		}
	)
}
function prepareOverlays(){
    _TooltipHandler.prepare();
    // Added for Agile Task: AT6971   Dated : 3 Nov, 2012   
    _AttachmentTooltipHandler.prepare();
    _RowsHandler.prepare();
    _ResourceLookupHandler.prepare();
    _AssignmentLookupHandler.prepare();
    _AttachmentLookupHandler.prepare();
}

//------------- Edit Expense and Expense entry common function ------------------

function populateExpenseRatesMap(projId, expenseRateTags) {
	for(var  i= 0 ; i < expenseRateTags.length ; i++){
        var expType = expenseRateTags[i].getElementsByTagName('type')[0].firstChild.nodeValue;
        var expUnit = expenseRateTags[i].getElementsByTagName('unit')[0].firstChild.nodeValue;
        var rateAmount = expenseRateTags[i].getElementsByTagName('rateAmount')[0].firstChild.nodeValue;
        var rateCurrencyIsoCode = expenseRateTags[i].getElementsByTagName('currencyIsoCode')[0].firstChild.nodeValue; 
        
        var proj_expType = projId +'_'+ expType;
        
        if (expenseRatesMap[proj_expType] == null)
	        expenseRatesMap[proj_expType] = {};
	    
	    expenseRatesMap[proj_expType][expUnit] = rateAmount;
	    
	    // Done changes as fix for Bug: B-2456  Dated: 12 Aug, 2012
	    var expRateISOCode = expUnit +'_code';
	    expenseRatesMap[proj_expType][expRateISOCode] = rateCurrencyIsoCode;   
	    
	    var expenseRateTypes = '';
	    if (expenseRateTypes.indexOf(expType) < 0) {
	    	if (expenseRateTypes.length > 0) {
	    		expenseRateTypes += ',';
	    	}
	    	expenseRateTypes += expType;
	    }
	    _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'expenseRateTypes')).set('value', expenseRateTypes);
    }
    
}

function populateExpenseCurrencyRatesMap(projId, expLimitCurrencyRateTags) {
	for(var  i= 0 ; i < expLimitCurrencyRateTags.length ; i++){
		var expType = expLimitCurrencyRateTags[i].getElementsByTagName('type')[0].firstChild.nodeValue;
        var expUnit = expLimitCurrencyRateTags[i].getElementsByTagName('unit')[0].firstChild.nodeValue;
        
        var projTypeUnitIndex = projId + '_' + expType + '_' + expUnit;
        var currencyRatePairTags = expLimitCurrencyRateTags[i].getElementsByTagName('currencyRatePair');
	    if(currencyRatePairTags != null) {
	        for(var  j= 0 ; j < currencyRatePairTags.length ; j++) {
	        	if (expenseRatesCurrencyRateMap[projTypeUnitIndex] == null) {
	        		expenseRatesCurrencyRateMap[projTypeUnitIndex] = {};
	        	}
	        	var currencyIsoCode = currencyRatePairTags[j].getElementsByTagName('currencyIsoCode')[0].firstChild.nodeValue;
	        	var rateAmount = currencyRatePairTags[j].getElementsByTagName('rateAmount')[0].firstChild.nodeValue;
	        	expenseRatesCurrencyRateMap[projTypeUnitIndex][currencyIsoCode] = rateAmount;
	        }
	    }
	}
}

function onTypeChange(typeField, mileagePanelId, projectId){
    var mPanel = document.getElementById(mileagePanelId);
    var projId = document.getElementById(projectId).value;
    if (mPanel){
    	var proj_expType = projId +'_'+ typeField.value;
        if (expenseRatesMap[proj_expType] != null)
            mPanel.style.display = 'inline';
        else
            mPanel.style.display = 'none';
    }
}

function recalculateMileageAmt(typeFieldId, distTxtId, amtId, unitFld, currencyISOCodeId, projFldId)
{
    var distTxt = document.getElementById(distTxtId);
    
    //Modified as fix for agile task: 000009297, Dated: Dec 24 2010, Added By: Nitin Jain
    //var val = distTxt.value;
    //var val = toFloat(('' + distTxt.value).replace(_THO_SEP, ''));
    var val = number_unformat(distTxt.value);
    //distTxt.value = (val.toFixed(2)).replace(".", _DEC_SEP);
    //distTxt.value = formatNumber(val.toFixed(2), 2, _THO_SEP, _DEC_SEP, '', '', '', '');
    distTxt.value = number_format(val.toFixed(2), 2, _DEC_SEP, _THO_SEP);
    
    if (val == null || val == '')
        val = '0';
    if (!isNaN(parseFloat(val)))
    {
    	var projField = document.getElementById(projFldId);
        if (projField == null || projField.value == null || projField.value == '')
            return;
        
        var unitField = document.getElementById(unitFld);
        if (unitField == null || unitField.value == null || unitField.value == '')
            return;
        var typeField = document.getElementById(typeFieldId);
        if (typeField == null || typeField.value == null || typeField.value == '')
            return;
        
        rowNumber = getExpenseRowLineNumber(distTxt);
        
        var proj_expType = projField.value + '_' + typeField.value;
        
        var rate = null;
        if(_expenseRatesByExpenseRowMap[rowNumber] == null) 
        {
        	rate = expenseRatesMap[proj_expType][unitField.value];
        	rateCurrencyISOCode = expenseRatesMap[proj_expType][unitField.value+'_code'];
        }
        else 
        {
        	rate = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value];
        
	        // If expense rate by date corresponding to the selected row is undefined, get the rate 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rate)  == "undefined"){
	        	rate = expenseRatesMap[proj_expType][unitField.value];
	        }
	        
	        var rateCurrencyISOCode = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value +'_code'];
	        // If expense rate code by date corresponding to the selected row is undefined, get the code 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rateCurrencyISOCode)  == "undefined"){
	        	rateCurrencyISOCode = expenseRatesMap[proj_expType][unitField.value+'_code'];
	        }
	    }
        
        if (rate == null)
            return;
        
        var oldAmtVal = document.getElementById(amtId).value;
        var amt = rate * parseFloat(val);
        
        // Added below as fix for agile task:000011036    Dated: 24 May, 2011
        var currencyISOCode = document.getElementById(currencyISOCodeId).value;
        if(currencyISOCode != null) {
        	
        	// Done below changes as fix for AT: AT5085    Dated: 23 Aug, 2012
        	var exchangeRateForSelectedRowCurrency = 0;
        	var exchangeRateForRateCurrency = 0;
        	if(_Config.expenseDateToConvertRatesLimits) 
        	{
        		exchangeRateForSelectedRowCurrency = _currencyExchangeRatesMap[rowNumber][currencyISOCode];
        		exchangeRateForRateCurrency = _currencyExchangeRatesMap[rowNumber][rateCurrencyISOCode];
        	}
        	 else 
        	{
	        	var xIndex = projField.value +'_' + typeField.value + '_' + unitField.value;
	        	if(_expenseRatesCurrencyRateByExpenseRowMap[rowNumber] == null )
        		{	
        			exchangeRateForSelectedRowCurrency = expenseRatesCurrencyRateMap[xIndex][currencyISOCode];
			    	exchangeRateForRateCurrency = expenseRatesCurrencyRateMap[xIndex][rateCurrencyISOCode];
			    }
			    else 
			    {
        			exchangeRateForSelectedRowCurrency = _expenseRatesCurrencyRateByExpenseRowMap[rowNumber][currencyISOCode];
        			exchangeRateForRateCurrency = _expenseRatesCurrencyRateByExpenseRowMap[rowNumber][rateCurrencyISOCode];
        		
	        		if(typeof(exchangeRateForSelectedRowCurrency)  == "undefined" 
	        			|| typeof(exchangeRateForRateCurrency)  == "undefined" ) {
	        		
			        	exchangeRateForSelectedRowCurrency = expenseRatesCurrencyRateMap[xIndex][currencyISOCode];
	        			// Added as fix for AT: AT2683    Dated: 31 July, 2012
	        			exchangeRateForRateCurrency = expenseRatesCurrencyRateMap[xIndex][rateCurrencyISOCode];
			        }
			    }
			    
	        }
	        //Added as fix for agile task: AT12158
	        var alertMsg = _Label.errorNoExchangeRate;
	        if(typeof(exchangeRateForRateCurrency)  === "undefined"){
	            alertMsg = alertMsg.format(rateCurrencyISOCode);
	        	alert(alertMsg);
	        	amt = 0.00;
	        }else if(typeof(exchangeRateForSelectedRowCurrency)  === "undefined"){
	        	alertMsg = alertMsg.format(currencyISOCode);
	        	alert(alertMsg);
	        	amt = 0.00;
	        }else{
	        	amt = amt * (exchangeRateForSelectedRowCurrency/exchangeRateForRateCurrency);
	        }
        	
        } 
        //Modified as fix for agile task: 000009297, Dated: Dec 24 2010, Added By: Nitin Jain
        //document.getElementById(amtId).value = amt.toFixed(2);
        //document.getElementById(amtId).value = (amt.toFixed(2)).replace(".", _DEC_SEP);
        //document.getElementById(amtId).value = formatNumber(amt.toFixed(2), 2, _THO_SEP, _DEC_SEP, '', '', '', '');
        document.getElementById(amtId).value = number_format(amt.toFixed(2), 2, _DEC_SEP, _THO_SEP);
        amt = document.getElementById(amtId).value;
        
        /*This is to fire amount change so that we can recalculate the total amount and the billable amount*/
        if(oldAmtVal != null && oldAmtVal != amt) {
            onExpenseAmountChange(document.getElementById(amtId));
        }
    }
}

//--------- On change event handler functions Added as fix for Bug: 2797 -------------------
var isSimilarAjaxRequestDisabled = false;
function disableSimilarAjaxRequest(){

    _yui.all("#editDetailRowParentTbody tr").each(function(currNode, currNodeIdx, allRows) {
        var disabledStatus = 'disabled' ;
        currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
        
       var projOrAssigInputEl = document.getElementById(currRowBaseId + 'projOrAssig');
	   if (projOrAssigInputEl != null) {
	   		if(_yui.one(projOrAssigInputEl).get('value')  != 'n' ){
		        if(_yui.one(document.getElementById(currRowBaseId +'amountText')) != null)
		        	_yui.one(document.getElementById(currRowBaseId +'amountText')).set('disabled', disabledStatus);
		        
		        if(_yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')) != null)
		        	_yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')).set('disabled', disabledStatus);
		        
		        if(_yui.one(document.getElementById(currRowBaseId +'date')) != null)
		        	_yui.one(document.getElementById(currRowBaseId +'date')).set('disabled', disabledStatus);
	        }
	    }
        
       // _yui.all('.actionButton').set('disabled', disabledStatus);
      //  _yui.all('.actionButton').addClass('btnDisabled');
    });
    
	isSimilarAjaxRequestDisabled = true;
	setTimeout("enableSimilarAjaxRequest()", _Config.uiAjaxTimeoutMs); 

}

function enableSimilarAjaxRequest(){
	if(isSimilarAjaxRequestDisabled){
		isSimilarAjaxRequestDisabled = false;
	
	    _yui.all("#editDetailRowParentTbody tr").each(function(currNode, currNodeIdx, allRows) {
	        var disabledStatus = '' ;
	        currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
	        
	        var projOrAssigInputEl = document.getElementById(currRowBaseId + 'projOrAssig');
	        if (projOrAssigInputEl != null) {
	        	if(_yui.one(projOrAssigInputEl).get('value')  != 'n' ){
	        		if(_yui.one(document.getElementById(currRowBaseId +'amountText')) != null)
		        		_yui.one(document.getElementById(currRowBaseId +'amountText')).set('disabled', disabledStatus);
		        
			        if(_yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')) != null)
			        	_yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')).set('disabled', disabledStatus);
			        
			        if(_yui.one(document.getElementById(currRowBaseId +'date')) != null)
			        	_yui.one(document.getElementById(currRowBaseId +'date')).set('disabled', disabledStatus);
		        }
		    }
	        
	       // _yui.all('.actionButton').set('disabled', disabledStatus);
	       // _yui.all('.actionButton').removeClass('btnDisabled');
	
	    });
    }
}


//--- copyed from vf page -------------
function updateDate(obj)
{
    var objId = obj.id;
    var rowNumber = objId.slice(0,objId.lastIndexOf(":"));
    rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1);
    rowNumber = parseInt(rowNumber);
    rowNumber++;

    var tableLines = getLineItemsTable();
    var rowCount = tableLines.rows.length;
    var newDate = obj.value;
    var rpt = getTableItemParentId();

    for(i = rowNumber; i < rowCount - 1; i++)
    {
        var amount = document.getElementById(rpt + ':' + i + ':amountText');
        if(amount != null){
            var type = document.getElementById(rpt + ':' + i + ':type');
            var descr = document.getElementById(rpt + ':' + i + ':descr');
    		
            if ((amount.value == null || amount.value.length == 0 || parseFloat(amount.value) == 0) 
                && (type.value == '' || type.value=="none") && descr.value == '')
            {
               var date = document.getElementById(rpt + ':' + i + ':date');
               if (newDate != '')
               	date.value = newDate;
            }
        }
    }
}

function formatNumber(numberToFormat, decimalUpto, thousandDelimiter, decimalDelimiter, currencySymbolPrefix, currencySymbolSuffix, formatDelimiter1, formatDelimiter2){
    var x = Math.round(numberToFormat * Math.pow(10, decimalUpto));
    if(x >= 0)
        formatDelimiter1 = formatDelimiter2 = '';
    
    var y = ('' + Math.abs(x)).split('');
    var z = y.length - decimalUpto;
    
    if(z < 0)
        z--;
    
    for(var i = z; i < 0; i++)
        y.unshift('0');
    
    y.splice(z, 0, decimalDelimiter);   
    if(y[0] == decimalDelimiter)
        y.unshift('0');
        
    while (z > 3){
        z -= 3;
        y.splice(z, 0, thousandDelimiter);
    }
    
    var r = currencySymbolPrefix + formatDelimiter1 + y.join('') + formatDelimiter2 + currencySymbolSuffix;
    return r;
}

function number_format (unumber, decimals, dec_point, thousands_sep){
    // Formats a number with grouped thousands
    //
    // version: 906.1806
    // discuss at: http://phpjs.org/functions/number_format
    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +     bugfix by: Michael White (http://getsprink.com)
    // +     bugfix by: Benjamin Lupton
    // +     bugfix by: Allan Jensen (http://www.winternet.no)
    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +     bugfix by: Howard Yeend
    // +    revised by: Luke Smith (http://lucassmith.name)
    // +     bugfix by: Diogo Resende
    // +     bugfix by: Rival
    // +     input by: Kheang Hok Chin (http://www.distantia.ca/)
    // +     improved by: davook
    // +     improved by: Brett Zamir (http://brett-zamir.me)
    // +     input by: Jay Klehr
    // +     improved by: Brett Zamir (http://brett-zamir.me)
    // +     input by: Amir Habibi (http://www.residence-mixte.com/)
    // +     bugfix by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: number_format(1234.56);
    // *     returns 1: '1,235'
    // *     example 2: number_format(1234.56, 2, ',', ' ');
    // *     returns 2: '1 234,56'
    // *     example 3: number_format(1234.5678, 2, '.', '');
    // *     returns 3: '1234.57'
    // *     example 4: number_format(67, 2, ',', '.');
    // *     returns 4: '67,00'
    // *     example 5: number_format(1000);
    // *     returns 5: '1,000'
    // *     example 6: number_format(67.311, 2);
    // *     returns 6: '67.31'
    // *     example 7: number_format(1000.55, 1);
    // *     returns 7: '1,000.6'
    // *     example 8: number_format(67000, 5, ',', '.');
    // *     returns 8: '67.000,00000'
    // *     example 9: number_format(0.9, 0);
    // *     returns 9: '1'
    // *     example 10: number_format('1.20', 2);
    // *     returns 10: '1.20'
    // *     example 11: number_format('1.20', 4);
    // *     returns 11: '1.2000'
    // *     example 12: number_format('1.2000', 3);
    // *     returns 12: '1.200'
    
    if(unumber == null)
        unumber = 0;
    if(unumber == '')
        unumber = 0;
    if(trim(unumber.toString()).length == 0)
        unumber = 0;
    if(isNaN(unumber))
        unumber = 0;
    
    var n = unumber, prec = decimals;
    
    var toFixedFix = function (n, prec){
        var k = Math.pow(10, prec);
        return (Math.round(n * k) / k).toString();
    };
    
    n = !isFinite(+n) ? 0 : +n;
    prec = !isFinite(+prec) ? 0 : Math.abs(prec);
    var sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep;
    var dec = (typeof dec_point === 'undefined') ? '.' : dec_point;
    
    var s = (prec > 0) ? toFixedFix(n, prec) : toFixedFix(Math.round(n), prec); //fix for IE parseFloat(0.55).toFixed(0) = 0;
    var abs = toFixedFix(Math.abs(n), prec);
    var _, i;
    
    if (abs >= 1000) {
        _ = abs.split(/\D/);
        i = _[0].length % 3 || 3;
        
        _[0] = s.slice(0,i + (n < 0)) +
        _[0].slice(i).replace(/(\d{3})/g, sep + '$1');
        s = _.join(dec);
    } else {
        s = s.replace('.', dec);
    }
    
    var decPos = s.indexOf(dec);
    if (prec >= 1 && decPos !== -1 && (s.length - decPos-1) < prec) {
        s += new Array(prec - (s.length - decPos -1)).join(0) + '0';
    }
    else if (prec >= 1 && decPos === -1) {
        s += dec + new Array(prec).join(0) + '0';
    }
    return s;
}

function number_unformat(numberToUnformat){
    var new_num = '0.0';
    if(numberToUnformat != null){
        if(trim(numberToUnformat.toString()) != '' && trim(numberToUnformat.toString()).length > 0){
            // Changes as fix for Bug: B-2776  Dated: 23 Nov, 2012
            numberToUnformat = numberToUnformat.toString().replace(new RegExp('\\'+_THO_SEP, "g"), '');
            numberToUnformat = numberToUnformat.toString().replace(_DEC_SEP, '.');
            new_num = isNaN(numberToUnformat) ? parseFloat('0.0') : parseFloat(numberToUnformat);
        }
    }
    return parseFloat(new_num);
}

function trim(stringToTrim){
    return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function ltrim(stringToTrim){
    return stringToTrim.replace(/^\s+/,"");
}

function rtrim(stringToTrim){
    return stringToTrim.replace(/\s+$/,"");
}

// Added for Agile Task : AT9392  Dated: 22 Jan, 2013
function showHideExpenseReportGrid(imgDomNode){
	imgNode = _yui.one(imgDomNode);
	if (imgNode.hasClass('hideListButton')) {
		imgNode.replaceClass('hideListButton','showListButton');
		document.getElementById(_VFComponent.expForm_erSectionShowHideStyle).value = 'showListButton';
		document.getElementById('ExpenseReportFrame').src = '';
	} else {
		imgNode.replaceClass('showListButton','hideListButton');
		document.getElementById(_VFComponent.expForm_erSectionShowHideStyle).value = 'hideListButton';
		document.getElementById('ExpenseReportFrame').src = expenseReportGridURL;
	}
}