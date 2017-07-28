var _GlobalVariables = {
	// added changes for AT5203
	anyMainUIFieldNeedToBeUpdatedOnAssignmentChange : (_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord)|| (_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord) || (_Config.showPrimaryLocationOnFrontPage && _Config.useProjectLocationRecord) || (_Config.showEasyEntryPopup), 
	anyDetailUIFieldNeedToBeUpdatedOnDetailSectionOpen : (_Config.showPrimaryLocationOnPopup && _Config.useProjectLocationRecord) ||(_Config.noteLocationAllowed && _Config.useProjectLocationRecord) || (_Config.showPhaseOnPopup && _Config.useProjectPhaseRecord) || (_Config.showMethodologyOnPopup && _Config.useProjectMethodologyRecord),
	easyEntrySectionRowId : null
}

// EVENT HANDLERS
var _AssignmentLookupHandler = {
	overlay : null,
	overlayContainer : null, 
	overlayEscKeyHandle : null,
	lastSearchString : null,
	rowBaseId : null,
    rowBaseUnEscId : null,
     config : {
    	columnLabelManager : {
    		// loading labels every time result table is formed as if configs changes after UI load them there is mismatch occurring in header row and value row. Changes done for B-3466  By: Aditi
    		// isLabelsLoaded : function(){ return _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels != null && _AssignmentLookupHandler.config.columnLabelManager.assignColumnLabels.length > 0 ;},
    		isLabelsLoaded : function(){ return false;},
    		assignColumnLabels : new Array(),
    		projColumnLabels : new Array()
    	}
    },
	assigCache : new Object(),
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
		toggleEditOverlayToPreventIE7Bug();
		
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
	    toggleEditOverlayToPreventIE7Bug();   
	},
	
	search : function (listAll) {
	    var searchString = listAll ? _yui.one('#assigORProjSearchString').get('value') : '';
	    _yui.one("#assignmentLoadWaitImageID").set('style.visibility', 'visible');
	    var week = _yui.one("#currentWeekendInMillis").get('value');
	    var rid = _yui.one(document.getElementById(_VFComponent.tcForm_selectedResourceId)).get('value');
	    var requestURL = _ajaxBrokerURL + encodeURI('?s=' + encodeURIComponent(searchString)) + '&core.apexpages.devmode.url=1&action=loadAssignments' + '&week='+ week + '&rid='+rid + '&loadLabels=' + ! _AssignmentLookupHandler.config.columnLabelManager.isLabelsLoaded();
	    

	    _yui.io(requestURL, { method:"GET", on:{success:_AssignmentLookupHandler.onAssignmentsLoad, failure:failureHandler }} );
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
	     var toolTip = escape(root.getElementsByTagName('tooltip')[0].firstChild.nodeValue);
	     var isBillable = root.getElementsByTagName('billable')[0].firstChild.nodeValue == "true";
	     var isDailyNotesRequired = root.getElementsByTagName('dailynotesrequired')[0].firstChild.nodeValue == "true";
	     var pid = root.getElementsByTagName('projectId')[0].firstChild.nodeValue;    
	     var selectedMilestoneID =  root.getElementsByTagName('selectedMilestoneID')[0].firstChild.nodeValue;
	     
	     _AssignmentLookupHandler.refreshAssigDependentDetails(aid,aname, nickName, isAssignment, toolTip, isBillable, isDailyNotesRequired,  pid, selectedMilestoneID);
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
		// Added changes for AT2181  Dated: 26 July,2012  BY: Aditi 
		if (!_Config.nicknameEditable) {
			var nickNameContent; 
		   	if(editVal == 'Add'){
		   		nickNameContent = _yui.Node.create('<div></div>');
		   	}else{
		   		nickNameContent = _yui.Node.create('<div> </div>');
		   		nickNameContent.set('text', editVal);
		   	}
            nickNameHolder.appendChild(nickNameContent);
		} 
		else 
		{
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
			   		nickNameContent = _yui.Node.create('<div style="text-decoration:underline;" onclick="_AssignmentLookupHandler.doEnterNickName(\''+aid +'\', this);return false;"> </div>');
			   	}else{
			   		nickNameContent = _yui.Node.create('<div onclick="_AssignmentLookupHandler.doEnterNickName(\''+aid +'\', this);return false;"> </div>');
			   	}
			   	nickNameContent.set('text', editVal);
			   	nickNameContent.appendChild(_yui.Node.create('<img class="editNickNameImageHolder" title="Edit Nickname" alt="Edit Nickname" src="/s.gif" >'));/*in xtml place </img>*/
				
		        nickNameHolder.appendChild(nickNameContent);
		        
		    }
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
        /*========	Now check if the assignment is selected in timecard row, 
        	if so then replace assignment name there also ====================================*/
        /*	Check if nickname is blank, if so it means user is trying to delete the existing nickname. 
        	In this case we need to show assignment name on the TC UI*/

        if(isStringEmpty(nickNameVal)){
        	nickNameVal = currentRow.one('.assigNameTD').get('text').replace(/^\s+|\s+$/, '');
		}	

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
	refreshAssigDependentDetails: function (aid,aname, nickName, isAssignment, toolTip, isBillable, isDailyNotesRequired, pid, sMilestoneID) {
	     onAssignmentSelected(aid);
	     /*If timecard is already saved and now user is changing it */
	     /*
	     var hiddenAdminGECheck = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "selectorDivToDecideDecideAdminGECheck")).one('.fakeSelectorClassToDecideAdminGECheck').get('value');
	     
	     if(hiddenAdminGECheck != null && hiddenAdminGECheck == true || hiddenAdminGECheck == 'true'){
	     	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "hiddenAdminGE")).set('value', true);
	     	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "tcAuditNotes")).set('value', 'Updated');
	     	
	     }
	     */
	     
	     aname= isStringNotEmpty(aname) ? unescape(aname) : aname;
	     toolTip= isStringNotEmpty(toolTip) ? unescape(toolTip) : toolTip;
	     
	     /*Check if nickname was updated if so then load from JS cache*/
	     nName = _AssignmentLookupHandler.fromNickNameCache(aid);
	     
	     if(isStringNotEmpty(nName)){
	     	nickName = nName;
	     }
	     nickName= isStringNotEmpty(nickName) ? unescape(nickName) : nickName;
	      
	      var notesReqDiv = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "dailyNotesRequiredDiv")) ;
	      if(notesReqDiv != null)
	      	notesReqDiv.set('style.display', (isDailyNotesRequired ? "inline" : "none"));
	      	
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "infoImage")).set('alt', toolTip);
	      
		  if(_Config.showBillableOnLeft) {     
	     	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")).set('checked', isBillable) : _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "hiddenBillableLeft")).set('value', isBillable);
	      }else{
	      	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")).set('checked', isBillable) : _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "hiddenBillable")).set('value', isBillable);
	      }
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "assignmentnamePanel")).set('text',isStringNotEmpty(nickName) ? nickName : aname);
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projOrAssig")).set('value',isAssignment ? 'a' : 'p');
	      
	      var projectOrAssignmentIdOld = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectOrAssignmentId")).get('value');
	      if(projectOrAssignmentIdOld != null && projectOrAssignmentIdOld.length > 0 && projectOrAssignmentIdOld != aid) {
	      	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectOrAssignmentIdOld")).set('value',projectOrAssignmentIdOld);	
	      }else{
	      	_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectOrAssignmentIdOld")).set('value',aid);	
	      }
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "projectOrAssignmentId")).set('value',aid);
	      
	      _hasUnsavedChanges = true;
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "statusValue")).set('text','Unsaved');
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "dirtyHidden")).set('value','true');
	      
	      _AssignmentLookupHandler.hide();
	      markRowEnabled(_AssignmentLookupHandler.rowBaseUnEscId);
	      
	      // Update the hidden field to keep track of the right value
	      _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'hiddenMilestone')).set('value', sMilestoneID);
	      
	      var createBeanTimestampMS = document.getElementById('createBeanTimestampInMilliSec').value; 
	      // Fetch Milestones now !
	      //Updated as a fix for Story:4740
	      if(aid == pid){
	           var requestURL = _ajaxBrokerURL + '?core.apexpages.devmode.url=1&action=loadAssignmentDetail&pid='+pid+'&TimestampInMilliSec='+createBeanTimestampMS;	
	      }else{
	           var requestURL = _ajaxBrokerURL + '?core.apexpages.devmode.url=1&action=loadAssignmentDetail&pid='+pid+'&aid='+aid+'&TimestampInMilliSec='+createBeanTimestampMS;	
	      }	       
	     
	     _yui.io(requestURL, { method:"GET", on:{success:_AssignmentLookupHandler.onAssignmentDetailLoad, failure:failureHandler } ,arguments:{selectedMilestoneID:sMilestoneID}} );
	},

	onAssignmentDetailLoad : function(id, o, arguments) {
	    var milestoneOptions = new Array();
	    
	    var root = o.responseXML.documentElement;
	    var milestoneTags = root.getElementsByTagName('milestone');
	    var selectedValue = arguments['selectedMilestoneID'];
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
		var tcRowId = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "infoImage")).ancestor('tr').get('id');
	    _MilestonesHandler.toCache(tcRowId, milestoneOptions);
		
		if(_Config.showMilestoneOnFrontPage) {
	    	if(_Config.showMilestoneOnLeft) {
	    		var milestoneSelect = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'milestoneListLeftPanel')).get('children').item(1);
	        	var milestoneHtmlElemSelect = _yui.Node.getDOMNode(milestoneSelect);
	        	_MilestonesHandler.copyTo(tcRowId, milestoneHtmlElemSelect, selectedValue);
			} else {
				var milestoneSelect = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId +'milestoneListPanel')).get('children').item(1);
	        	var milestoneHtmlElemSelect = _yui.Node.getDOMNode(milestoneSelect);
	        	_MilestonesHandler.copyTo(tcRowId, milestoneHtmlElemSelect, selectedValue);
			}
		}
	    
	    /*Check if there is notes row belongs to the current row. Which is currentlly visible to the user
	     If so then check if milestone field is visible on notest popup. If found refresh the milestone options*/
	    //
	    if (_Config.showMilestoneOnPopup && _NotesHandler.currentRowInEditing != null && toRowBaseIdFromRowIndex(_NotesHandler.currentRowInEditing) == _AssignmentLookupHandler.rowBaseId) {
	     	sRowBaseID = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
	    	_MilestonesHandler.copyTo(tcRowId, _yui.Node.getDOMNode(_yui.one('#milestoneSelect')), selectedValue);
		}

	},
	
	/* Code changes to fix AT10707 By: Sumit Dated : 4 March 2013 */
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

  

/**
	Handler related Batch processing  
*/
var _BatchProcessHandler = {
	overlay : null,
	overlayContainer : null, 
	prepare : function () {
	    /* Create Overlay from script, this time. With no footer */
	    _BatchProcessHandler.overlay = new _yui.Overlay({
	        contentBox : "#batchOverlay", 
	        width : "100%",
	        zIndex:3
	    });
	    
	    /* Center overlay in viewport */
	    _BatchProcessHandler.overlay.set("centered", true);
	    _BatchProcessHandler.overlay.render();
	    _BatchProcessHandler.overlay.show();
	    
	    _BatchProcessHandler.overlayContainer = _yui.one('#batchOverlayContainer'); 
	},
	    
    show : function () {
    	//@TODO FIXME: This makes overlay open slow
    	toggleEditOverlayToPreventIE7Bug();
	    _BatchProcessHandler.overlayContainer.setStyle('display', 'block');
	    _BatchProcessHandler.overlay.set("centered", true);
    },
    
    hide : function() {
	    _BatchProcessHandler.overlayContainer.setStyle('display', 'none');
	    toggleEditOverlayToPreventIE7Bug();
    }
}

/* Added as fix for agile Task : 000011098  Dated: 23/09/2011  By: Aditi */
/* Handler related to Recall Lookup */
var _RecallLookupHandler = {
	overlay : null,
	overlayContainer : null,
	overlayEscKeyHandle : null,
	
	prepare : function() {
		// Create Overlay from script, this time. With no footer
	    _RecallLookupHandler.overlay = new _yui.Overlay({
	        contentBox : "#recallOverlay", 
	        width : "100%",
	        zIndex:4
	    });
	    
	    _RecallLookupHandler.overlay.set("centered", true);
	    
	    _RecallLookupHandler.overlay.render();
	    _RecallLookupHandler.overlay.show();
	    _RecallLookupHandler.overlayContainer = _yui.one('#recallTimecardOverlayContainer'); 
	},
	
	attachEscKey : function () {
		_RecallLookupHandler.overlayEscKeyHandle = _yui.on('key', _RecallLookupHandler.hide, document, 'down:27', _yui);
	},
	
	detachEscKey : function () {
		_RecallLookupHandler.overlayEscKeyHandle.detach();
	},
	
	show : function () {
		_RecallLookupHandler.overlayContainer.setStyle('display', 'block');
	    _RecallLookupHandler.overlay.set("centered", true);
	    _RecallLookupHandler.attachEscKey();
	},
	
	hide : function () {
		// Added as fix for agile task : 000011178   Dated: 21 Oct,2011  By: Aditi
		document.getElementById(_VFComponent.recallSection_comment).value = '';
		_RecallLookupHandler.overlayContainer.setStyle('display', 'none');
		_RecallLookupHandler.detachEscKey();
	}
}

