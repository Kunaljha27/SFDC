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
        }
      
        _yui.one("#assignmentLoadWaitImageID").set('style.visibility', 'hidden');
        _yui.one('#searchResultsLink').simulate("click", { relatedTarget: document.body });
    },
    
    doSelectAssignment: function(aid){
         var root = _AssignmentLookupHandler.assigCache[aid];
         var aname = escape(root.getElementsByTagName('name')[0].firstChild.nodeValue);
         var nickName = escape(root.getElementsByTagName('nickName')[0].firstChild.nodeValue);
         var isAssignment = (root.getElementsByTagName('isAssignment')[0].firstChild.nodeValue == 'true');
         var isBillable = root.getElementsByTagName('billable')[0].firstChild.nodeValue == "true";
         var pid = root.getElementsByTagName('projectId')[0].firstChild.nodeValue;    
         _AssignmentLookupHandler.refreshAssigDependentDetails(aid,aname, nickName, isAssignment, isBillable, pid);      
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
            _AssignmentLookupHandler.toggleNicknameEdit(aid, escape(nickNameVal), nickNameTD.one('.nickNameHolder'),false);
        }
        /*========  Now check if the assignment is selected in timecard row, 
            if so then replace assignment name there also ====================================*/
        /*  Check if nickname is blank, if so it means user is trying to delete the existing nickname. 
            In this case we need to show assignment name on the TC UI*/

        if(isStringEmpty(nickNameVal)){
            nickNameVal = currentRow.one('.assigNameTD').get('text').replace(/^\s+|\s+$/, '');
        }   

        // added to support assignment nick name change support on nickname change. 
        if(_yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignId)).get('value') == aid){
            _yui.one(document.getElementById(_VFComponent.expForm_assignmentSelect)).set('text',nickNameVal);       
            _yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignName)).set('value',nickNameVal);
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
    
    refreshAssigDependentDetails: function (aid,aname, nickName, isAssignment, isBillable, pid) {
         aname= isStringNotEmpty(aname) ? unescape(aname) : aname;
         /*Check if nickname was updated if so then load from JS cache*/
         nName = _AssignmentLookupHandler.fromNickNameCache(aid);
         
         if(isStringNotEmpty(nName)){
            nickName = nName;
         }
         nickName= isStringNotEmpty(nickName) ? unescape(nickName) : nickName;
          projOrAssigName = isStringNotEmpty(nickName) ? nickName : aname;
          
          _yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignId)).set('value',aid);
          _yui.one(document.getElementById(_VFComponent.expForm_assignmentSelect)).set('text',projOrAssigName);         
          _yui.one(document.getElementById(_VFComponent.expForm_selectedProjAssignName)).set('value',projOrAssigName);
          if(document.getElementById(_VFComponent.expForm_hiddenMilestone) != null)
          {
          	_yui.one(document.getElementById(_VFComponent.expForm_hiddenMilestone)).set('value','');
          }
          
          _hasUnsavedChanges = true;
          _AssignmentLookupHandler.hide();
          jsProjAssignChange();       
    },  
    
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