var _CopyPrevWeekLookupHandler = {
	overlay : null,
	overlayContainer : null, 
	overlayEscKeyHandle : null,
	prepare : function () {
	    /* Create Overlay from script, this time. With no footer */
	    _CopyPrevWeekLookupHandler.overlay = new _yui.Overlay({
	        contentBox : "#copyPrevWeekOverlay", 
	        width : "100%",
	        zIndex:4
	    });
	    
	    /* Center overlay in viewport */
	    _CopyPrevWeekLookupHandler.overlay.set("centered", true);
	    
	    _CopyPrevWeekLookupHandler.overlay.render();
	    _CopyPrevWeekLookupHandler.overlay.show();
	    _CopyPrevWeekLookupHandler.overlayContainer = _yui.one('#copyPrevWeekContainer'); 
	},
	
    attachEscKey : function () 
    {
       _CopyPrevWeekLookupHandler.overlayEscKeyHandle = _yui.on('key', _CopyPrevWeekLookupHandler.hide, document, 'down:27', _yui);
    },
    
    detachEscKey : function ()
    {
       _CopyPrevWeekLookupHandler.overlayEscKeyHandle.detach();
    },
    
    show : function () {
    	toggleEditOverlayToPreventIE7Bug();
    	
    	_yui.one('#copyPrevWeekOverlay .overlayBody').setStyle('height', _yui.one('#copyPrevWeekOverlaySubContainer').getStyle('height'));
    	_yui.one('#copyPrevWeekOverlayErrorMsg').setStyle('display', 'none');
    	_yui.one('#copyPrevWeekOverlay').one('h1').set('text', _Label.copyFromPreviousWeek); 
    	   
	    _CopyPrevWeekLookupHandler.overlayContainer.setStyle('display', 'block');
	    _CopyPrevWeekLookupHandler.overlay.set("centered", true);
	    stablizeOverlay(_CopyPrevWeekLookupHandler.overlay);
	    _CopyPrevWeekLookupHandler.attachEscKey();
	    
    },
    
    hide : function() {
	    _CopyPrevWeekLookupHandler.overlayContainer.setStyle('display', 'none');
	    _CopyPrevWeekLookupHandler.detachEscKey();
	    toggleEditOverlayToPreventIE7Bug();
    },
    
    copy : function() {
    	
    	var allFlds = _yui.all('#copyPrevWeekOverlay input[type="checkbox"]');

		var anythingSelected = false;
		for (idx = 0 ; idx < allFlds.size(); idx++) {
		    if (allFlds.item(idx).get('checked')) {
		        anythingSelected = true;
		        break;
		    }
		}
		
		if (anythingSelected) {
			onCopyFromPreviousWeekOptionSelected()
		} else {
			_yui.one('#copyPrevWeekOverlayErrorMsg').setStyle('display', 'block');
		}
    }
}

var _EasyEntryNotesHandler = {
	overlay : null,
	overlayEscKeyHandle : null,
	overlayEnterKeyHandle : null,
	elementId : null,
	dayLabel : null,
	dayNumber : null,
	currentPopupDirty : false,
	setFocusOnCurrentElement : true,
	isRowNonEditable : false,
	allLabelsAndInputElements : null,
	
	prepare : function () {
	    _EasyEntryNotesHandler.overlay = new _yui.Overlay({
	        contentBox : "#easyEntryNotesOverlay", 
	        visible:false
	    });
	    
	    _EasyEntryNotesHandler.overlay.render();
	},
	
    attachEscKey : function () 
    {
       _yui.one(document.getElementById(elementId)).focus();
       _EasyEntryNotesHandler.overlayEscKeyHandle = _yui.on('key', _EasyEntryNotesHandler.hide, document, 'down:27', _yui);
    },
    
    detachEscKey : function ()
    {
       _EasyEntryNotesHandler.overlayEscKeyHandle.detach();
    },
    
    show : function (hrElementId, weekdayNumber, top, left, heading) {
    	toggleEditOverlayToPreventIE7Bug();
    	elementId = hrElementId ;
	    dayLabel = heading.substring(0, 3) ;
	    dayNumber = weekdayNumber ;
	    
	    _EasyEntryNotesHandler.overlay.show();
	    document.getElementById('easyEntryNotesOverlay').style.display = 'block' ;
	    document.getElementById('easyOverlayHeading').innerHTML = heading ;
	    
	    document.getElementById('sundayColumns').style.display = 'none' ;
    	document.getElementById('mondayColumns').style.display = 'none' ;
    	document.getElementById('tuesdayColumns').style.display = 'none' ;
    	document.getElementById('wednesdayColumns').style.display = 'none' ;
    	document.getElementById('thursdayColumns').style.display = 'none' ;
    	document.getElementById('fridayColumns').style.display = 'none' ;
    	document.getElementById('saturdayColumns').style.display = 'none' ;
	    
	    if(dayLabel == 'Sun') {
	    	document.getElementById('sundayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('sundayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Mon') {
	    	document.getElementById('mondayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('mondayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Tue') {
	    	document.getElementById('tuesdayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('tuesdayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Wed') {
	    	document.getElementById('wednesdayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('wednesdayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Thu') {
	    	document.getElementById('thursdayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('thursdayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Fri') {
	    	document.getElementById('fridayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('fridayColumns').getElementsByTagName("td");
	    } 
	    else if(dayLabel == 'Sat') {
	    	document.getElementById('saturdayColumns').style.display = 'block' ;
	    	allLabelsAndInputElements = document.getElementById('saturdayColumns').getElementsByTagName("td");
	    }
	    
	    var hiddenElementRowId = elementId.substring(0, elementId.lastIndexOf(':')+1);
	    _GlobalVariables.easyEntrySectionRowId = hiddenElementRowId ;
	    var hiddenInfoJSON ;
		
		if(dayNumber == 1) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay1AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 2) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay2AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 3) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay3AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 4) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay4AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 5) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay5AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 6) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay6AdditionalInformation').value ;
	    } 
	    else if(dayNumber == 7) {
	    	hiddenInfoJSON = document.getElementById(hiddenElementRowId + 'hiddenDay7AdditionalInformation').value ;
	    }
	    
	    var jsonObj ;
	    if(hiddenInfoJSON != '') 
	    	jsonObj = eval ("(" + hiddenInfoJSON + ")");
	    
	    _EasyEntryNotesHandler.overlay._setX(left);
	    _EasyEntryNotesHandler.overlay._setY(top+28);
	    stablizeOverlay(_EasyEntryNotesHandler.overlay);
	    _EasyEntryNotesHandler.attachEscKey();
	    
	    var hyperLinks = allLabelsAndInputElements[allLabelsAndInputElements.length - 1].getElementsByTagName('a');
	    
	    if(hyperLinks.length > 0)
	    	hyperLinks[0].onkeydown = function(e) { preventTabFunctionality(e)} ;
	    else 
	    	allLabelsAndInputElements[allLabelsAndInputElements.length - 1].firstChild.onkeydown = function(e) { preventTabFunctionality(e) } ;
	    
	    if(!_EasyEntryNotesHandler.isRowNonEditable) {
	    	_yui.all('.selectorClassForEasyEntryInput').set('disabled',false);
	    	document.getElementById('easyEntrySaveLink').style.display = '' ;
	    } else {
	    	_yui.all('.selectorClassForEasyEntryInput').set('disabled',true);
	    	document.getElementById('easyEntrySaveLink').style.display = 'none' ;
	    }
	    
	    if(allLabelsAndInputElements.length != 0) {
			
			// for loop to clean values from input and take values from saved vf page variable.
			var apiNameOfField ;
			var fieldTypeVal = '' ;
		  	for( var i=0; i<allLabelsAndInputElements.length; i++ )
		    {	
		    	if(allLabelsAndInputElements[i].id.indexOf('FieldName') != -1) {
		    		apiNameOfField = allLabelsAndInputElements[i].innerHTML ;
		    	}
		    	else if(allLabelsAndInputElements[i].id.indexOf('FieldType') != -1) {
					fieldTypeVal = allLabelsAndInputElements[i].firstChild.innerHTML.trim() ;
				}
				else if(allLabelsAndInputElements[i].id.indexOf('FieldVal') != -1) {
					
					if(fieldTypeVal.toLowerCase() == "picklist") {
						var select_list = allLabelsAndInputElements[i].firstChild;
						for(var k = 0; k < select_list.length; k++) {
							select_list.options[k].selected = false;
						}
					} 
					else if(fieldTypeVal.toLowerCase() == "boolean") {
						allLabelsAndInputElements[i].firstChild.checked = false ;
					}
					else if(fieldTypeVal.toLowerCase() == "manualpicklist") {
						var selectOpt = allLabelsAndInputElements[i].getElementsByTagName('select');
						if(selectOpt.length > 0) {
							var rowId = elementId.substring(0, elementId.lastIndexOf(':'));
							rowId = "tcRowID" + rowId.substring(rowId.lastIndexOf(':')+1 );
							
							_EasyEntryLocationHandler.copyTo(rowId, dayLabel, selectOpt[0] ,"");
						}
					} 
					else if(fieldTypeVal.toLowerCase() == "reference" || fieldTypeVal.toLowerCase() == "date" || fieldTypeVal.toLowerCase() == "datetime") {
						var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
						for(var k = 0; k < inputList.length; k++) {
							if(fieldTypeVal.toLowerCase() == "reference") {
								if(inputList[k].name.indexOf('_lkid') != -1) 
								{
									inputList[k].value = '' ;
								} 
								else if (inputList[k].name.indexOf('_lkold') != -1 ) {
									inputList[k].value = '' ;
								}
								else if (inputList[k].type != "hidden") {
									inputList[k].value = '' ;
									// removing this as disabling any input will not fire onchange event on it.
									//inputList[k].disabled = "disabled" ;
								}
							} 
							else {
								inputList[k].value = '' ;
							}
						}
						
						if(fieldTypeVal.toLowerCase() == "reference") {
							/* This specific handeling is done fro lookup of "User" type, where we have select list to select Customer portal, partner and normal user. 
							 * And salesforce binds a default on change event with this. So explicityly added that function here
							 */ 
							var selectOptn = allLabelsAndInputElements[i].getElementsByTagName('select') ;
							if(selectOptn.length > 0){
								
								var tempId = selectOptn[0].name ;
								if(tempId != '') {
									tempId = tempId.substring(0, tempId.lastIndexOf('_'));
									selectOptn[0].setAttribute( "onchange", "LookupAutoCompleteInputElement.handleLookupTypeChange('" + tempId + "',false);" );
								}
							}
							
							if(_EasyEntryNotesHandler.isRowNonEditable) {
								_yui.all(allLabelsAndInputElements[i].getElementsByTagName('select')).set('disabled',true);
								_yui.all(allLabelsAndInputElements[i].getElementsByTagName('a')).setStyle('display', 'none') ;
							} else {
								_yui.all(allLabelsAndInputElements[i].getElementsByTagName('select')).set('disabled',false);
								_yui.all(allLabelsAndInputElements[i].getElementsByTagName('a')).setStyle('display','');
							}
						}
					} 
					else {
						allLabelsAndInputElements[i].firstChild.value = '' ;
					}
					
					if(jsonObj != undefined) {
						for( var j=0; j < jsonObj.length; j++ ) {
							
							if( jsonObj[j].fieldAPIName == apiNameOfField) {
								
								if(jsonObj[j].fieldType.toLowerCase() == "picklist") {
									var select_list = allLabelsAndInputElements[i].firstChild;
									for(var k = 0; k < select_list.length; k++) {
										if(select_list.options[k].text == jsonObj[j].fieldValue) {
											select_list.options[k].selected = true;
										}
									}
								} 
								else if(jsonObj[j].fieldType.toLowerCase() == "manualpicklist") {
									var select_list = allLabelsAndInputElements[i].getElementsByTagName('select')[0];
									var rowId = elementId.substring(0, elementId.lastIndexOf(':'));
									rowId = "tcRowID" + rowId.substring(rowId.lastIndexOf(':')+1 );
									
									_EasyEntryLocationHandler.copyTo(rowId, dayLabel, select_list,jsonObj[j].fieldValue);
								}
								else if(jsonObj[j].fieldType.toLowerCase() == "boolean") {
									if(jsonObj[j].fieldValue == "true") {
										allLabelsAndInputElements[i].firstChild.checked = true ;
									} else if(jsonObj[j].fieldValue == "false") {
										allLabelsAndInputElements[i].firstChild.checked = false ;
									}
								} 
								else if(jsonObj[j].fieldType.toLowerCase() == "reference") {
									
									var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
									for(var k = 0; k < inputList.length; k++) {
										if(inputList[k].name.indexOf('_lkid') != -1) {
											inputList[k].value = jsonObj[j].fieldValue ;
										} 
										else if (inputList[k].name.indexOf('_lkold') != -1 ) {
											inputList[k].value = jsonObj[j].specialfieldValue ;
										}
										else if (inputList[k].type != "hidden") {
											inputList[k].value = jsonObj[j].specialfieldValue ;
										}
									}
								} 
								else if(jsonObj[j].fieldType.toLowerCase() == "date" || jsonObj[j].fieldType.toLowerCase() == "datetime") {
									var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
						
									if(inputList[0] != undefined) {						
										inputList[0].value = jsonObj[j].fieldValue ;
									}
								}
								else if (jsonObj[j].fieldType.toLowerCase() == 'string' || jsonObj[j].fieldType.toLowerCase() == 'textarea') {
									if(jsonObj[j].fieldValue != null && jsonObj[j].fieldValue != '') {
										try {
											allLabelsAndInputElements[i].firstChild.value = decodeURI(jsonObj[j].fieldValue) ;
											allLabelsAndInputElements[i].firstChild.innerHTML = decodeURI(jsonObj[j].fieldValue) ;
										} catch(err) {
											allLabelsAndInputElements[i].firstChild.value = decodeURI(encodeURI(jsonObj[j].fieldValue)) ;
											allLabelsAndInputElements[i].firstChild.innerHTML = decodeURI(encodeURI(jsonObj[j].fieldValue)) ;
										}
									} else {
										allLabelsAndInputElements[i].firstChild.value = jsonObj[j].fieldValue ;
										allLabelsAndInputElements[i].firstChild.innerHTML = jsonObj[j].fieldValue ;
									}
								}
								else {
									allLabelsAndInputElements[i].firstChild.value = jsonObj[j].fieldValue ;
									allLabelsAndInputElements[i].firstChild.innerHTML = jsonObj[j].fieldValue ;
								}
							}
						}
					}
				}
			}
			
			for( var i=0; i<allLabelsAndInputElements.length; i++ )
		    {	
				if(allLabelsAndInputElements[i].id.indexOf('FieldVal') != -1) {
					var input_child = allLabelsAndInputElements[i].firstChild;
					if(input_child.name != undefined)
						_yui.one(input_child).focus();
					else {
						var selectList = allLabelsAndInputElements[i].getElementsByTagName('select');
						selectList[0].focus();
					}
					break ;	
				}
			}
			
		}
		
		_EasyEntryNotesHandler.currentPopupDirty = true ;
	    
    },
    
    hide : function() {
    	if(_EasyEntryNotesHandler.setFocusOnCurrentElement)
    		_yui.one(document.getElementById(elementId)).focus();
    	else 
    		_EasyEntryNotesHandler.setFocusOnCurrentElement = true ;
    	
    	_EasyEntryNotesHandler.isRowNonEditable = false ;
    	_EasyEntryNotesHandler.currentPopupDirty = false ;
	    document.getElementById('easyEntryNotesOverlay').style.display = 'none' ;
	    _EasyEntryNotesHandler.detachEscKey();
	    toggleEditOverlayToPreventIE7Bug();
	    
    },
    
    copy : function() {
    	var JSONString = '' ;
    	var fieldTypeVal = '' ;
		if(allLabelsAndInputElements.length != 0) {
    		fieldTypeVal = '' ;
	    	for( var i=0; i<allLabelsAndInputElements.length; i++ )
		    {	
				if(allLabelsAndInputElements[i].id.indexOf('FieldName') != -1) {
					JSONString += '{ "fieldAPIName":"' + allLabelsAndInputElements[i].innerHTML + '" , ' ;
				}
				else if(allLabelsAndInputElements[i].id.indexOf('FieldType') != -1) {
					JSONString += '"fieldType":"' + allLabelsAndInputElements[i].firstChild.innerHTML.trim() + '" , ' ;
					fieldTypeVal = allLabelsAndInputElements[i].firstChild.innerHTML.trim() ;
				}
				else if(allLabelsAndInputElements[i].id.indexOf('FieldVal') != -1) {
					
					if (fieldTypeVal.toLowerCase() == "manualpicklist") {
					
						var selectOptn = allLabelsAndInputElements[i].getElementsByTagName('select') ;
						if(selectOptn.length > 0){
							JSONString += '"fieldValue":"'+ selectOptn[0].value ;
						}
					}
					else if(fieldTypeVal.toLowerCase() == "reference") 
					{
						var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
						for(var k = 0; k < inputList.length; k++) {
							if (inputList[k].name.indexOf('_lkid') != -1 ) {
								JSONString += '"fieldValue":"'+ inputList[k].value ;
							} 
							else if (inputList[k].type != "hidden") {
								JSONString += '", "specialfieldValue":"'+ inputList[k].value ;
							}
						}
					} 
					else if(fieldTypeVal.toLowerCase() == "date" || fieldTypeVal.toLowerCase() == "datetime") 
					{
						var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
						
						if(inputList[0] != undefined) {						
							JSONString += '"fieldValue":"'+ inputList[0].value ;
						} else {
							JSONString += '"fieldValue":"'+ allLabelsAndInputElements[i].firstChild.innerHTML ;
						}
						
					}
					else if(fieldTypeVal.toLowerCase() == "boolean")
					{
						JSONString += '"fieldValue":"'+ allLabelsAndInputElements[i].firstChild.checked ;
					} 
					else if (fieldTypeVal.toLowerCase() == 'string' || fieldTypeVal.toLowerCase() == 'textarea') 
					{
						JSONString += '"fieldValue":"'+ encodeURI(allLabelsAndInputElements[i].firstChild.value) ;
					}
					else
					{
						JSONString += '"fieldValue":"'+ allLabelsAndInputElements[i].firstChild.value ;
					}
					JSONString += '"},' ;
				}
			}
		}
		
		if(JSONString.length > 0) {
			JSONString = '[' + JSONString.substring(0, JSONString.length - 1 ) + ']' ;
		}
		
		var hiddenElementRowId = elementId.substring(0, elementId.lastIndexOf(':')+1);
		
		var hiddenInfoEle ;
		if(dayNumber == 1) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay1AdditionalInformation') ;
	    } 
	    else if(dayNumber == 2) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay2AdditionalInformation')
	    } 
	    else if(dayNumber == 3) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay3AdditionalInformation')
	    } 
	    else if(dayNumber == 4) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay4AdditionalInformation')
	    } 
	    else if(dayNumber == 5) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay5AdditionalInformation')
	    } 
	    else if(dayNumber == 6) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay6AdditionalInformation')
	    } 
	    else if(dayNumber == 7) {
	    	hiddenInfoEle = document.getElementById(hiddenElementRowId + 'hiddenDay7AdditionalInformation')
	    }
	    
	    if ( hiddenInfoEle != null ) { hiddenInfoEle.value = JSONString; }
	    
	    
	    // Now clear all the input fields
	    for( var i=0; i<allLabelsAndInputElements.length; i++ ) {	
			if(allLabelsAndInputElements[i].id.indexOf('FieldType') != -1) {
				fieldTypeVal = allLabelsAndInputElements[i].firstChild.innerHTML.trim() ;
			}
			else if(allLabelsAndInputElements[i].id.indexOf('FieldVal') != -1) {
					
				if(fieldTypeVal.toLowerCase() == "picklist") {
					var select_list = allLabelsAndInputElements[i].firstChild;
					for(var k = 0; k < select_list.length; k++) {
						select_list.options[k].selected = false;
					}
				} 
				else if(fieldTypeVal.toLowerCase() == "manualpicklist") {
					var selectOpt = allLabelsAndInputElements[i].getElementsByTagName('select');
					if(selectOpt.length > 0) {
						selectOpt[0].value = '';
						selectOpt[0].options.length = 0;
					}
				}
				else if(fieldTypeVal.toLowerCase() == "boolean") {
					allLabelsAndInputElements[i].firstChild.checked = false ;
				} 
				else if(fieldTypeVal.toLowerCase() == "reference" || fieldTypeVal.toLowerCase() == "date" || fieldTypeVal.toLowerCase() == "datetime") {
					var inputList = allLabelsAndInputElements[i].getElementsByTagName('input');
					for(var k = 0; k < inputList.length; k++) {
						if(fieldTypeVal.toLowerCase() == "reference") {
							if(inputList[k].name.indexOf('_lkid') != -1) 
							{
								inputList[k].value = '' ;
							} 
							else if (inputList[k].name.indexOf('_lkold') != -1 ) {
								inputList[k].value = '' ;
							}
							else if (inputList[k].type != "hidden") {
								inputList[k].value = '' ;
								// removing this as disabling any input will not fire onchange event on it.
								//inputList[k].disabled = "disabled" ;
							}
						} 
						else {
							inputList[k].value = '' ;
						}
					}
				} else {
					allLabelsAndInputElements[i].firstChild.value = '' ;
				}
			}
		}
		
		_EasyEntryNotesHandler.hide();
    }
}

var _StatusToHideLookupHandler = {
	overlay : null,
	overlayContainer : null, 
	overlayEscKeyHandle : null,
	prepare : function () {
	    /* Create Overlay from script, this time. With no footer */
	    _StatusToHideLookupHandler.overlay = new _yui.Overlay({
	        contentBox : "#statusToHideOverlay", 
	        width : "100%",
	        zIndex:4
	    });
	    
	    /* Center overlay in viewport */
	    _StatusToHideLookupHandler.overlay.set("centered", true);
	    
	    _StatusToHideLookupHandler.overlay.render();
	    _StatusToHideLookupHandler.overlay.show();
	    _StatusToHideLookupHandler.overlayContainer = _yui.one('#statusToHideContainer'); 
	},
	
    attachEscKey : function () 
    {
       _StatusToHideLookupHandler.overlayEscKeyHandle = _yui.on('key', _StatusToHideLookupHandler.hide, document, 'down:27', _yui);
    },
    
    detachEscKey : function ()
    {
       _StatusToHideLookupHandler.overlayEscKeyHandle.detach();
    },
    
    show : function () {
    	toggleEditOverlayToPreventIE7Bug();
    	
    	_yui.one('#statusToHideOverlay .overlayBody').setStyle('height', _yui.one('#statusToHideOverlaySubContainer').getStyle('height'));
    	//_yui.one('#copyPrevWeekOverlayErrorMsg').setStyle('display', 'none');
    	_yui.one('#statusToHideOverlay').one('h1').set('text', _Label.statusToHideWindowTitle);
    	   
	    _StatusToHideLookupHandler.overlayContainer.setStyle('display', 'block');
	    _StatusToHideLookupHandler.overlay.set("centered", true);
	    stablizeOverlay(_StatusToHideLookupHandler.overlay);
	    _StatusToHideLookupHandler.attachEscKey();
	    
    },
    
    hide : function() {
	    _StatusToHideLookupHandler.overlayContainer.setStyle('display', 'none');
	    _StatusToHideLookupHandler.detachEscKey();
	    toggleEditOverlayToPreventIE7Bug();
    },
    
    save : function() {
    	onStatusToHideSave();
    }
}
///////////////////////////////////////////////////////////////////////////
//---Following methods are extension/customization-----------------------//
//---of jsComponent.js's row highlighting and Notes section Script-------// 
///////////////////////////////////////////////////////////////////////////
_ResourceLookupHandler.onResourcesLoadExtension = function (resourceTags){
	if(_Config.defaultSingleResourceSearchResult && resourceTags != null && resourceTags.length == 1){
		var rid = resourceTags[0].getElementsByTagName('id')[0].firstChild.nodeValue;
        var rname = resourceTags[0].getElementsByTagName('name')[0].firstChild.nodeValue;
		doSelectResource(rid, escape(rname));
	}
}
var _RowsHandlerExtension = {
	onNotesImageClick : function (e,nHoveredRowId, rBaseId) {
		_NotesHandler.displayNotes(nHoveredRowId);
		
		var notesEle = document.getElementById(rBaseId + 'notesImage') ;
		if(notesEle != null) {
			_yui.detach("click", null, _yui.one(notesEle));
			// Below code changes done for agile task : AT20888 - it would implement 'notes image icon' of current row in editing to work as 'Done' button
			_yui.on("click",_NotesHandler.onOK, _yui.one(notesEle));
			_yui.one(notesEle).set('style.cursor', 'pointer');
		}
	}
}

_RowsHandler.onRenderingExtension =  function (currNode,currNodeIdx,allRows) {
	var forRowId = currNode.get('id');
	currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
	if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') == 'n') {
		markRowEnableORDisabled(currRowBaseId, 'disabled');
	} else {
	
		if(_CopyFromPreviousWeek){
			currNode.one('.fakeSelectorClassToDecideRowStatus').set('value','y');
		}
		
		// This logic should be executed if we have some project or assignment id selected.
		projectOrAssignmentId = _yui.one(document.getElementById(currRowBaseId + 'projectOrAssignmentId')).get('value');
		if (_Config.showMilestoneOnFrontPage) {
			var milestoneForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenMilestone')).get('value');
			
			var milestoneListPan;
	    	if(_Config.showMilestoneOnLeft) {
	    		milestoneListPan = _yui.one(document.getElementById(currRowBaseId + 'milestoneListLeftPanel'));
			} else {
				milestoneListPan = _yui.one(document.getElementById(currRowBaseId + 'milestoneListPanel'));
			}
			
			if(milestoneListPan != null){
				milestoneNode = milestoneListPan.get('children').item(1);
				milestoneSelectList = _yui.Node.getDOMNode(milestoneNode);
				_MilestonesHandler.copyTo(forRowId, milestoneSelectList, milestoneForThisRow);
			}
		}
		
		// added changes or agile task : AT1196
		if (_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord) {
			var methodologyForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectMethodology')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectMethodology')).get('value') : '';
			if(_Config.showMethodologyOnLeft) {
	    		methodologyListPanel = _yui.one(document.getElementById(currRowBaseId + 'methodologyListLeftPanel'));
			} else {
				methodologyListPanel = _yui.one(document.getElementById(currRowBaseId + 'methodologyListPanel'));
			}
			if(methodologyListPanel != null){
				methodologyNode = methodologyListPanel.get('children').item(1);
				methodologySelectList = _yui.Node.getDOMNode(methodologyNode);
				_MethodologyHandler.copyTo(forRowId, methodologySelectList, methodologyForThisRow);
			}
		}
		
		// added changes for agile task : AT1185
		if (_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord) {
			var phaseForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPhase')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPhase')).get('value') : '';
			if(_Config.showPhaseOnLeft) {
	    		phaseListPanel = _yui.one(document.getElementById(currRowBaseId + 'phaseListLeftPanel'));
			} else {
				phaseListPanel = _yui.one(document.getElementById(currRowBaseId + 'phaseListPanel'));
			}
			if(phaseListPanel != null){
				phaseNode = phaseListPanel.get('children').item(1);
				phaseSelectList = _yui.Node.getDOMNode(phaseNode);
				_PhaseHandler.copyTo(forRowId, phaseSelectList, phaseForThisRow);
			}
		}
		
		// added changes for AT5203
		if (_Config.showPrimaryLocationOnFrontPage && _Config.useProjectLocationRecord) {
			var primaryLocationForThisRow = _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPrimaryLocation')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPrimaryLocation')).get('value') : '';
			if(_Config.showPriLocationOnLeft) {
	    		primaryLocationListPanel = _yui.one(document.getElementById(currRowBaseId + 'primaryLocationListLeftPanel'));
			} else {
				primaryLocationListPanel = _yui.one(document.getElementById(currRowBaseId + 'primaryLocationListPanel'));
			}
			
			if(primaryLocationListPanel != null){
				primaryLocationNode = primaryLocationListPanel.get('children').item(1);
				primaryLocationSelectList = _yui.Node.getDOMNode(primaryLocationNode);
				_PrimaryLocationHandler.copyTo(forRowId, primaryLocationSelectList, primaryLocationForThisRow);
			}
		}
	}
}
_RowsHandler.isRowNew = function(newlyHoveredRowIndex){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	if(_yui.one(document.getElementById(rowBaseId + 'projOrAssig')).get('value') == 'n'){
		return false;
	}
	return true;
}
_RowsHandler.isRowHighlightable = function(newlyHoveredRowIndex){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	if(_yui.one(document.getElementById(rowBaseId + 'projOrAssig')).get('value') == 'n'){
		return false;
	}
	return true;
}
_RowsHandler.getLinkLabel = function(newlyHoveredRowIndex){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	isHrsAndNotesEditable = _yui.one(document.getElementById(rowBaseId  + 'isRowEditable')).get('value');
	return (isHrsAndNotesEditable == 'true') ? _Label.editDetails : _Label.viewDetails;
}
_RowsHandler.onMouseOverExtension =  function (newlyHoveredRowIndex) {
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	
	//Attach onclick event on the notes image. So that notes section can be open by clicking on notes image.
	var notesEle = document.getElementById(rowBaseId + 'notesImage') ;
	if(notesEle != null) {
		_yui.one(notesEle).set('style.cursor', 'pointer');
		_yui.detach("click", null, _yui.one(notesEle));
		_yui.on("click", _RowsHandlerExtension.onNotesImageClick, _yui.one(notesEle), {name: "context"}, newlyHoveredRowIndex, rowBaseId);
	}
}

// Extended onOk functionality to create toggle feature at notes Image - AT20888
_RowsHandler.onOkExtension =  function (onToggleRowIndex) {
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(onToggleRowIndex);
	
	//Attach onclick event on the notes image. So that notes section can be open by clicking on notes image.
	var notesEle = document.getElementById(rowBaseId + 'notesImage') ;
	if(notesEle != null) {
		_yui.one(notesEle).set('style.cursor', 'pointer');
		_yui.detach("click", null, _yui.one(notesEle));
		_yui.on("click", _RowsHandlerExtension.onNotesImageClick, _yui.one(notesEle), {name: "context"}, onToggleRowIndex, rowBaseId);
	}
}