function doSelectResource(rid,rname){
    _yui.one(document.getElementById(_VFComponent.expForm_selectedResourceId)).set('value',rid);
    _yui.one(document.getElementById(_VFComponent.expForm_resourceSelect)).set('text',unescape(rname));
    _ResourceLookupHandler.hide();
    jsChangeResource();
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
	if (_yui.one(document.getElementById(currRowBaseId + 'type')).get('value') == '') {
		markRowEnableORDisabled(currRowBaseId, 'disabled');
	}
}
_RowsHandler.isRowHighlightable = function(newlyHoveredRowIndex){
	rowBaseId = toRowBaseIdFromRowIndexUnEscaped(newlyHoveredRowIndex);
	if(_yui.one(document.getElementById(rowBaseId + 'type')).get('value') == ''){
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
	
_NotesHandler.resetNotesRowdata = function () {
	_yui.all('.fakeSelectorClassForNotesInput').set('value','');
	//there is new class for checkbox fakeSelectorClassForNotesInputCheckBox
	
	_yui.all('.fakeSelectorClassForNotesInputCheckBox').set('checked',false);
	
	if(_Config.displayNonReimbursable && _Config.displayNonReimbursableOnPopup){
		_yui.one('.nonReimFieldFakeYUIStyle').set('checked',false);
	}
	//_yui.one('#billableAmountDiv').set('text','0.0');
	if(_Config.displayTaxNonBillable){
		_yui.one('.taxNonBillableFieldFakeYUIStyle').set('checked',_Config.defaultTaxNonBillable);
	}
}

/*We need this to calculate billable amount*/
_NotesHandler.prepareNotesRowExtension = function (forRowId){
	_TooltipHandler.bindTooltip();
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

// Added as a fix for Agle Task : AT18970
// remove the key event from the expense type field
function removeExpenseTypeEventListener(typeObj){
	rowYUINode = _yui.one(typeObj).ancestor('tr');	
	var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
	var expTypeElem = document.getElementById(rowBaseIDForYUI+"type");
    if(expTypeElem.removeEventListener ) {
        expTypeElem.removeEventListener('keydown',this.keyHandler,false);
    } else if(expTypeElem.detachEvent ) {
        expTypeElem.detachEvent('onkeydown',this.keyHandler); /* damn IE hack */
    }
}

var expTypeObjRef = null;

// Added as a fix for Agle Task : AT18970
// Add key event listener to the expense type field on focus.
function onExpenseTypeFocus(typeObj) {
	expTypeObjRef = typeObj;
	rowYUINode = _yui.one(typeObj).ancestor('tr');	
	var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
	var expTypeElem = document.getElementById(rowBaseIDForYUI+"type");
    if(expTypeElem.addEventListener ) {
        expTypeElem.addEventListener('keydown',this.keyHandler,false);
    } else if(expTypeElem.attachEvent ) {
        expTypeElem.attachEvent('onkeydown',this.keyHandler); /* damn IE hack */
    }
}

// function to be called on key event occurrence
function keyHandler(e) {
	var TABKEY = 9;
	
	// check if tab has been pressed and browser is either chrome or IE then call method to set focus after expense type
    if(!e.shiftKey && e.keyCode == TABKEY && (_yui.UA.chrome > 0 || _yui.UA.ie > 0) && expTypeObjRef.value != '') {
		setFocusAfterExpenseType(expTypeObjRef);
		if(e.preventDefault) {
        	e.preventDefault();
        }
    	return false;
   	}
}

// element on which focus to be set after expense type depending on configs
function setFocusAfterExpenseType(typeObj) {
	rowYUINode = _yui.one(typeObj).ancestor('tr');
	if(typeObj.value != ''){
		//Done changes as fix for agile task: 000009272   Dated: 10/26/2010    By:Ashok
		// Added code for Non Reimbursable handling on front page for Agile Task : 000011014  Dated : 28 April,2011   By: Aditi
		var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
		if(_Config.displayBillable){
			if(_Config.mixedBillableNonBillableERs){
        		_yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).focus();
	        }
	        else{
	        	_yui.one(document.getElementById(rowBaseIDForYUI +'descr')).focus();
	        }
	        _yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).focus();
	    } else if (_Config.displayNonReimbursable && !_Config.displayNonReimbursableOnPopup) {
	    	// Added above first check as fix for Agile task: AT0779
	     	_yui.one(document.getElementById(rowBaseIDForYUI +'nonReimburOnFrontPage')).focus();
	    } else {
	    	_yui.one(document.getElementById(rowBaseIDForYUI +'descr')).focus();
	    }	
	}
}

var _focusedExpenseTypeOldValue;
function onExpenseTypeChange(typeObj){
	// Commented below code as fix for Agile Task: AT13458  Dated: 9 May, 2013
    //if(_focusedExpenseTypeOldValue != '' && typeObj.value != ''){
    	//return; 
   // }

    rowYUINode = _yui.one(typeObj).ancestor('tr');
    if(typeObj.value == ''){
    	markRowEnableORDisabled(toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id')),'disabled');
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
		markRowEnableORDisabled(toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id')),'');
		_RowsHandler.hoveredRowIndex = null;		
		rowYUINode.simulate("mouseover", { relatedTarget: document.body });
	}
	
	//_focusedExpenseTypeOldValue = typeObj.value;	
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
	
	// if called from browser other than chrome and IE
	if(_yui.UA.chrome == 0 && _yui.UA.ie == 0) {
   		setFocusAfterExpenseType(typeObj);
   	}
}

function markNonBillableAmountEnableOrDisable(billableFieldYUINode) {
		
		isBillable = billableFieldYUINode.get('checked');
		/*
			Now enable/disable "Non-Billable Amount" 
			Blank out non-billable value only if expense line is marked as nonbillable.
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
    if(_Config.displayBillable){
    	if(_Config.mixedBillableNonBillableERs){
        	_yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).set('disabled', disabledStatus);
        }
        else{
        	_yui.one(document.getElementById(rowBaseIDForYUI +'billableLine')).set('disabled', 'disabled');
        }
      
    }
    // Added code for Non Reimbursable handling on front page for Agile Task : 000011014  Dated : 28 April,2011   By: Aditi
    if (_Config.displayNonReimbursable && !_Config.displayNonReimbursableOnPopup) {
    	_yui.one(document.getElementById(rowBaseIDForYUI +'nonReimburOnFrontPage')).set('disabled', disabledStatus);
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

function toRowBaseIdFromRowIndexUnEscaped(rowIndex) {
	anyInputInRow = _yui.one('#'+rowIndex + ' .fakeClassForYUISelection');
	if(anyInputInRow == null) return;
    hiddenElemId = anyInputInRow.get('id');
    return hiddenElemId.substring(0, hiddenElemId.lastIndexOf(':') + 1);
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
    if(amount < 0){
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
    		// Commented below line as fix for BUG :B-2325   Dated: 10 June, 2012
    		//input_incurredTaxAmount.set('value', number_format(number_unformat(amount), 2, _DEC_SEP, _THO_SEP));
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
var elementToFocus;
var isSimilarAjaxRequestDisabled = false;
function disableSimilarAjaxRequest(expFieldInputElementId){
	elementToFocus = expFieldInputElementId;
    _yui.one('#pageNavigationLinks').setStyle('display', 'none');
    _yui.one('#fakePageNavigationLinks').setStyle('display', 'block');

    _yui.all("#editDetailRowParentTbody tr").each(function(currNode, currNodeIdx, allRows) {
        var disabledStatus = 'disabled' ;
        currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
        var expenseTypeInputEl = document.getElementById(currRowBaseId + 'type');
        if (expenseTypeInputEl != null) {
            if(_yui.one(expenseTypeInputEl).get('value') != ''){
                _yui.one(document.getElementById(currRowBaseId +'amountText')).set('disabled', disabledStatus);
                _yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')).set('disabled', disabledStatus);
                if(!_Config.showTaxtypeOnPopup) {
    				_yui.one(document.getElementById(currRowBaseId +'expTaxType')).set('disabled', disabledStatus);
				}
                _yui.one('.pageNumberInputFieldFakeYUIStyle').set('disabled', disabledStatus);
            }
            // Added as fix for Bug: B-2808   Dated: 6 Dec, 2012
            _yui.one(expenseTypeInputEl).set('disabled', disabledStatus);
            _yui.one(document.getElementById(currRowBaseId +'date')).set('disabled', disabledStatus);
        }
        _yui.all('.actionButton').set('disabled', disabledStatus);
        _yui.all('.actionButton').addClass('btnDisabled');
    });
    
	isSimilarAjaxRequestDisabled = true;
	setTimeout("enableSimilarAjaxRequest()", _Config.uiAjaxTimeoutMs);

}
function enableSimilarAjaxRequest(){
	if(isSimilarAjaxRequestDisabled){
		isSimilarAjaxRequestDisabled = false;
	    _yui.one('#pageNavigationLinks').setStyle('display', 'block');
	    _yui.one('#fakePageNavigationLinks').setStyle('display', 'none');
	
	    _yui.all("#editDetailRowParentTbody tr").each(function(currNode, currNodeIdx, allRows) {
	        var disabledStatus = '' ;
	        currRowBaseId = toRowBaseIdFromRowIndexUnEscaped(currNode.get('id'));
	        var expenseTypeInputEl = document.getElementById(currRowBaseId + 'type');
	        if (expenseTypeInputEl != null) {
	            if(_yui.one(expenseTypeInputEl).get('value') != ''){
	                _yui.one(document.getElementById(currRowBaseId +'amountText')).set('disabled', disabledStatus);
	                _yui.one(document.getElementById(currRowBaseId +'currencyISOCodeInput')).set('disabled', disabledStatus);
	                _yui.one('.pageNumberInputFieldFakeYUIStyle').set('disabled', disabledStatus);
	                if(!_Config.showTaxtypeOnPopup) {
	                	_yui.one(document.getElementById(currRowBaseId +'expTaxType')).set('disabled', disabledStatus);
	                	}
	            }
	            // Added as fix for Bug: B-2808   Dated: 6 Dec, 2012
	            _yui.one(expenseTypeInputEl).set('disabled', disabledStatus);
	            _yui.one(document.getElementById(currRowBaseId +'date')).set('disabled', disabledStatus);
	        }
	        _yui.all('.actionButton').set('disabled', disabledStatus);
	        _yui.all('.actionButton').removeClass('btnDisabled');
			if(document.getElementById(elementToFocus) != null) _yui.one(document.getElementById(elementToFocus)).focus();
	    });
    }
}

// Done changes as fix for agile task: 000008016    Dated: 09/09/2010   By:Ashok
function onIncurredTaxAmountChange(incurredTaxParamField) {
	if(_NotesHandler.currentRowInEditing != null) {
		currentRow = _yui.one('#'+_NotesHandler.currentRowInEditing);
		
		// Done changes for fixing Agile task: AT10059  Dated: 7 Feb, 2013
		rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
		billableCheckboxInput = _Config.displayBillable ? currentRow.one('.billableLineInputStyle') : _yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped +'billableHiddenLine'));
		
		markNonBillableAmountEnableOrDisable(billableCheckboxInput);
	}	
	calculateBillableAmount(null,null,incurredTaxParamField,null,null);
}

function onSaveClick(){
	wait(true);//Added as fix for AT1615
	prepareNotesDataToSaveBeforeSaveAction();
	
}

function onExpenseBillableStatusChange(billableFieldObj){
	if(getExpenseRowIDByAnyInput(billableFieldObj) != _NotesHandler.currentRowInEditing){
            return;
    }
	calculateBillableAmount(null,null,null,billableFieldObj,null);	
	billableFieldYUINode = _yui.one(billableFieldObj);
	markNonBillableAmountEnableOrDisable(billableFieldYUINode);
}

//-- On change handler for exchange Rate field ---------
function onExpenseDateChange(exchangeDateDOMNode){
	updateDate(exchangeDateDOMNode);
	
	// Added changes as fix for AT: AT13302 to set focus on next field. 
	rowYUINode = _yui.one(exchangeDateDOMNode).ancestor('tr');
	var rowBaseIDForYUI = toRowBaseIdFromRowIndexUnEscaped(rowYUINode.get('id'));
	var typeInputElementID = rowBaseIDForYUI +'type';
	
	/*This calls server method to re-construct exchange rate map*/
	disableSimilarAjaxRequest(typeInputElementID);
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
function onExpenseCurrencyChange(expenseCurrencyDOMNode, isExpenseRateType, expTypeId, expUnitFieldId, distTextId){
	var currencyInputElementId = toRowBaseIdFromAnyInput(expenseCurrencyDOMNode)+ 'currencyISOCodeInput';
	disableSimilarAjaxRequest(currencyInputElementId);
	rowBaseIdFromRowIndexUnEscaped = toRowBaseIdFromAnyInput(expenseCurrencyDOMNode);
	_yui.one(document.getElementById(rowBaseIdFromRowIndexUnEscaped + 'exchangeRateResDefined')).set('value','');
	
	// Added below as fix for agile task:000011036    Dated: 24 May, 2011
	if(isExpenseRateType) {
		convertExpenseAmountForRateExpType(expenseCurrencyDOMNode.value, expTypeId, expUnitFieldId,
									distTextId, getExpenseRowByAnyInput(expenseCurrencyDOMNode));
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
function convertExpenseAmountForRateExpType(selectedCurrencyCode, expTypeId, expUnitFieldId, distTxtId, editingRowYUINode) {
	
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
        var unitField = document.getElementById(expUnitFieldId);
        if (unitField == null || unitField.value == null || unitField.value == '')
            return;
        var typeField = document.getElementById(expTypeId);
        if (typeField == null || typeField.value == null || typeField.value == '')
            return;
        
        var rate = null;
        if(_expenseRatesByExpenseRowMap[rowNumber] == null) 
        {
        	rate = expenseRatesMap[typeField.value][unitField.value];
        	
        	rateCurrencyISOCode = expenseRatesMap[typeField.value][unitField.value+'_code'];
        }
        else 
        {
        	rate = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value];
        
	        // If expense rate by date corresponding to the selected row is undefined, get the rate 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rate)  == "undefined"){
	        	rate = expenseRatesMap[typeField.value][unitField.value];
	        }
	        
	         var rateCurrencyISOCode = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value +'_code'];
	        // If expense rate code by date corresponding to the selected row is undefined, get the code 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rateCurrencyISOCode)  == "undefined"){
	        	rateCurrencyISOCode = expenseRatesMap[typeField.value][unitField.value+'_code'];
	        }
	   	}
	        
        if (rate == null)
            return;
        
        var oldAmtVal = amountYUINode.get('value');
        var amt = rate * parseFloat(val);
        if(selectedCurrencyCode != null) {
        	
        	// Done below changes as fix for AT: AT5085    Dated: 24 Aug, 2012
        	var exchangeRateForSelectedRowCurrency = 0;
        	var exchangeRateForRateCurrency = 0;
        	if(_Config.expenseDateToConvertRatesLimits) 
        	{
        		exchangeRateForSelectedRowCurrency = _currencyExchangeRatesMap[rowNumber][selectedCurrencyCode];
        		exchangeRateForRateCurrency = _currencyExchangeRatesMap[rowNumber][rateCurrencyISOCode];
        	}
        	 else 
        	{
        		var xIndex = typeField.value + '_' + unitField.value;
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
	var nextInputElementId = '';
	// Set tab focus after expense amount change
	var distanceInputElementId = toRowBaseIdFromAnyInput(expenseAmountDOMNode)+ 'autoMileagePanel';
	if(distanceInputElementId != null && document.getElementById(distanceInputElementId).style.display == 'inline'){
		nextInputElementId = distanceInputElementId;
	}else{
		nextInputElementId = toRowBaseIdFromAnyInput(expenseAmountDOMNode)+ 'currencyISOCodeInput';
	}
	
	//Added as fix for agile task: 000009297, Dated: Dec 24 2010, Added By: Nitin Jain
	//---------------------------------Added Code of Lines----------------------------
	//var newAmountDOMNodeValue = toFloat(('' + expenseAmountDOMNode.value).replace(_THO_SEP, ''));
	var newAmountDOMNodeValue = number_unformat(expenseAmountDOMNode.value);
	//expenseAmountDOMNode.value = (newAmountDOMNodeValue.toFixed(2)).replace(".", _DEC_SEP);
	//expenseAmountDOMNode.value = formatNumber(newAmountDOMNodeValue.toFixed(2), 2, _THO_SEP, _DEC_SEP, '', '', '', '');
	expenseAmountDOMNode.value = number_format(newAmountDOMNodeValue, 2, _DEC_SEP, _THO_SEP);
	//---------------------------------Added Code of Lines----------------------------
	
	//To recalculate total expense amount
	disableSimilarAjaxRequest(nextInputElementId);
	jsOnExpenseAmountChange();
	
	// If current expense row is in editing then recaluclate reimbursement
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
	        
	        var expenseTypeInputEl = document.getElementById(rowBaseIDForYUI + 'type');
	        if (expenseTypeInputEl != null) {
	            if(_yui.one(expenseTypeInputEl).get('value') != ''){
	                //AT33454Commented outed the below line from setting resource define rate defined to null after date change
	        		//_yui.one(document.getElementById(rowBaseIDForYUI + 'exchangeRateResDefined')).set('value','');
					expTypeId = _yui.one(document.getElementById(rowBaseIDForYUI +'type')).get('id');
					expUnitFieldId = _yui.one(document.getElementById(rowBaseIDForYUI +'unitField')).get('id');
					distTextId = _yui.one(document.getElementById(rowBaseIDForYUI +'distText')).get('id');
					selectedCurrencyCode = _yui.one(document.getElementById(rowBaseIDForYUI +'currencyISOCodeInput')).get('value');
					
					convertExpenseAmountForRateExpType(selectedCurrencyCode, expTypeId, expUnitFieldId, distTextId, currNode);		
		        }
		    }
	});
	
	jsOnExpenseCurrencyChange();
	enableSimilarAjaxRequest();
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
	
	// Done changes to support Agile Task: AT5085    Dated: 24 Aug, 2012
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




function doCallAddRows(){
    beforeAjaxCall();
    jsAddRow();
}
function doCallPageUpdate(){
    // Done changes as fix for agile task: 000008004  Dated: 08/20/2010
	var pageNumber = _yui.one('.pageNumberInputFieldFakeYUIStyle').get('value');
	var maxPageCount =  _yui.one('#totalPageCountHiddenField').get('value');
	if(pageNumber == null || isStringEmpty(pageNumber) || pageNumber <= 0 || pageNumber > maxPageCount) {
		_yui.one('.pageNumberInputFieldFakeYUIStyle').set('value', _yui.one('#pageNumberHiddenField').get('value'));
		return;
	}
    beforeAjaxCall();
    jsPageUpdate();
}

function doCallGetFirstPageRecords(){
    beforeAjaxCall();
    jsGetFirstPageRecords();
}
function doCallGetPreviousRecords(){
    beforeAjaxCall();
    jsGetPreviousRecords();
}
function doCallGetNextRecords(){
    beforeAjaxCall();
    jsGetNextRecords();
}
function doCallGetLastPageRecords(){
    beforeAjaxCall();
    jsGetLastPageRecords();
}

function beforeAjaxCall(){
    //This means notes detail section is opened, we need to close to prevent it from lost due to VF ajax rerender
    if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
        _NotesHandler.currentNotesInEditingDirty = false;
        _NotesHandler.onOK(true);
    }
    if(_RowsHandler.editOverlay.get('visible'))  {
        _RowsHandler.editOverlay.hide();
    }
}

function prepareNotesDataToSaveBeforeSaveAction(){
	if(_yui.one('#notesContainerHolder').one('#notesContainer') == null){
		/*Save notes data for the opend row*/
		if(_NotesHandler.currentNotesInEditingDirty){
			_NotesHandler.setRowNumberToSaveDataToTheServer(_NotesHandler.currentRowInEditing);
		}
	}
}

function bindAll(){
	/*@TODO may be another solution for this*/
	_yui.all(".amountFieldsStyle").on("key", function (e) { e.preventDefault();}, 'down:13', _yui); 
	_yui.all(".pageNumberInputFieldFakeYUIStyle").on("key", function (e) { e.preventDefault(); doCallPageUpdate();}, 'down:13', _yui); 
	
	_TooltipHandler.bindTooltip();
	_RowsHandler.reset();
	checkAllowMixedBillable();
}

//AT36648 add check to disable all check boxes on expense item when mixed billanle config is false
function checkAllowMixedBillable()
{
	if(!(_Config.mixedBillableNonBillableERs)){
    	if(_yui.one('.billableLineInputStyle')!= null){
    		_yui.all('.billableLineInputStyle').set('disabled', 'disabled');
   		}
    }
}
function prepareOverlays(){
    _TooltipHandler.prepare();
    _RowsHandler.prepare();
    _ResourceLookupHandler.prepare();
    _AssignmentLookupHandler.prepare();
}

//------------- Edit Expense and Expense entry common function ------------------
function onTypeChange(typeField, mileagePanelId){
    var mPanel = document.getElementById(mileagePanelId);
    if (mPanel){
        if (expenseRatesMap[typeField.value] != null)
            mPanel.style.display = 'inline';
        else
            mPanel.style.display = 'none';
    }
}

function recalculateMileageAmt(typeFieldId, distTxtId, amtId, unitFld, currencyISOCodeId)
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
        var unitField = document.getElementById(unitFld);
        if (unitField == null || unitField.value == null || unitField.value == '')
            return;
        var typeField = document.getElementById(typeFieldId);
        if (typeField == null || typeField.value == null || typeField.value == '')
            return;
            
        // added for story 15660  Dated: 5 Feb, 2014
        rowNumber = getExpenseRowLineNumber(distTxt);
        
        var rate = null;
        if(_expenseRatesByExpenseRowMap[rowNumber] == null) 
        {
        	rate = expenseRatesMap[typeField.value][unitField.value];
        	rateCurrencyISOCode = expenseRatesMap[typeField.value][unitField.value+'_code'];
        }
        else 
        {
        	rate = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value];
        
	        // If expense rate by date corresponding to the selected row is undefined, get the rate 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rate)  == "undefined"){
	        	rate = expenseRatesMap[typeField.value][unitField.value];
	        }
	        
	        var rateCurrencyISOCode = _expenseRatesByExpenseRowMap[rowNumber][typeField.value +'_'+ unitField.value +'_code'];
	        // If expense rate code by date corresponding to the selected row is undefined, get the code 
	        // without date i.e one matching the expense type and unit. 
	        if(typeof(rateCurrencyISOCode)  == "undefined"){
	        	rateCurrencyISOCode = expenseRatesMap[typeField.value][unitField.value+'_code'];
	        }
	    }
        
        if (rate == null) 
            return;
        
        var oldAmtVal = document.getElementById(amtId).value;
        var amt = rate * parseFloat(val);
        // Added below as fix for agile task:000011036    Dated: 24 May, 2011
        var currencyISOCode = document.getElementById(currencyISOCodeId).value;
        if(currencyISOCode != null) {
        	
        	// Done below changes as fix for AT: AT5085    Dated: 24 Aug, 2012
        	var exchangeRateForSelectedRowCurrency = 0;
        	var exchangeRateForRateCurrency = 0;
        	if(_Config.expenseDateToConvertRatesLimits) 
        	{
        		exchangeRateForSelectedRowCurrency = _currencyExchangeRatesMap[rowNumber][currencyISOCode];
        		exchangeRateForRateCurrency = _currencyExchangeRatesMap[rowNumber][rateCurrencyISOCode];
        	}
        	 else 
        	{	
        		var xIndex = typeField.value + '_' + unitField.value;
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
			        	// Added as fix for AT: AT2684    Dated: 31 July, 2012
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