function onAssignmentSelected(projectOrAssignmentID){
	loadAssignmentRelatedRecords(null, projectOrAssignmentID, true);
}
_NotesHandler.onNotesDetailOpenCompleteExtension = function(forRowId){
	loadAssignmentRelatedRecords(forRowId, null, false);
}
function loadAssignmentRelatedRecords(forRowId, projectOrAssignmentID, isAssignmentChanged){
	//If isAssignmentChanged true it means assignment/project has been selected/changed so we need to check if we have notes section open or any main UI's field which need to be updated
	//IF not mean user has activated notes section so we have to get data for the row.
	var forRowId = forRowId != null ? forRowId : _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "infoImage")).ancestor('tr').get('id');	            
	
	 if(isAssignmentChanged && _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'projectOrAssignmentId')).get('value') != projectOrAssignmentID){
	 	//This means we may have hidden data which need to be reset
	 	if(_Config.useProjectMethodologyRecord){
	 		// Update as a fix for agile task : AT13342		05-07-2013		shankar
	 		_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectMethodology')) != null ? _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectMethodology')).set('value', '') : false;
	 	}
	 	if(_Config.useProjectPhaseRecord){
	 		// Update as a fix for agile task : AT13342		05-07-2013		shankar
	 		_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectPhase')) != null ? _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectPhase')).set('value', '') : false;
	 	}
	 	if (_Config.noteLocationAllowed && _Config.useProjectLocationRecord) {
	 		
	 		// Update as a fix for agile task : AT13342		05-07-2013		shankar
			document.getElementById('tcPage:tcForm:hiddenSunProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSunProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenMonProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenMonProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenTueProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenTueProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenWedProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenWedProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenThuProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenThuProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenFriProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenFriProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenSatProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSatProjectLocation').value = '' : false;
		}
		// changes done for AT5203
		if (_Config.notePrimaryLocationAllowed && _Config.useProjectLocationRecord){
			// Update as a fix for agile task : AT13342		05-07-2013		shankar
			_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectPrimaryLocation')) != null ? _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'hiddenProjectPrimaryLocation')).set('value', '') : false;
		}
		
		if(_Config.showEasyEntryPopup) {
			var jsonObj, hiddenInfoJSON, newJSONString ;
			
			var hiddenJSONFieldsIds = ["hiddenDay1AdditionalInformation" , "hiddenDay2AdditionalInformation", "hiddenDay3AdditionalInformation", "hiddenDay4AdditionalInformation", "hiddenDay5AdditionalInformation", "hiddenDay6AdditionalInformation", "hiddenDay7AdditionalInformation"];
			
			for(i=0; i < hiddenJSONFieldsIds.length; i++) {
				hiddenInfoJSON = document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + hiddenJSONFieldsIds[i]) ;
				
				if(hiddenInfoJSON.value != '') 
		    		jsonObj = eval ("(" + hiddenInfoJSON.value + ")");
		    	
		   		if(jsonObj != undefined && jsonObj.length > 0) {
		   	
			   		newJSONString = '';
					for( var j=0; j < jsonObj.length; j++ ) {
						if(jsonObj[j].fieldType.toLowerCase() == "manualpicklist") {
							jsonObj[j].fieldValue = '' ;
							jsonObj[j].specialfieldValue = '';
						}
						else if(jsonObj[j].fieldType.toLowerCase() == "reference") {
							jsonObj[j].specialfieldValue = '';
							jsonObj[j].fieldValue = '' ;
						}
						
						newJSONString += '{"specialfieldValue":"' + (jsonObj[j].specialfieldValue != null ? jsonObj[j].specialfieldValue : '') + '","fieldValue": "' + (jsonObj[j].fieldValue != null ? jsonObj[j].fieldValue : '') + '","fieldType":"' + jsonObj[j].fieldType + '","fieldAPIName":"' + jsonObj[j].fieldAPIName + '"},' ;
					}
					
					if(newJSONString.length > 0) {
						newJSONString = '[' + newJSONString.substring(0, newJSONString.length - 1 ) + ']' ;
					}
					
					hiddenInfoJSON.value = newJSONString ;
				}
			}
		} // end of easyentry if
	 }
	
	if((isAssignmentChanged && _GlobalVariables.anyMainUIFieldNeedToBeUpdatedOnAssignmentChange) || (isAssignmentChanged && _NotesHandler.currentRowInEditing != null && _NotesHandler.currentRowInEditing == forRowId) || (!isAssignmentChanged && _GlobalVariables.anyDetailUIFieldNeedToBeUpdatedOnDetailSectionOpen) ){
		
		var weekendMS = document.getElementById('currentWeekendInMillis').value;
		var createBeanTimestampMS = document.getElementById('createBeanTimestampInMilliSec').value; 
		var tchID = _yui.one(document.getElementById('timecardIDHidden'+ forRowId)).get('value');
		
		//Check if notest section is open for the same row which trigger the call
		if(_NotesHandler.currentRowInEditing != null && _NotesHandler.currentRowInEditing == forRowId){
			_yui.all(".loadingProjectRelatedDetails").set('style.visibility', 'visible');
		}
		
		projectORAssignmentID = projectOrAssignmentID != null ? projectOrAssignmentID : _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'projectOrAssignmentId')).get('value');
		
		// to used only when easy entry is opt-in feature
		var allLocationVariable = new Array();
		allLocationVariable[0] = _Config.isSunProjectLocationAddedOnEE ;
		allLocationVariable[1] = _Config.isMonProjectLocationAddedOnEE ;
		allLocationVariable[2] = _Config.isTueProjectLocationAddedOnEE ;
		allLocationVariable[3] = _Config.isWedProjectLocationAddedOnEE ;
		allLocationVariable[4] = _Config.isThuProjectLocationAddedOnEE ;
		allLocationVariable[5] = _Config.isFriProjectLocationAddedOnEE ;
		allLocationVariable[6] = _Config.isSatProjectLocationAddedOnEE ;
		
		// Fix for bug : B-2268 Dated : 01 June, 2012
		// From salesforce summer 12 release onwards we need not to handle the namespace for remote action call  
		if(_Config.namespacePrefix.length == 0){
			TCController.getAssignmentDetailsWithRelatedObjects( projectORAssignmentID, weekendMS, createBeanTimestampMS, tchID, forRowId, isAssignmentChanged, _Config.projectLocationAddedOnEasyEntry, allLocationVariable, function(result, event){
											        if (event.status) {
											            onAssignmentRelatedRecordsLoads(result);
											        } else if (event.type === 'exception') {    
											             alert(event.message);
											        } else {
											           alert(event.message);
											        }
											    }, {escape:true});
		}else{
			// Done some changes as fix for agile task : AT1747  Dated : 23 May, 2012 
			window[_Config.namespacePrefix].TCController.getAssignmentDetailsWithRelatedObjects( projectORAssignmentID, weekendMS, createBeanTimestampMS, tchID, forRowId, isAssignmentChanged, _Config.projectLocationAddedOnEasyEntry, allLocationVariable, function(result, event){
											        if (event.status) {
											            onAssignmentRelatedRecordsLoads(result);
											        } else if (event.type === 'exception') {    
											             alert(event.message);
											        } else {
											           alert(event.message);
											        }
											    }, {escape:true});
    	}
		
	}
}


function onAssignmentRelatedRecordsLoads(result){
	var needToUpdate = false;
	var projectORAssignmentID = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'projectOrAssignmentId')).get('value');
	if(projectORAssignmentID == result.projectORAssignmentID){
		_yui.all(".loadingProjectRelatedDetails").set('style.visibility', 'hidden');
		//This mean call is valid and need to be update data at some place
		if(_NotesHandler.currentRowInEditing != null && _NotesHandler.currentRowInEditing == result.forRowId && _GlobalVariables.anyDetailUIFieldNeedToBeUpdatedOnDetailSectionOpen){
			//This mean notes section is open for same row so update the detail section as well
			// changes done for AT5203
			if(_Config.useProjectLocationRecord && (_Config.showPrimaryLocationOnPopup || _Config.noteLocationAllowed ) ){
				prepareProjectLocationSelectOptions(result);
			}
			if(_Config.showMethodologyOnPopup && _Config.useProjectMethodologyRecord){
				prepareProjectMethodologySelectOptions(result);
			}
			if(_Config.showPhaseOnPopup && _Config.useProjectPhaseRecord){
				prepareProjectPhaseSelectOptions(result);
			}
		}
		
		var isHrsAndNotesEditable = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'isRowEditable')).get('value') == 'true' ;
		
		if(result.isAssignmentChanged && _GlobalVariables.anyMainUIFieldNeedToBeUpdatedOnAssignmentChange && isHrsAndNotesEditable){
			_yui.all(".loadingProjectRelatedDetails").set('style.visibility', 'hidden');
			//This means main ui have some elments that need to be updated.
			
			if(_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord){
				prepareProjectMethodologySelectOptions(result);
			}
			
			if(_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord){
				prepareProjectPhaseSelectOptions(result);
			}
			
			// added for AT5203
			if(_Config.showPrimaryLocationOnFrontPage && _Config.useProjectLocationRecord) {
				prepareProjectPrimaryLocationSelectOptions(result);
			}
			
			// added for supporting easy entry location dropdown
			if(_Config.showEasyEntryPopup && _Config.projectLocationAddedOnEasyEntry) {
				prepareEasyEntryLocationOptions(result);
			}
		}
	}
}

// added to populate easyentry Project location select options
function prepareEasyEntryLocationOptions(result) {
	resetEasyEntryProjectLocation();
	
	var sundaySelect = document.getElementById('sunLocEasyEntrySelect') ;
	var mondaySelect = document.getElementById('monLocEasyEntrySelect') ;
	var tuesdaySelect = document.getElementById('tueLocEasyEntrySelect') ;
	var wednesdaySelect = document.getElementById('wedLocEasyEntrySelect') ;
	var thursdaySelect = document.getElementById('thuLocEasyEntrySelect') ;
	var fridaySelect = document.getElementById('friLocEasyEntrySelect') ;
	var saturdaySelect = document.getElementById('satLocEasyEntrySelect') ;
	
	var projectLocationOptions = new Array();
	projectLocationOptions.push(new Option('', ''));
	for(var i = 0; i< result.locationOptions.length; i++){
		var locationName = window.unescapeXML ? unescapeXML(result.locationOptions[i].Name) : result.locationOptions[i].Name;
		projectLocationOptions.push(new Option(locationName,result.locationOptions[i].Id));
	}
	
	if(sundaySelect != null) {
		var projectLocationSunOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       sundaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSunLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenSunLocEasyEntry')).get('value')){
	            sundaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalSunLocOption != null ) {
			sundaySelect.options[idx] = new Option(result.additionalSunLocOption.Name, result.additionalSunLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSunLocEasyEntry')) != null && result.additionalSunLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenSunLocEasyEntry')).get('value')){
	        	sundaySelect.options[idx].selected = true;
	        }
	        projectLocationSunOptions.push(new Option(result.additionalSunLocOption.Name, result.additionalSunLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Sun', projectLocationSunOptions);
	}
	
	if(mondaySelect != null) {
		var projectLocationMonOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       mondaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenMonLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenMonLocEasyEntry')).get('value')){
	            mondaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalMonLocOption != null ) {
			mondaySelect.options[idx] = new Option(result.additionalMonLocOption.Name, result.additionalMonLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenMonLocEasyEntry')) != null && result.additionalMonLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenMonLocEasyEntry')).get('value')){
	        	mondaySelect.options[idx].selected = true;
	        }
	        projectLocationMonOptions.push(new Option(result.additionalMonLocOption.Name, result.additionalMonLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Mon', projectLocationMonOptions);
	}
	
	if(tuesdaySelect != null) {
		var projectLocationTueOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       tuesdaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenTueLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenTueLocEasyEntry')).get('value')){
	            tuesdaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalTueLocOption != null ) {
			tuesdaySelect.options[idx] = new Option(result.additionalTueLocOption.Name, result.additionalTueLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenTueLocEasyEntry')) != null && result.additionalTueLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenTueLocEasyEntry')).get('value')){
	        	tuesdaySelect.options[idx].selected = true;
	        }
	        projectLocationTueOptions.push(new Option(result.additionalTueLocOption.Name, result.additionalTueLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Tue', projectLocationTueOptions);
	}
	
	if(wednesdaySelect != null) {
		var projectLocationWedOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       wednesdaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenWedLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenWedLocEasyEntry')).get('value')){
	            wednesdaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalWedLocOption != null ) {
			wednesdaySelect.options[idx] = new Option(result.additionalWedLocOption.Name, result.additionalWedLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenWedLocEasyEntry')) != null && result.additionalWedLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenWedLocEasyEntry')).get('value')){
	        	wednesdaySelect.options[idx].selected = true;
	        }
	        projectLocationWedOptions.push(new Option(result.additionalWedLocOption.Name, result.additionalWedLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Wed', projectLocationWedOptions);
	}
	
	if(thursdaySelect != null) {
		var projectLocationThuOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       thursdaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenThuLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenThuLocEasyEntry')).get('value')){
	            thursdaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalThuLocOption != null ) {
			thursdaySelect.options[idx] = new Option(result.additionalThuLocOption.Name, result.additionalThuLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenThuLocEasyEntry')) != null && result.additionalThuLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenThuLocEasyEntry')).get('value')){
	        	thursdaySelect.options[idx].selected = true;
	        }
	        projectLocationThuOptions.push(new Option(result.additionalThuLocOption.Name, result.additionalThuLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Thu', projectLocationThuOptions);
	}
	
	if(fridaySelect != null) {
		var projectLocationFriOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       fridaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenFriLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenFriLocEasyEntry')).get('value')){
	            fridaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalFriLocOption != null ) {
			fridaySelect.options[idx] = new Option(result.additionalFriLocOption.Name, result.additionalFriLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenFriLocEasyEntry')) != null && result.additionalFriLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenFriLocEasyEntry')).get('value')){
	        	fridaySelect.options[idx].selected = true;
	        }
	        projectLocationFriOptions.push(new Option(result.additionalFriLocOption.Name, result.additionalFriLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Fri', projectLocationFriOptions);
	}
	
	if(saturdaySelect != null) {
		var projectLocationSatOptions = projectLocationOptions;
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       saturdaySelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSatLocEasyEntry')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenSatLocEasyEntry')).get('value')){
	            saturdaySelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalSatLocOption != null ) {
			saturdaySelect.options[idx] = new Option(result.additionalSatLocOption.Name, result.additionalSatLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSatLocEasyEntry')) != null && result.additionalSatLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenSatLocEasyEntry')).get('value')){
	        	saturdaySelect.options[idx].selected = true;
	        }
	        projectLocationSatOptions.push(new Option(result.additionalSatLocOption.Name, result.additionalSatLocOption.Id));
	    }
	    
	    _EasyEntryLocationHandler.toCache(result.forRowId, 'Sat', projectLocationSatOptions);
	}
	
}

// added function for agile task : AT1148
function prepareProjectLocationSelectOptions(result){
	resetProjectLocations(false);
	if(result.locationOptions == null){//This will never happen
		return;
	}
	var projectLocationOptions = new Array();
	projectLocationOptions.push(new Option('', ''));
	for(var i = 0; i< result.locationOptions.length; i++){
		var locationName = window.unescapeXML ? unescapeXML(result.locationOptions[i].Name) : result.locationOptions[i].Name;
		projectLocationOptions.push(new Option(locationName,result.locationOptions[i].Id));
	}	

	// Update as a fix for agile task : AT13342		05-07-2013		shankar
	if (_Config.noteLocationAllowed && _Config.useProjectLocationRecord) {
		
		/*Copy options to sunday location options*/
		var projectSunLocationSelect = document.getElementById('projectSunLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectSunLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSunProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenSunProjectLocation')).get('value')){
	            projectSunLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalSunLocOption != null ) {
			projectSunLocationSelect.options[idx] = new Option(result.additionalSunLocOption.Name, result.additionalSunLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSunProjectLocation')) != null && result.additionalSunLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenSunProjectLocation')).get('value')){
	        	projectSunLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	    
	    /*Copy options to Monday location options*/
	    var projectMonLocationSelect = document.getElementById('projectMonLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectMonLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenMonProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenMonProjectLocation')).get('value')){
	            projectMonLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalMonLocOption != null ) {
			projectMonLocationSelect.options[idx] = new Option(result.additionalMonLocOption.Name, result.additionalMonLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenMonProjectLocation')) != null && result.additionalMonLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenMonProjectLocation')).get('value')){
	        	projectMonLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	    /*Copy options to Tuesday location options*/
		var projectTueLocationSelect = document.getElementById('projectTueLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
		   projectTueLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
		   if(_yui.one(document.getElementById('tcPage:tcForm:hiddenTueProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenTueProjectLocation')).get('value')){
				projectTueLocationSelect.options[idx].selected = true;
		   }
		}
		if (result.additionalTueLocOption != null ) {
			projectTueLocationSelect.options[idx] = new Option(result.additionalTueLocOption.Name, result.additionalTueLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenTueProjectLocation')) != null && result.additionalTueLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenTueProjectLocation')).get('value')){
	        	projectTueLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	    /*Copy options to Wednesday location options*/
	    var projectWedLocationSelect = document.getElementById('projectWedLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectWedLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenWedProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenWedProjectLocation')).get('value')){
	            projectWedLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalWedLocOption != null ) {
			projectWedLocationSelect.options[idx] = new Option(result.additionalWedLocOption.Name, result.additionalWedLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenWedProjectLocation')) != null && result.additionalWedLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenWedProjectLocation')).get('value')){
	        	projectWedLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	    /*Copy options to Thursday location options*/
	    var projectThuLocationSelect = document.getElementById('projectThuLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectThuLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenThuProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenThuProjectLocation')).get('value')){
	            projectThuLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalThuLocOption != null ) {
			projectThuLocationSelect.options[idx] = new Option(result.additionalThuLocOption.Name, result.additionalThuLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenThuProjectLocation')) != null && result.additionalThuLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenThuProjectLocation')).get('value')){
	        	projectThuLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	    /*Copy options to Friday location options*/
	    var projectFriLocationSelect = document.getElementById('projectFriLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectFriLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenFriProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenFriProjectLocation')).get('value')){
	            projectFriLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalFriLocOption != null ) {
			projectFriLocationSelect.options[idx] = new Option(result.additionalFriLocOption.Name, result.additionalFriLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenFriProjectLocation')) != null && result.additionalFriLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenFriProjectLocation')).get('value')){
	        	projectFriLocationSelect.options[idx].selected = true;
	        }
	    }
	    
	   /*Copy options to Saturday location options*/
	    var projectSatLocationSelect = document.getElementById('projectSatLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectSatLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSatProjectLocation')) != null && projectLocationOptions[idx].value == _yui.one(document.getElementById('tcPage:tcForm:hiddenSatProjectLocation')).get('value')){
	            projectSatLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalSatLocOption != null ) {
			projectSatLocationSelect.options[idx] = new Option(result.additionalSatLocOption.Name, result.additionalSatLocOption.Id);
	        if(_yui.one(document.getElementById('tcPage:tcForm:hiddenSatProjectLocation')) != null && result.additionalSatLocOption.Id == _yui.one(document.getElementById('tcPage:tcForm:hiddenSatProjectLocation')).get('value')){
	        	projectSatLocationSelect.options[idx].selected = true;
	        }
	    }
    }
    /*Copy options to Primary location options*/
    if (_Config.showPrimaryLocationOnPopup && _Config.useProjectLocationRecord) {
    	
    	// Update as a fix for agile task : AT13342		05-07-2013		shankar
    	var hiddenProjectPrimaryLocationElement = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'hiddenProjectPrimaryLocation'));
    	
	    var projectPriLocationSelect = document.getElementById('projectPriLocationSelect');
		for(idx = 0 ; idx < projectLocationOptions.length ; idx++){
	       projectPriLocationSelect.options[idx] = new Option(projectLocationOptions[idx].text, projectLocationOptions[idx].value);
	       if(hiddenProjectPrimaryLocationElement != null && projectLocationOptions[idx].value == hiddenProjectPrimaryLocationElement.get('value')){
	            projectPriLocationSelect.options[idx].selected = true;
	       }
	    }
	    if (result.additionalPriLocOption != null ) {
			projectPriLocationSelect.options[idx] = new Option(result.additionalPriLocOption.Name, result.additionalPriLocOption.Id);
	        if(hiddenProjectPrimaryLocationElement != null && result.additionalPriLocOption.Id == hiddenProjectPrimaryLocationElement.get('value')){
	        	projectPriLocationSelect.options[idx].selected = true;
	        }
	    }
	}
}

// added function for easy entry location dropdown
function resetEasyEntryProjectLocation(){
	
	var sundaySelect = document.getElementById('sunLocEasyEntrySelect') ;
	var mondaySelect = document.getElementById('monLocEasyEntrySelect') ;
	var tuesdaySelect = document.getElementById('tueLocEasyEntrySelect') ;
	var wednesdaySelect = document.getElementById('wedLocEasyEntrySelect') ;
	var thursdaySelect = document.getElementById('thuLocEasyEntrySelect') ;
	var fridaySelect = document.getElementById('friLocEasyEntrySelect') ;
	var saturdaySelect = document.getElementById('satLocEasyEntrySelect') ;
	
	if(sundaySelect != null) {
		sundaySelect.value = '';
		sundaySelect.options.length = 0;
	}
	if(mondaySelect != null) {
		mondaySelect.value = '';
		mondaySelect.options.length = 0;
	}
	if(tuesdaySelect != null) {
		tuesdaySelect.value = '';
		tuesdaySelect.options.length = 0;
	}
	if(wednesdaySelect != null) {
		wednesdaySelect.value = '';
		wednesdaySelect.options.length = 0;
	}
	if(thursdaySelect != null) {
		thursdaySelect.value = '';
		thursdaySelect.options.length = 0;
	}
	if(fridaySelect != null) {
		fridaySelect.value = '';
		fridaySelect.options.length = 0;
	}
	if(saturdaySelect != null) {
		saturdaySelect.value = '';
		saturdaySelect.options.length = 0;
	}
}

// added function for agile task : AT1148
function resetProjectLocations(clearHiddenValues){
	
	if (_Config.noteLocationAllowed && _Config.useProjectLocationRecord) {
		document.getElementById('projectSunLocationSelect').value = '';
		document.getElementById('projectSunLocationSelect').options.length = 0;
		document.getElementById('projectMonLocationSelect').value = '';
		document.getElementById('projectMonLocationSelect').options.length = 0;
		document.getElementById('projectTueLocationSelect').value = '';
		document.getElementById('projectTueLocationSelect').options.length = 0;
		document.getElementById('projectWedLocationSelect').value = '';
		document.getElementById('projectWedLocationSelect').options.length = 0;
		document.getElementById('projectThuLocationSelect').value = '';
		document.getElementById('projectThuLocationSelect').options.length = 0;
		document.getElementById('projectFriLocationSelect').value = '';
		document.getElementById('projectFriLocationSelect').options.length = 0;
		document.getElementById('projectSatLocationSelect').value = '';
		document.getElementById('projectSatLocationSelect').options.length = 0;
		
		if(clearHiddenValues){
			// Update as a fix for agile task : AT13342		05-07-2013		shankar
			document.getElementById('tcPage:tcForm:hiddenSunProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSunProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenMonProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenMonProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenTueProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenTueProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenWedProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenWedProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenThuProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenThuProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenFriProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenFriProjectLocation').value = '' : false;
			document.getElementById('tcPage:tcForm:hiddenSatProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSatProjectLocation').value = '' : false;
		}
	}
	
	// changes done for AT5203
	if (_Config.showPrimaryLocationOnPopup && _Config.useProjectLocationRecord) {
		document.getElementById('projectPriLocationSelect').value = '';
		document.getElementById('projectPriLocationSelect').options.length = 0;
		// commenting for AT5203
		/*
		if(clearHiddenValues){
			document.getElementById('tcPage:tcForm:hiddenPriProjectLocation').value = '';
			
		}*/
	}
}


// added function for agile task : AT5203
function prepareProjectPrimaryLocationSelectOptions(result){
	resetProjectPrimaryLocation();
	
	var projectPrimaryLocationOptions = new Array();
	projectPrimaryLocationOptions.push(new Option('', ''));
	
	if(result.locationOptions != 'undefined' && result.locationOptions != null){
		for(var i = 0; i< result.locationOptions.length; i++){
			var primaryLocationName = window.unescapeXML ? unescapeXML(result.locationOptions[i].Name) : result.locationOptions[i].Name;  
			projectPrimaryLocationOptions.push(new Option(primaryLocationName, result.locationOptions[i].Id));
		}	
	}
	
	var projectPrimaryLocationSelect = _Config.showPriLocationOnLeft ?_yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'primaryLocationListLeftPanel')).get('children').item(1)) :
										_yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'primaryLocationListPanel')).get('children').item(1)) ;
	
	// Update as a fix for agile task : AT13342		05-07-2013		shankar
	var hiddenProjectPrimaryLocationElement = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'hiddenProjectPrimaryLocation'));
	
	for(idx = 0 ; idx < projectPrimaryLocationOptions.length ; idx++){
       projectPrimaryLocationSelect.options[idx] = new Option(projectPrimaryLocationOptions[idx].text, projectPrimaryLocationOptions[idx].value);
       if(hiddenProjectPrimaryLocationElement != null && projectPrimaryLocationOptions[idx].value == hiddenProjectPrimaryLocationElement.get('value')){
            projectPrimaryLocationSelect.options[idx].selected = true;
       }
    }
    if (result.additionalPriLocOption != null ) {
		projectPrimaryLocationSelect.options[idx] = new Option(result.additionalPriLocOption.Name, result.additionalPriLocOption.Id);
        if(hiddenProjectPrimaryLocationElement != null && result.additionalPriLocOption.Id == hiddenProjectPrimaryLocationElement.get('value')){
        	projectPrimaryLocationSelect.options[idx].selected = true;
        }
	}

    if(_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord){
    	_PrimaryLocationHandler.toCache(result.forRowId, projectPrimaryLocationOptions);
    }		
}

// added function for agile task : AT5203
function resetProjectPrimaryLocation() {

	if (_Config.showPrimaryLocationOnFrontPage && _Config.useProjectLocationRecord) {
		if(_Config.showPriLocationOnLeft) {
    		_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'primaryLocationListLeftPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'primaryLocationListLeftPanel')).get('children').item(1)).options.length = 0;
		} else {
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'primaryLocationListPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'primaryLocationListPanel')).get('children').item(1)).options.length = 0;
		}
	}
}


// added function for agile task : AT1185
function prepareProjectPhaseSelectOptions(result){
	resetProjectPhases();
	
	var projectPhaseOptions = new Array();
	projectPhaseOptions.push(new Option('', ''));
	
	if(result.phaseOptions != 'undefined' && result.phaseOptions != null){
		for(var i = 0; i< result.phaseOptions.length; i++){
			var phaseName = window.unescapeXML ? unescapeXML(result.phaseOptions[i].Name) : result.phaseOptions[i].Name;  
			projectPhaseOptions.push(new Option(phaseName, result.phaseOptions[i].Id));
		}	
	}	
	var projectPhaseSelect = _Config.showPhaseOnPopup ? document.getElementById('projectPhaseSelect') :
							_Config.showPhaseOnLeft ? _yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'phaseListLeftPanel')).get('children').item(1)) :
							 _yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'phaseListPanel')).get('children').item(1)) ;
	
	for(idx = 0 ; idx < projectPhaseOptions.length ; idx++){
       projectPhaseSelect.options[idx] = new Option(projectPhaseOptions[idx].text, projectPhaseOptions[idx].value);
       
       // Update as a fix for agile task : AT13342		05-07-2013		shankar
       var hiddenProjectPhaseElement = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'hiddenProjectPhase'));
       if(hiddenProjectPhaseElement != null && projectPhaseOptions[idx].value == hiddenProjectPhaseElement.get('value')){
            projectPhaseSelect.options[idx].selected = true;
       }
    }

    if(_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord){
    	_PhaseHandler.toCache(result.forRowId, projectPhaseOptions);
    }		
}

// added function for agile task : AT1185
function resetProjectPhases() {

	if (_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord) {
		if(_Config.showPhaseOnLeft) {
    		_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'phaseListLeftPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'phaseListLeftPanel')).get('children').item(1)).options.length = 0;
		} else {
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'phaseListPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'phaseListPanel')).get('children').item(1)).options.length = 0;
		}
		
	}
	
	if (_Config.showPhaseOnPopup && _Config.useProjectPhaseRecord) {
		document.getElementById('projectPhaseSelect').value = '';
		document.getElementById('projectPhaseSelect').options.length = 0;
	}
}

// added function for agile task : AT1196
function prepareProjectMethodologySelectOptions(result){
	resetProjectMethodologies();
	
	var projectMethodologyOptions = new Array();
	projectMethodologyOptions.push(new Option('', ''));
	
	if(result.methodologyOptions != null && result.methodologyOptions != 'undefined') {	
		for(var i = 0; i< result.methodologyOptions.length; i++){
			var methodologyName = window.unescapeXML ? unescapeXML(result.methodologyOptions[i].Name) : result.methodologyOptions[i].Name;
			projectMethodologyOptions.push(new Option(methodologyName, result.methodologyOptions[i].Id));
		}	
	}
	var projectMethodologySelect = _Config.showMethodologyOnPopup ? document.getElementById('projectMethodologySelect') : 
								_Config.showMethodologyOnLeft ? _yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'methodologyListLeftPanel')).get('children').item(1)) :
								_yui.Node.getDOMNode(_yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'methodologyListPanel')).get('children').item(1)) ;
			
	for(idx = 0 ; idx < projectMethodologyOptions.length ; idx++){
       projectMethodologySelect.options[idx] = new Option(projectMethodologyOptions[idx].text, projectMethodologyOptions[idx].value);
       
       // Update as a fix for agile task : AT13342		05-07-2013		shankar
       var hiddenProjectMethodologyElement = _yui.one(document.getElementById(toRowBaseIdFromRowIndexUnEscaped(result.forRowId) + 'hiddenProjectMethodology'));
       if(hiddenProjectMethodologyElement != null && projectMethodologyOptions[idx].value == hiddenProjectMethodologyElement.get('value')){
            projectMethodologySelect.options[idx].selected = true;
       }
    }
    
  	if(_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord){
    	_MethodologyHandler.toCache(result.forRowId, projectMethodologyOptions);
    }		
}

// added function for agile task : AT1196
function resetProjectMethodologies() {
	if (_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord) {
		if(_Config.showMethodologyOnLeft) {
    		_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'methodologyListLeftPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'methodologyListLeftPanel')).get('children').item(1)).options.length = 0;
		} else {
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'methodologyListPanel')).get('children').item(1)).value = '';
			_yui.Node.getDOMNode(_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + 'methodologyListPanel')).get('children').item(1)).options.length = 0;
		}
		
	}
	
	if (_Config.showMethodologyOnPopup && _Config.useProjectMethodologyRecord) {
		document.getElementById('projectMethodologySelect').value = '';
		document.getElementById('projectMethodologySelect').options.length = 0;
	}
}


_NotesHandler.displayNotesExtension = function(forRowId){

	var notesEle = document.getElementById(toRowBaseIdFromRowIndexUnEscaped(forRowId) + 'notesImage') ;
	if(notesEle != null) {
	//it would implement Toggle feature on 'notes image icon' of current row (To work as 'Done' button for open notes detail section)
		_yui.detach("click", null, _yui.one(notesEle));
		_yui.on("click",_NotesHandler.onOK, _yui.one(notesEle));
		_yui.one(notesEle).set('style.cursor', 'pointer');
	}
}

_NotesHandler.setRowNumberToRetriveDataFromServer = function (forRowId) {
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	rowNumber = rowBaseIdFromRowIndexUnEscaped.slice(0,rowBaseIdFromRowIndexUnEscaped.lastIndexOf(":"));
	rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1);
	document.getElementById(_VFComponent.notesSection_selectedTCLineID).value = rowNumber;
}
_NotesHandler.setRowNumberToSaveDataToTheServer = function (forRowId) {
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	rowNumber = rowBaseIdFromRowIndexUnEscaped.slice(0,rowBaseIdFromRowIndexUnEscaped.lastIndexOf(":"));
	rowNumber = rowNumber.slice(rowNumber.lastIndexOf(":")+1);
	document.getElementById(_VFComponent.notesSection_selectedLineToSaveNoteDataID).value = rowNumber;
}

_NotesHandler.copyRowToNotes = function (forRowId){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	//_NotesHandler.copyRowToNotes(rowBaseId);
	prepareNotesDialogData(rowBaseId);
}
_NotesHandler.copyNotesToRow = function (forRowId) {
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(forRowId);
	saveNotesDialogData(rowBaseId);
}
_NotesHandler.resetNotesRowdata = function () {
	_yui.all('.fakeSelectorClassForNotesInput').set('value','');
	_yui.all('.fakeSelectorClassForNotesInputCheckBox').set('checked',false);
	
	// changes done for AT5203
	if ( _Config.useProjectLocationRecord && (_Config.showPrimaryLocationOnPopup || _Config.noteLocationAllowed)) {
		resetProjectLocations(true);
	}

	// added code for agile task : AT1196
	if (_Config.showMethodologyOnPopup && _Config.useProjectMethodologyRecord) {
		resetProjectMethodologies();
	}
	
	// added code for agile task : AT1185
	if (_Config.showPhaseOnPopup && _Config.useProjectPhaseRecord) {
		resetProjectPhases();
	}
	
}
/*@TODO: push milestones or any assig dependent details when notes popup is already open and user select another assig
one idea is :- we can call close notes function and when user will reopen it will automatically updated*/
function prepareNotesDialogData(selectedRowBaseID ){
	//Check if current row is editable or not
	var bool_isRowEditable = document.getElementById(selectedRowBaseID + "isRowEditable").value == "true" ? true : false;
	//IF row is not editable then disable all editable fields or vice-versa on notes popup
	
	//Added as a fix for Agile Task : AT14223
	if(!bool_isRowEditable) {
		if(document.getElementById(_notesPopupIds.projectPrimaryLocationId) != null){
			document.getElementById(_notesPopupIds.projectPrimaryLocationId).disabled = true;	
		}
		if(document.getElementById(_notesPopupIds.projectPhaseId) != null){
			document.getElementById(_notesPopupIds.projectPhaseId).disabled = true; 
		}
		if(document.getElementById(_notesPopupIds.projectMethodologyId) != null){
			document.getElementById(_notesPopupIds.projectMethodologyId).disabled = true; 
		}
		_yui.all('.myNotesRequired').set('style.display','none');
	}
	
	_yui.all('.fakeSelectorClassForNotesInput').set('disabled',!bool_isRowEditable);
	_yui.all('.fakeSelectorClassForNotesInputCheckBox').set('disabled',!bool_isRowEditable);
	
	var tcRowId = _yui.one(document.getElementById(selectedRowBaseID + "infoImage")).ancestor('tr').get('id');
	//Check if Milestones options are renedred or not
	if (_Config.showMilestoneOnPopup) {
	    isCurrentRowMSClosed = document.getElementById(selectedRowBaseID + "hiddenIsMSClosed").value == "true" ? true : false;
	    if(!bool_isRowEditable && isCurrentRowMSClosed){
	    	msName = document.getElementById(selectedRowBaseID + "hiddenMilestoneName").value;
			_yui.Node.getDOMNode(_yui.one('#milestoneSelect')).options[0] = new Option(msName,'',''); 		 	    	
	    }else{
	    	var assigMilestone = document.getElementById(selectedRowBaseID + "hiddenMilestone").value;
			_MilestonesHandler.copyTo(tcRowId, _yui.Node.getDOMNode(_yui.one('#milestoneSelect')), assigMilestone);
		    /*@todo .. chk if can be removed*/
		    if(isStringNotEmpty(assigMilestone))
		    	document.getElementById('milestoneSelect').value = assigMilestone;
		}   
	}
	
}

/*update the hidden form fields with the values entered in the notes dialog box fields*/
function saveNotesDialogData(selectedRowBaseID) {
    /* don't update approved or submitted timecards. Check if current row is editable or not*/
    var bool_isRowEditable = document.getElementById(selectedRowBaseID + "isRowEditable").value == "true" ? true : false;
    if (!bool_isRowEditable){
        return;
    }
    setDirty(selectedRowBaseID + "statusValue", selectedRowBaseID + "dirtyHidden");
	    
	document.getElementById('tcPage:tcForm:hiddenProjectOrAssignmentIdWhilePopupDetailsSaved').value = document.getElementById(selectedRowBaseID + "projectOrAssignmentId").value;    
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
	
	/*Save project location data if set to display project locations*/
	if (_Config.useProjectLocationRecord && _Config.noteLocationAllowed) {
		sunLoc = _yui.one('#projectSunLocationSelect').get('value');
		monLoc = _yui.one('#projectMonLocationSelect').get('value');
		tueLoc = _yui.one('#projectTueLocationSelect').get('value');
		wedLoc = _yui.one('#projectWedLocationSelect').get('value');
		thuLoc = _yui.one('#projectThuLocationSelect').get('value');
		friLoc = _yui.one('#projectFriLocationSelect').get('value');
		satLoc = _yui.one('#projectSatLocationSelect').get('value');
		
		// Update as a fix for agile task : AT13342		05-07-2013		shankar
		document.getElementById('tcPage:tcForm:hiddenSunProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSunProjectLocation').value = (sunLoc == null || sunLoc == 'undefined' ? '' : sunLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenMonProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenMonProjectLocation').value = (monLoc == null || monLoc == 'undefined' ? '' : monLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenTueProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenTueProjectLocation').value = (tueLoc == null || tueLoc == 'undefined' ? '' : tueLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenWedProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenWedProjectLocation').value = (wedLoc == null || wedLoc == 'undefined' ? '' : wedLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenThuProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenThuProjectLocation').value = (thuLoc == null || thuLoc == 'undefined' ? '' : thuLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenFriProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenFriProjectLocation').value = (friLoc == null || friLoc == 'undefined' ? '' : friLoc) : false;
		document.getElementById('tcPage:tcForm:hiddenSatProjectLocation') != null ? document.getElementById('tcPage:tcForm:hiddenSatProjectLocation').value = (satLoc == null || satLoc == 'undefined' ? '' : satLoc) : false;
	}
	
	// Added changes for agile task: AT5203
	if (_Config.showPrimaryLocationOnPopup && _Config.useProjectLocationRecord) {
		priLoc = _yui.one('#projectPriLocationSelect').get('value');
		//document.getElementById('tcPage:tcForm:hiddenPriProjectLocation').value = (priLoc == null || priLoc == 'undefined' ? '' : priLoc);
		
		// Update as a fix for agile task : AT13342		05-07-2013		shankar
		document.getElementById(selectedRowBaseID + "hiddenProjectPrimaryLocation") != null ? document.getElementById(selectedRowBaseID + "hiddenProjectPrimaryLocation").value = (priLoc == null || priLoc == 'undefined' ? '' : priLoc) : false;
	}
	
	// added changes for agile task: AT1196
	if (_Config.showMethodologyOnPopup && _Config.useProjectMethodologyRecord) {
		methodologyValue = _yui.one('#projectMethodologySelect').get('value');
		
		// Update as a fix for agile task : AT13342		05-07-2013		shankar
		document.getElementById(selectedRowBaseID + "hiddenProjectMethodology") != null ? document.getElementById(selectedRowBaseID + "hiddenProjectMethodology").value = (methodologyValue == null || methodologyValue == 'undefined' ? '' : methodologyValue) : false;
		
	}
	// added changes for agile task: AT1185
	if (_Config.showPhaseOnPopup && _Config.useProjectPhaseRecord) {
		phaseValue = _yui.one('#projectPhaseSelect').get('value');
		//document.getElementById(selectedRowBaseID + "hiddenProjectPhase").value = (phaseValue == null || phaseValue == 'undefined' ? '' : phaseValue)
		
		// Update as a fix for agile task : AT13342		05-07-2013		shankar
		document.getElementById(selectedRowBaseID + "hiddenProjectPhase") != null ? (document.getElementById(selectedRowBaseID + "hiddenProjectPhase").value = (phaseValue == null || phaseValue == 'undefined' ? '' : phaseValue)) : false;
	}
	
	
}

// EVENT HANDLERS ENDS

//FIXME:TODO fix this globally
//Try using DIRTY custom event to mark the stuff dirty in more automated way !
function setDirty(statusId, dirtyId){           
    _hasUnsavedChanges = true;
    document.getElementById(statusId).innerHTML = "Unsaved";
    document.getElementById(dirtyId).value = "true";
}


/*
/=============================Row/Column total methods ========================================/
/=======This also decide if value of the hr text was changed, if so then sets diry flage=======/
*/
// Done changes as fix for agile task:000009241   By: Ashok   dated: 10/12/2010
/*Overriding the toFloat method to do specific changes for Timeacard. As not sure where all the common Float methods is used.*/
function toFloat(valueToParse){
    var result = 0.0;
    if(isStringNotEmpty(valueToParse)){
  		v = valueToParse.replace(_DEC_SEP, ".");
      	result = isNaN(v) ? parseFloat('0.00') : parseFloat(v);
    }
    return result; 
}

function onHrTextFocus(e, hrInputDomElement){
    /*Fix for AT0733 : In chrome pressing alt key fires this event multiple time*/
    if (!e) e = window.event;
    (e.target || e.srcElement)['data-focused'] = true;
    /*End Fix for AT0733*/
    
    _hrTextValueBeforeGotFocus = toFloat(hrInputDomElement.value);
}
/* Function added as a fix for agile task:000010315 dated: 12/07/2010 */
function onEtcTextBlur(hrInputDomElement){
   var newHrValue = toFloat(hrInputDomElement.value);
   hrInputDomElement.value = (newHrValue.toFixed(2)).replace(".", _DEC_SEP); 
}

function onHrdoubleClick(hrInputDomElementId, weekdayNumber, heading) {
    if(_Config.showEasyEntryPopup) {
    	showEasyEntrySection(hrInputDomElementId, weekdayNumber, heading);
    }
}

function onHrOutputClick(hrInputDomElementId, weekdayNumber, heading) {
    if(_Config.showEasyEntryPopup) {
    	_EasyEntryNotesHandler.isRowNonEditable = true;
    	showEasyEntrySection(hrInputDomElementId, weekdayNumber, heading);
    }
}

function onHrKeyPress(e, hrInputDomElementId, weekdayNumber, heading) {
	if(_Config.showEasyEntryPopup) {
		if(e.which == 40 || e.keyCode == 40) {
			showEasyEntrySection(hrInputDomElementId, weekdayNumber, heading);
		}
	}
}

function showEasyEntrySection(hrInputDomElementId, weekdayNumber, heading) {
	var top = 0, left = 0 ;
	
	var hrInputDomElement = document.getElementById(hrInputDomElementId);
	while(hrInputDomElement.tagName != "BODY") {
        top += hrInputDomElement.offsetTop;
        left += hrInputDomElement.offsetLeft;
        hrInputDomElement = hrInputDomElement.offsetParent;
    }
    
    var displayEasyEntrySection = false ;
    
    if(heading.indexOf('Sun') != -1) {
    	if(_Config.hasSundayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Mon') != -1) {
    	if(_Config.hasMondayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Tue') != -1) {
    	if(_Config.hasTuesdayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Wed') != -1) {
    	if(_Config.hasWednesdayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Thu') != -1) {
    	if(_Config.hasThursdayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Fri') != -1) {
    	if(_Config.hasFridayColumns)
    		displayEasyEntrySection = true ;
    } 
    else if(heading.indexOf('Sat') != -1) {
    	if(_Config.hasSaturdayColumns)
    		displayEasyEntrySection = true ;
    }
    
    if(displayEasyEntrySection)
    	_EasyEntryNotesHandler.show(hrInputDomElementId, weekdayNumber, top, left, heading);
}

function onValueChange() {
	// set the status flag to unsaved if anything changed on easy entry popup box
	if(_GlobalVariables.easyEntrySectionRowId != null) {
		setDirty(_GlobalVariables.easyEntrySectionRowId + 'statusValue', _GlobalVariables.easyEntrySectionRowId + 'dirtyHidden');
	}
}

function preventTabFunctionality(e) {
	if(e.which == 9 || e.keyCode == 9) {
		e.preventDefault();
		_EasyEntryNotesHandler.copy();
	}
}

function onHrTextBlur(e, dayIdentifier, hrInputDomElement, dayType){
	/*Fix for AT0733 : In chrome pressing alt key fires this event multiple time*/
	if (!e) e = window.event;
	if (!(e.target || e.srcElement)['data-focused']) return;
    (e.target || e.srcElement)['data-focused'] = false;
	/*End Fix for AT0733*/
    var newHrValue = toFloat(hrInputDomElement.value); 
    
    var holidayAlert = false;
    if(_Config.showAlertForNonZeroHolidayHours == true) {
	    if(dayType != null && dayType == 'h' && newHrValue != 0) {
	    	holidayAlert = true;
	    	alert(_Label.nonzeroHoursHolidayWarningMsg);
	    } 
	} 
	// Do not show weekend alert if holiday alert is already shown.
	if(holidayAlert == false && _Config.showAlertForNonZeroWeekendHours == true) {
		if(dayType != null && dayType == 'w' && newHrValue != 0) {
	    	alert(_Label.nonzeroHoursWeekendWarningMsg);
	    }
	}
    
    hrInputDomElement.value = (newHrValue.toFixed(2)).replace(".", _DEC_SEP);
    HR_FLOOR_LIMIT = _Config.dayHourAutoRevertFloor;
    HR_CEILING_LIMIT = _Config.dayHourAutoRevertCeiling;
    if(newHrValue > HR_CEILING_LIMIT){
    	hrInputDomElement.value = ((HR_CEILING_LIMIT).toFixed(2)).replace(".", _DEC_SEP);  
    	newHrValue = (HR_CEILING_LIMIT).toFixed(2);
    } 
    // Added as fix for agile task: 000010320    Dated: 12/08/2010
    else if(newHrValue < HR_FLOOR_LIMIT) {
    	hrInputDomElement.value = ((HR_FLOOR_LIMIT).toFixed(2)).replace(".", _DEC_SEP);;  
    	newHrValue = (HR_FLOOR_LIMIT).toFixed(2);
    }
    
    if(_hrTextValueBeforeGotFocus == newHrValue){    
    	return;
    }
    
    //Added as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 15 2010, Added By: Nitin Jain
    var colTotalId = hrInputDomElement.id.substring(0, hrInputDomElement.id.lastIndexOf(':'))
    colTotalId = colTotalId.substring(0, colTotalId.lastIndexOf(':'));
    colTotalId = colTotalId.substring(0, colTotalId.lastIndexOf(':') + 1);
    
    var rowBaseID = hrInputDomElement.id.substring(0, hrInputDomElement.id.lastIndexOf(':') + 1);
    var rowBaseIDForYUI = sfdcToJSID(rowBaseID);
    
    //Modified as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 15 2010, Added By: Nitin Jain
    //var rowTotalDIV = _yui.one(document.getElementById(rowBaseID + 'rowTotalHr'));
    var rowTotalDIV = _yui.one(document.getElementById(rowBaseID + 'rowTotalHr')).one('span');
    
    var rowTotal = toFloat(rowTotalDIV.get('innerHTML'));
    
    //Modified as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 15 2010, Added By: Nitin Jain
    //var columnTotalDIV = _yui.one(('#summaryHrDay'+dayIdentifier));
    var columnTotalDIV = _yui.one(document.getElementById(colTotalId + 'summaryHrDay' + dayIdentifier));

    var columnTotal = toFloat(columnTotalDIV.get('innerHTML'));
    
    //Modified as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 15 2010, Added By: Nitin Jain
    //var summaryHrsDIV = _yui.one('#summaryHrs');
    var summaryHrsDIV = _yui.one(document.getElementById(colTotalId + 'summaryHrs'));

    var summaryHrs = toFloat(summaryHrsDIV.get('innerHTML'));
    
    rowTotal = rowTotal + (newHrValue - _hrTextValueBeforeGotFocus);
    columnTotal = columnTotal + (newHrValue - _hrTextValueBeforeGotFocus);
    summaryHrs = summaryHrs + (newHrValue - _hrTextValueBeforeGotFocus);
    
    rowTotalDIV.set('text', (rowTotal.toFixed(2)).replace(".", _DEC_SEP));
    columnTotalDIV.set('text', (columnTotal.toFixed(2)).replace(".", _DEC_SEP));
    summaryHrsDIV.set('text', (summaryHrs.toFixed(2)).replace(".", _DEC_SEP));
    
    /*Mark timecard Status unsaved*/
    setDirty(rowBaseID + 'statusValue', rowBaseID + 'dirtyHidden');
}

function onSubmitClick(){
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	
    if (confirm(_Label.confirmSubmitTC)){
        
        _yui.one('#batchOverlayContainer').all('h1').set('text',_Label.submitTimecardsWindowTitle);
		_yui.one('#batchOverlayContainer').all('h3').set('text',_Label.submitTimecardsWindowMsg);
        
        beforeSubmitClickAdvanced();
        _BatchProcessHandler.show();
        beforeAjaxCall();
        jsSubmitTimecards();
    }
}
/*this method is needed so that we can prepare some hidden element's data. i.e milestone name*/
function beforeSubmitClickAdvanced(){
	prepareNotesDataToSaveBeforeSaveSubmitAction();
	
	if(_Config.showEasyEntryPopup) {
		prepareEasyEntryDataBeforeSaveSubmit();
	}
	_yui.all("#editDetailRowParentTbody tr").each(
		function (currNode, currNodeIdx, allRows){
			if(isStringEmpty(currNode.get('id'))){return;}
			currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
			if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') != 'n' 
				&& _yui.one(document.getElementById(currRowBaseId + 'isRowEditable')).get('value') == 'true') {
				//This means this row is editable and project/assignmemnt has been selected.
				
				var milestoneListPan;
				/*Update milestone name in memory*/
				if(_Config.showMilestoneOnFrontPage) {
			    	if(_Config.showMilestoneOnLeft) {
			    		milestoneListPan = _yui.one(document.getElementById(currRowBaseId + 'milestoneListLeftPanel'));
					} else {
						milestoneListPan = _yui.one(document.getElementById(currRowBaseId + 'milestoneListPanel'));
					}
				}
				
            	if(milestoneListPan != null){
	                milestoneNode = milestoneListPan.get('children').item(1);
	                milestoneSelectList = _yui.Node.getDOMNode(milestoneNode);
	                
					if(milestoneSelectList.selectedIndex >= 0){
						selectedMSLabel = milestoneSelectList[milestoneSelectList.selectedIndex].innerHTML;
						_yui.one(document.getElementById(currRowBaseId + 'hiddenMilestoneName')).set('value',selectedMSLabel);
					}
                }else{
                	var msListOnPopUp = document.getElementById('milestoneSelect');
                	if(msListOnPopUp != null){
                		if(msListOnPopUp.selectedIndex >= 0){
							var MSLabel = msListOnPopUp[msListOnPopUp.selectedIndex].innerHTML;
							_yui.one(document.getElementById(currRowBaseId + 'hiddenMilestoneName')).set('value',MSLabel);
						}
                	}
                }
                
                /* update methodology name , Changes done for agile task : AT1196 */
                if (_Config.showMethodologyOnFrontPage && _Config.useProjectMethodologyRecord) {
                	
                	var methodologyPanel;
                	if(_Config.showMethodologyOnLeft) {
			    		methodologyPanel = _yui.one(document.getElementById(currRowBaseId + 'methodologyListLeftPanel'));
		    		} else {
						methodologyPanel = _yui.one(document.getElementById(currRowBaseId + 'methodologyListPanel'));
					}
                	
                	if (methodologyPanel != null) {   // This will always gv true
                		methodologySelectList = _yui.Node.getDOMNode(methodologyPanel.get('children').item(1));
                		if (methodologySelectList.selectedIndex >= 0){
                			selectedMethodologyLabel = methodologySelectList[methodologySelectList.selectedIndex].innerHTML;
                			
                			// Update as a fix for agile task : AT13342		05-07-2013		shankar
							//_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectMethodologyName')).set('value',selectedMethodologyLabel);
							_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectMethodologyName')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectMethodologyName')).set('value',selectedMethodologyLabel) : false;
                		}
                	}
                }
                
                /* update phase name , Changes done for agile task : AT1185 */
                if(_Config.showPhaseOnFrontPage && _Config.useProjectPhaseRecord){
                	
                	var phasePanel;
                	if(_Config.showPhaseOnLeft) {
			    		phasePanel = _yui.one(document.getElementById(currRowBaseId + 'phaseListLeftPanel'));
		    		} else {
						phasePanel = _yui.one(document.getElementById(currRowBaseId + 'phaseListPanel'));
					}
                	
                	if (phasePanel != null) {   // This will always gv true
                		phaseSelectList = _yui.Node.getDOMNode(phasePanel.get('children').item(1));
                		if (phaseSelectList.selectedIndex >= 0){
                			selectedPhaseLabel = phaseSelectList[phaseSelectList.selectedIndex].innerHTML;
                			
                			// Update as a fix for agile task : AT13342		05-07-2013		shankar
							//_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPhaseName')).set('value',selectedPhaseLabel);
							_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPhaseName')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPhaseName')).set('value',selectedPhaseLabel) : false;
                		}
                	}
                }  
                
                /* update Primary Location name , Changes done for agile task : AT5203 */
                if(_Config.showPrimaryLocationOnFrontPage && _Config.useProjectLocationRecord){
                	
                	var primaryLocationPanel;
                	if(_Config.showPriLocationOnLeft) {
			    		primaryLocationPanel = _yui.one(document.getElementById(currRowBaseId + 'primaryLocationListLeftPanel'));
					} else {
						primaryLocationPanel = _yui.one(document.getElementById(currRowBaseId + 'primaryLocationListPanel'));
					}
                	if (primaryLocationPanel != null) {   // This will always gv true
                		primaryLocationSelectList = _yui.Node.getDOMNode(primaryLocationPanel.get('children').item(1));
                		if (primaryLocationSelectList.selectedIndex >= 0){
                			selectedPrimaryLocationLabel = primaryLocationSelectList[primaryLocationSelectList.selectedIndex].innerHTML;
                			
                			// Update as a fix for agile task : AT13342		05-07-2013		shankar
							//_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPrimaryLocationName')).set('value',selectedPrimaryLocationLabel);
							_yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPrimaryLocationName')) != null ? _yui.one(document.getElementById(currRowBaseId + 'hiddenProjectPrimaryLocationName')).set('value',selectedPrimaryLocationLabel) : false;
                		}
                	}
                }
                  
		    }  // end of function, called for each row
		}
	)
}
function beforeSaveClickAdvanced(){
	prepareNotesDataToSaveBeforeSaveSubmitAction();
	if(_Config.showEasyEntryPopup) {
		prepareEasyEntryDataBeforeSaveSubmit();
	}
	_yui.all("#editDetailRowParentTbody tr").each(
			function (currNode, currNodeIdx, allRows){
				if(isStringEmpty(currNode.get('id'))){return;}
				currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
				if (_yui.one(document.getElementById(currRowBaseId + 'projOrAssig')).get('value') != 'n' 
					&& _yui.one(document.getElementById(currRowBaseId + 'isRowEditable')).get('value') == 'true') {
					//This means this row is editable and project/assignmemnt has been selected.
	                /*Update milestone close flage if that row has been changed*/
	                isRowDirty = _yui.one(document.getElementById(currRowBaseId + 'dirtyHidden')).get('value');
	                isMSClosed = _yui.one(document.getElementById(currRowBaseId + 'hiddenIsMSClosed')).get('value');
	                if(isMSClosed == 'true' && isRowDirty == 'true'){
	                	_yui.one(document.getElementById(currRowBaseId + 'hiddenIsMSClosed')).set('value',false);
	                }
	    	    } 
			}
		)
}

/*This is to prevent salesforce DB error*/
function validateDataBeforeRequest(){
	_isAllOK = true;
_yui.all("#editDetailRowParentTbody .fakeSelectorClassForHrInput").each(
			function (currNode, currNodeIdx, allRows){
				hrVal = currNode.get('value');
				if(hrVal >=100 || hrVal <= -100){
					_isAllOK = false;
					/*
					if(!this.hasClass('hrInputTextError')){
						this.addClass('hrInputTextError');
					}*/
				}
			}
		);
		return _isAllOK;
	
}
/**/
function resetHrDetailsForRequest(){
_yui.all("#editDetailRowParentTbody .fakeSelectorClassForHrInput").set('value','0');
/*
_yui.all("#editDetailRowParentTbody .fakeSelectorClassForHrInput").each(
			function (currNode, currNodeIdx, allRows){
				hrVal = currNode.get('value');
				if(hrVal >=100 || hrVal <= -100){
					_isAllOK = false;
					if(!this.hasClass('hrInputTextError')){
						this.addClass('hrInputTextError');
					}
				}
			}
		);
		*/
}

/*Action methods call as the result of some event fire. i.e. save/submit etc*/
function deleteRow(deleteComp){
    if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	
    if (confirm(_Label.confirmDeleteRow)){
        document.getElementById(deleteComp).value = "true";
        beforeAjaxCall();
        jsDeleteRow();
    }
}

function onSaveClick(){
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	_yui.one('#batchOverlayContainer').all('h1').set('text',_Label.saveTimecardsWindowTitle);
	_yui.one('#batchOverlayContainer').all('h3').set('text',_Label.saveTimecardsWindowMsg);
	beforeSaveClickAdvanced();
	_BatchProcessHandler.show();
    beforeAjaxCall();
    jsSaveTimecard();    
}

function onClearRowClick(){
    if (!confirm(_Label.confirmClearRow))
        return;
	
	resetHrDetailsForRequest();
	        
    beforeAjaxCall();
    jsClearRow();
}


function onNewRowClick(){
   if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
   
   if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
   }	
   startTime = new Date().getTime();
   beforeAjaxCall();
   jsNewRow();
}

/*Added below function as per agile task : AT20630 */
function onMultipleNewRowClick(){
    if(!validateDataBeforeRequest()){
   	 alert(_Label.hrValueLargeError);
   	 return;
    }
	 startTime = new Date().getTime();
	 beforeAjaxCall();
    jsMultipleNewRows();
}


function onCopyFromScheduleClick() {
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError); 
		return;
    } 
   
    // Done changes as fix for Agile task: AT1612 	    Dated: 31 May, 2012
    var selectedAssigsValues = '';
    if(_yui.one('#scheduleFrame')!=null){
		var selectedAssigsObj = _yui.one('#scheduleFrame').get('contentWindow.document').one('#selectedAssignmentIDs');
		if(selectedAssigsObj != null) {
			selectedAssigsValues = selectedAssigsObj.get('value');
			if(selectedAssigsValues == null || selectedAssigsValues == '') {
				alert(_Label.noScheduleSelectedWarningMsg);
				return;
			}
		}else{
			selectedAssigsValues = 'ALL';
		}
	}else{
		selectedAssigsValues = 'ALL';
	} 

	var weekEndDay = document.getElementById(_VFComponent.tcForm_gotoDateField).value;
    var message = _Label.copyScheduleFor + ' ' + weekEndDay;
	if (confirm(message)) {	
		beforeAjaxCall();
        jsCopyFromSchedule(selectedAssigsValues);
    }
}

// Added as fix for agile task: AT0119 
function onOpenTCStatusToHide() {
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	_StatusToHideLookupHandler.show();
}
function onStatusToHideSave() {
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	beforeAjaxCall();
	_StatusToHideLookupHandler.hide();
	jsSaveTCStatusToHide();
}
function onStatusToHideSaveDone(){
    bindAll();
}

function onCopyFromPreviousWeek() {
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	_CopyPrevWeekLookupHandler.show();
}

function onCopyFromPreviousWeekOptionSelected() {
	if(!validateDataBeforeRequest()){
		alert(_Label.hrValueLargeError);
		return;
	}
	
	beforeAjaxCall();
	_CopyPrevWeekLookupHandler.hide();
	jsCopyFromPreviousWeek();
}

function onPreviousWeekClick(){
    if (_hasUnsavedChanges){
        if (!confirm(_Label.confirmUnsavedChanges))
            return;
    }
    resetHrDetailsForRequest();
    beforeAjaxCall();
    jsPreviousWeek();
}

function onNextWeekClick(){
    if (_hasUnsavedChanges){
        if (!confirm(_Label.confirmUnsavedChanges))
            return;
    }
    resetHrDetailsForRequest();
    beforeAjaxCall();
    jsNextWeek();
}


function onWeekPicked(newDateFieldValue){
    // @TODO: check if newally picked date is same to the date we picked last time
    if (_hasUnsavedChanges){
        if (!confirm(_Label.confirmUnsavedChanges)){
            return;
        }    
    }
    resetHrDetailsForRequest();
    beforeAjaxCall();
    jsGotoWeek();
}

/*Methods called after Ajax action completes*/
function onClearRowDone(){
    //_yui.on('key', function() {_AssignmentLookupHandler.search(true);}, '#assigORProjSearchString', 'down:13', _yui);
    bindAll();
}

function onNewRowDone(){ 
    //FIXME:TODO : have a method for all the stuff below:
    //_yui.on('key', function() {_AssignmentLookupHandler.search(true);}, '#assigORProjSearchString', 'down:13', _yui);
    bindAll();
}
function onNewRowBeforedomupdate(){
}

function onDeleteRowDone(){
    bindAll();
}

/* Added new method for Agile Task : 000011098  Dated : 22/09/2011  By: Aditi */
function OnRecallClick(tcId){
	_RecallLookupHandler.show();
	document.getElementById(_VFComponent.recallSection_selectedTCId).value = tcId;
	document.getElementById(_VFComponent.recallSection_selectedTCId).innerHTML = tcId;
}

/* Added new method for Agile Task : 000011098  Dated : 22/09/2011  By: Aditi */
function recallFromApprovalClicked(timecardId) {
	var comment = document.getElementById(_VFComponent.recallSection_comment).value;
	beforeAjaxCall();
	jsRecallClicked(comment, timecardId);
}

/* Added new method for Agile Task : 000011098  Dated : 22/09/2011  By: Aditi */
function recallWorkDone() {
	bindAll();
	_RecallLookupHandler.hide();
}

function onCopyFromPreviousWeekDone(isTCAvailableFromPrevWeek){
    _CopyFromPreviousWeek = true;
    bindAll();
    _CopyFromPreviousWeek = false;
    /* Added code for agile task : AT0364   Dated: 07, March 2012   */
    if(isTCAvailableFromPrevWeek)
    {
    	_hasUnsavedChanges = true ;
    }
    
}
function onCopyFromScheduleDone(isScheduleAvailable){
    bindAll();
    _hasUnsavedChanges = false ;
    
	/* Added code for agile task : 000011247   Dated: Feb 04 2012  */
    if(isScheduleAvailable)
    {
    	_hasUnsavedChanges = true ;
    }
}
function onJsNextWeekDone(){
    bindAll();
}
function onPreviousWeekDone(){
    bindAll();
}
function onGotoWeekDone(){
    bindAll();
}
function onChangeResourceDone(){
    bindAll();
} 

function onResetTCBatchProcessorDone (){
	_BatchProcessHandler.hide();
    bindAll();
}



/* We have customize req to use datepicker*/
function selectTodayDate(){
    var dateInputField = document.getElementById(_VFComponent.tcForm_gotoDateField);
    DatePicker.pickDate(true, dateInputField.id,false);
    DatePicker.datePicker.shim.setStyle("display", "none");
    DatePicker.datePicker.selectDate('today');
}

function showDatePopup(controlId) {
    var dateInputField = document.getElementById(_VFComponent.tcForm_gotoDateField);
    DatePicker.pickDate(true, dateInputField.id,false);//document.getElementById(controlId)
}

/*MISC methods*/

//timecard2pagejs
var MAX_NOTES_CHAR_LEN = 255;

//Changes done as fix for agile task:000003461    By:Ashok   Dated:04/27/2010 
function validateNotesLength(e) {
	if (e.target.get('value').length > MAX_NOTES_CHAR_LEN) {
		alert(_Label.dailyNotesAlertMsg);
		e.target.set('value', e.target.get('value').substring(0, MAX_NOTES_CHAR_LEN));
		e.preventDefault();
		return false;
	}
	
	return true;
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

function markRowEnableORDisabled(rowBaseIDForYUI, disabledStatus){
    if(_Config.showMilestoneOnFrontPage) {
    	if(_Config.showMilestoneOnLeft) {
    		_yui.one(document.getElementById(rowBaseIDForYUI +'milestoneListLeftPanel')).get('children').item(1).set('disabled', disabledStatus);
		} else {
			_yui.one(document.getElementById(rowBaseIDForYUI +'milestoneListPanel')).get('children').item(1).set('disabled', disabledStatus);
		}
	}
	
    // added changes for agile task : AT1185
    if(_Config.showPhaseOnFrontPage ){
    	if(_Config.showPhaseOnLeft) {
    		if(!_Config.useProjectPhaseRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'phaseLeft')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'phaseListLeftPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		} else {
			if(!_Config.useProjectPhaseRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'phase')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'phaseListPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		}
					
    	
    }
    // added changes for agile task : AT1196
    if(_Config.showMethodologyOnFrontPage){
        if(_Config.showMethodologyOnLeft) {
    		if (!_Config.useProjectMethodologyRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'methodologyLeft')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'methodologyListLeftPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		} else {
			if (!_Config.useProjectMethodologyRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'methodology')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'methodologyListPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		}
    }
    
    // added changes for agile task : AT5203
    if(_Config.showPrimaryLocationOnFrontPage){
    	if(_Config.showPriLocationOnLeft) {
    		if (!_Config.useProjectLocationRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'primaryLocationLeft')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'primaryLocationListLeftPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		} else {
			if (!_Config.useProjectLocationRecord) {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'primaryLocation')).set('disabled',disabledStatus);
	        } else {
	        	_yui.one(document.getElementById(rowBaseIDForYUI + 'primaryLocationListPanel')).get('children').item(1).set('disabled',disabledStatus);
	        }
		}
					
        
    }
    
    /* Changes done as fix for agile task: 000005391   Dated: 05/13/2010   
      Doing handling for disabling/enabling the billable flag as per the config value.
    */
    /*Special handling For billable checkbox*/
    if(_Config.showBillableOnLeft) {     
	    if(disabledStatus == 'disabled'){
	    	_yui.one(document.getElementById(rowBaseIDForYUI + 'billableLeft')) != null ? _yui.one(document.getElementById(rowBaseIDForYUI + 'billableLeft')).set('disabled',disabledStatus) : false;
	    }else{
	    	if(_Config.billableOptionChangeAllowed)	{
	    		var isValueBillable = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")).get('checked') : false;
	    		_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billableLeft")).set('disabled', (isValueBillable ? '' : 'disabled')) : false; 
	    	}
	    }
	 }else{
		if(disabledStatus == 'disabled'){
	    	_yui.one(document.getElementById(rowBaseIDForYUI + 'billable')) != null ? _yui.one(document.getElementById(rowBaseIDForYUI + 'billable')).set('disabled',disabledStatus) : false;
	    }else{
	    	if(_Config.billableOptionChangeAllowed)	{
	    		var isValueBillable = _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")).get('checked') : false;
	    		_yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")) != null ? _yui.one(document.getElementById(_AssignmentLookupHandler.rowBaseUnEscId + "billable")).set('disabled', (isValueBillable ? '' : 'disabled')) : false; 
	    	}
	    }
	 }   
    
    

    _yui.one(document.getElementById(rowBaseIDForYUI + 'sunTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'monTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'tuesTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'wedTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'thursTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'friTime')).set('disabled',disabledStatus);
    _yui.one(document.getElementById(rowBaseIDForYUI + 'satTime')).set('disabled',disabledStatus);
    if(_Config.showETC){
    	_yui.one(document.getElementById(rowBaseIDForYUI + 'etcValue')).set('disabled',disabledStatus);
    }
    
    //added fix for implementing fieldset on tc ui for AT33523
    var rowBaseIDForYUIsubstring = rowBaseIDForYUI.substring(0,rowBaseIDForYUI.length -1)
    var rowId =  rowBaseIDForYUIsubstring.substring(rowBaseIDForYUIsubstring.lastIndexOf(':')+1,(rowBaseIDForYUIsubstring.length));
    _yui.all('#tcRowID'+ rowId + ' .disableAdditionalEditableFields').set('disabled',disabledStatus);

    //add Opacity class to notes icon in Inactive Rows, remove when row isBeingMarkedActive
	var isRowBeingMarkedActive = (disabledStatus == 'disabled') ? false : true;
	var notesImagePlaceholder = _yui.one(document.getElementById(rowBaseIDForYUI +'notesImage'));
	if(notesImagePlaceholder!=null){
		if(disabledStatus == 'disabled') {
			//row is Disabled, so add the opacity class
			if(notesImagePlaceholder.hasClass('inactiveNotesImageOverlay') == false) {
	    		notesImagePlaceholder.addClass('inactiveNotesImageOverlay');
			}
		}
		else {
			//row is Enabled, remove the opacity class
			if(notesImagePlaceholder.hasClass('inactiveNotesImageOverlay')) {
	    		notesImagePlaceholder.removeClass('inactiveNotesImageOverlay');
			}	 
		}
	}
    
}

/// STUFF THAT WAS INCLUDED AT THE END IN TCENTRY.PAGE

function prepareOverlays(){
    _TooltipHandler.prepare();
    _ResourceLookupHandler.prepare();
    _AssignmentLookupHandler.prepare();
    _RowsHandler.prepare();
    _BatchProcessHandler.prepare();
    _CopyPrevWeekLookupHandler.prepare();
    _StatusToHideLookupHandler.prepare();
    // Added as fix for agile task : 000011098  Dated: 23/9/2011  By: Aditi
    _RecallLookupHandler.prepare();
    
    if(_Config.showEasyEntryPopup)
    	_EasyEntryNotesHandler.prepare();
    
}

var failureHandler = function (id, o){
    alert("Error:"+ o.status + " " + o.statusText);
} 

function doSelectResource(rid,rname){
    var doChange = _hasUnsavedChanges ? confirm(_Label.confirmUnsavedChanges) : true;
    if(doChange){
    	resetHrDetailsForRequest();
        _yui.one(document.getElementById(_VFComponent.tcForm_selectedResourceId)).set('value',rid);
        _yui.one(document.getElementById(_VFComponent.tcForm_resourceSelect)).set('text',unescape(rname));
        _ResourceLookupHandler.hide();
        beforeAjaxCall();
        jsChangeResource();
    } 
}

function bindAll() {
    _TooltipHandler.bindTooltip();
    // For each row calulate if it needs to be disabled.
    //TODO: we can make this iteration more generic, diabling will be just an option.
    _yui.all("#editDetailRowParentTbody tr").each(_RowsHandler.onRendering);
    _yui.all(".dialogTextArea").on("keyup", validateNotesLength);
    _NotesHandler.reset();
    _NotesHandler.inlineNotesTemplate = _yui.one('#notesContainer');

    _RowsHandler.reset();
    
    /*This is done to hide the edit detail link overlay.
    As the rerendering of table removes highlighted row but overlay.*/
    if(_RowsHandler.editOverlay.get('visible'))  {
		_RowsHandler.editOverlay.hide();
	}
}

function twistScheduleGrid(imgDomNode){
	if(togglingInProcess) {
		return false;
	} 
	togglingInProcess = true;
	imgNode = _yui.one(imgDomNode);
	if (imgNode.hasClass('hideListButton')) {
		imgNode.replaceClass('hideListButton','showListButton');
		document.getElementById('scheduleFrame').src = '';
		jsToggleScheduleGridCollapse();
	} else {
		imgNode.replaceClass('showListButton','hideListButton');
		document.getElementById('scheduleFrame').src = scheduleGridURL;
		jsToggleScheduleGridExpansion();
	}
	
}

function beforeAjaxCall(){
	//This means notes detail section is opened, we need to close to prevent it from lost due to VF ajax rerender
	if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
		_NotesHandler.currentNotesInEditingDirty = false;
		_NotesHandler.onOK(true);
	}
}
function prepareNotesDataToSaveBeforeSaveSubmitAction(){
	if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
		/*Save notes data for the opend row*/
		if(_NotesHandler.currentNotesInEditingDirty){
			_NotesHandler.setRowNumberToSaveDataToTheServer(_NotesHandler.currentRowInEditing);
			_NotesHandler.copyNotesToRow(_NotesHandler.currentRowInEditing);
		}
	}
}

function prepareEasyEntryDataBeforeSaveSubmit() {
	 if(_EasyEntryNotesHandler.currentPopupDirty) {
	 	_EasyEntryNotesHandler.copy();
	 }
}