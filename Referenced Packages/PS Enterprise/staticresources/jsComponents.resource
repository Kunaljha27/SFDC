var NOTES_DONE_BUTTON_BOTTOM_PADDING = 20;
///////////////////////////////Pre-Require/////////////////////////////////////
//-------------------------Label-----------------
/* 
var _Label = {
    noResultsFound : "{!$Label.timecard_entry_label_no_matching_results_found}",
    cancel : "{!$Label.common_label_cancel}",
    save : "{!$Label.common_label_save}",
    add : "{!$Label.common_label_add}",
    myAssignments : "{!$Label.timecard_entry_label_my_assignments}",
    globalProjects : "{!$Label.timacard_entry_label_global_projects}",
    
    nickName : "{!$Label.timacard_entry_label_nick_name}",
    
    name : "{!$Label.common_label_name}",
    account : "{!$Label.common_label_account}",
    region : "{!$Label.common_label_region}",
    practice : "{!$Label.common_label_practice}",
    group : "{!$Label.common_label_group}",
    
    editDetails : "{!$Label.common_label_edit_details}",
    viewDetails : "{!$Label.common_label_view_details}",
    confirmUnsavedChanges : "{!$Label.timecard_entry_message_unsaved_changes_discard_changes_and_continue}",
    unsavedNotesChanges : "{!$Label.timecard_entry_label_unsave_notes_save_now}",
    loadingDetails : "{!$Label.common_label_loading_details}"
    
}*/

//-----Functions-------------
//jsSetNotesDetail()
//jsgetNotesDetail()

//------Styles---------------
//loadingImageStyle

//-----------Name
// Table's tbody name should be editDetailRowParentTbody OR make use the JS config
//There should be one apex input with class fakeClassForYUISelection
//there should be one hidden with classname fakeSelectorClassToDecideRowStatus which holds row's DB ID
////////////////////////////////////////////////////////////////////

//Changes is class or other/////////////////////////////////////////
//onTCRowSelected = onRowSelected
///////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////
//---------------Row highlighting AND Notes section Starts from here-------------------//
/////////////////////////////////////////////////////////////////////////////////////////

var _RowsHandler = {
    
    getRowID : null,
    getLinkLabel : null,
	isRowHighlightable : null,
	isRowEditable : null,
	
	
	onRenderingExtension : null,
	onMouseOverExtension : null,
	onOkExtension : null,
	
	haltRowHighlighting : false,
    hoveredRowIndex : null,
    editOverlay : null,
    
    reset : function() {
       _RowsHandler.haltRowHighlighting = false;
        _RowsHandler.hoveredRowIndex = null;
        _yui.all("#editDetailRowParentTbody tr").each(_RowsHandler.onRendering);
    },
    
    prepare : function () {
    	_yui.one('body').append(_yui.Node.create('<div id="notesLinkDiv" class="notesLinkOverlay"></div>'));
       _RowsHandler.editOverlay =  new _yui.Overlay({
	        zIndex:1,
	        contentBox: '#notesLinkDiv',
	        visible:false
	    }); 
	    _RowsHandler.editOverlay.render();
	    _yui.on('mouseover', function(e) {e.halt();}, '#notesLinkDiv');
    },
    
    onRendering : function(currNode, currNodeIdx, allRows) {
        // for each row node
		if(currNode.get('className') == "excludeFromRowHighlighting"){
        	return;
        }
        if(_RowsHandler.onRenderingExtension != null){
			_RowsHandler.onRenderingExtension(currNode,currNodeIdx,allRows);
		}
        
        _yui.on("mouseover", _RowsHandler.onMouseOver, currNode);
    },
    
    onMouseOver : function(e) {
        // To control display of edit link during animations
        if (_RowsHandler.haltRowHighlighting) return;
        
		/*may be we can fix the way to get row id*/
		if(_RowsHandler.getRowID == null){
			newlyHoveredRowIndex = this.get('id');
		}else{
			newlyHoveredRowIndex = _RowsHandler.getRowID(this);
		}
        
        if(_RowsHandler.hoveredRowIndex == newlyHoveredRowIndex) return;
        
        if (_RowsHandler.hoveredRowIndex != null && _RowsHandler.hoveredRowIndex != newlyHoveredRowIndex) {
            _yui.one(document.getElementById(_RowsHandler.hoveredRowIndex)).replaceClass('onRowSelected' , '');
            // remove the edit overlay too.
            if (_RowsHandler.editOverlay != null && _RowsHandler.editOverlay.get('visible')) {
                _RowsHandler.editOverlay.hide();
            }
        }
        
        _RowsHandler.hoveredRowIndex = newlyHoveredRowIndex;
        
        if(_RowsHandler.isRowHighlightable != null && !_RowsHandler.isRowHighlightable(newlyHoveredRowIndex)){
			return;
		}
		
        //n id means project/assignment not selected
        
        
		linkLabel = _RowsHandler.getLinkLabel(newlyHoveredRowIndex);

	    /*
	    _RowsHandler.editOverlay.set("bodyContent", 
            '<div style="cursor:pointer;" onclick="_NotesHandler.displayNotes(\''+newlyHoveredRowIndex+'\');return false;"><span class="notesLinkSpan">'+linkLabel+'</span></div>');
        */
        
        if( _Config.hideEditDetailsHover == undefined || !_Config.hideEditDetailsHover || (_Config.hideEditDetailsHover && _Config.allowTaskTimeEntry )) {
 		_RowsHandler.editOverlay.set("bodyContent", 
        '<div style="cursor:pointer;" onclick="_NotesHandler.displayNotes(\''+newlyHoveredRowIndex+'\');return false;">' 
        +'<table cellpadding="0" cellspacing="0">'
		+'<tr style="vertical-align:top;">'
		+'<td><img src="/s.gif" class="notesLinkBGLeft"/></td>'
		+'<td id="notesLinkTD">'
		+'<span class="notesLinkSpan">'+linkLabel+'</span>'
		+'</td>'
		//+'<td><img src="/resource/1296898139000/jsComponentsResources/notesLinkBGRight.png"/></td>'
		+'<td><img src="/s.gif" class="notesLinkBGRight"/></td>'
		+'</tr>'
		+'</table>'
		+'</div>'
            );
		}
		

            
                   
        _RowsHandler.editOverlay.set("align", {node:this, 
                 points:[_yui.WidgetPositionAlign.TC, _yui.WidgetPositionAlign.BC]});
        
        this.addClass('onRowSelected');
        
        /*@TODO May be temp soulution*/
		this.set('style.backgroundPosition','0px '+(this.get('scrollHeight') - 3)+'px');
        
        // Overlay is already created in prepare overlay        
        _RowsHandler.editOverlay.show(); 
        
        if(_RowsHandler.onMouseOverExtension != null){
			_RowsHandler.onMouseOverExtension(newlyHoveredRowIndex);
			
        }
        
    }
	
}  
 
var _NotesHandler = {
	copyRowToNotes : null,
	copyNotesToRow : null,
	resetNotesRowdata : null,
	rowNo : null,
	
	setRowNumberToRetriveDataFromServer : null,
	
	displayNotesExtension : null,
	prepareNotesRowExtension : null,
	onNotesDetailOpenCompleteExtension: null,

    inlineNotesTemplate : null,
    currentNotesInEditingDirty : false,
    currentRowInEditing : null,
    rowToHide : null,
	isNextNotesLoadRequestInQueue : false,
	isNotesDataLoaded : false,
	hideNotesExtension : null,
    
    reset : function () { 
        _NotesHandler.currentNotesInEditingDirty = false;
        _NotesHandler.rowToHide = null;
        _NotesHandler.currentRowInEditing = null;
    },
    
    displayNotes : function (forRowId) {
        // disable mouse hover effect on row for a while
        _RowsHandler.haltRowHighlighting = true;
        
                
        _NotesHandler.rowToHide = null;
        
        // 1 Hide the Edit Overlay
        _RowsHandler.editOverlay.hide();  
        
        // Remove hoveredRowId, so that next mouse overs doesn't clears the style
        _RowsHandler.hoveredRowIndex = null;
        
        // 2 Remove the row in editing from the mouseover events(detach mouse over)
        _yui.detach("mouseover", _RowsHandler.onMouseOver, '#'+forRowId);
        
        // 3 Check if there was some row already in editing, if yes hideNotes(true, function()) 
        // . play hide animation for that, then call prepareNotesRow();
        // If there was a row previously in editing mark it as candidate to hide.
        prevRowInEditing = _NotesHandler.currentRowInEditing;
         _NotesHandler.currentRowInEditing = forRowId;
        if (prevRowInEditing != null && prevRowInEditing != forRowId) {
            _NotesHandler.rowToHide = prevRowInEditing;
            _NotesHandler.hideNotes(false); 
        } else {
            _NotesHandler.prepareNotesRow();
        }
		
		if(_NotesHandler.displayNotesExtension != null){
			_NotesHandler.displayNotesExtension(forRowId);
		}
        
    },
    onNotesDetailFetched : function () {
    	_NotesHandler.isNotesDataLoaded = true;
    	_NotesHandler.prepareNotesRow();
    },
    onNotesDetailSaveAction : function () {
    	_NotesHandler.isNotesDataLoaded = false;
    	_NotesHandler.isNotesDataUnsaved = false;
		_RowsHandler.haltRowHighlighting = true;
		jsSetNotesDetail();
    },
    onNotesDetailSaved : function () {
    	_RowsHandler.haltRowHighlighting = false;
		_NotesHandler.isNotesDataBeingFetched = false;
    	_NotesHandler.isNotesDataUnsaved = true;
    	if(_NotesHandler.isNextNotesLoadRequestInQueue){
    		_NotesHandler.prepareNotesRow();	
    	}else{

		/*reset if any other row is selected*/	
		highlightedRow = _yui.one('.onRowSelected');
		if(highlightedRow != null){
			highlightedRow.replaceClass('onRowSelected' , '');
		}
		if(_RowsHandler.editOverlay.get('visible'))  {
			_RowsHandler.editOverlay.hide();
		}
		}
    },
    
    
    prepareNotesRow : function () { 
        //get notes detail from the server
		if(_NotesHandler.getIsParentRowNew(_NotesHandler.currentRowInEditing)){
			
			//Added as a fix for Agile Task : AT14223
			//Due to dependent picklists on UI, value of child picklist of previous timecard row is being copied to new row. Now, due to this piece of code
			//values will not get copy. From now, for new rows also, waiting image (loading details message will spining image) will be displayed while adding 
			//opening notes detail section. Previously waiting image was shown only for saved timecard
			if(_NotesHandler.isNotesDataLoaded == null || !_NotesHandler.isNotesDataLoaded){
				_NotesHandler.isNotesDataLoaded = false;	
			}
			
			_NotesHandler.resetNotesRowdata();
		}
    	if(!_NotesHandler.isNotesDataLoaded){
    	
			// 1 Prepare the Notes editing row, by coping the stuff from hidden values.
			// 2 Play the show animation
			newRow = _yui.Node.create('<tr class="notesDivHolderTR"></tr>');
			newTd = _yui.Node.create('<td colspan="21" class="notesDivHolderTD"></td>');
			newBaseDiv = _yui.Node.create('<div id="notesCellFor'+_NotesHandler.currentRowInEditing+'" class="notesOuterDiv"></div>');
			
			newBaseDiv.append(_yui.Node.create('<div id="notesWaitingDiv" style="text-align:center"><img class="loadingImageStyle" height="32" width="32" src="/s.gif"/>'+_Label.loadingDetails+'</div>'));
			
			newTd.appendChild(newBaseDiv); 
			newRow.appendChild(newTd);
			
			currEditRowHandle = _yui.one(document.getElementById(_NotesHandler.currentRowInEditing));
			
			// Code to append a new row
			nextRow = currEditRowHandle.next();
			if (nextRow != null) {
				_yui.one('#editDetailRowParentTbody').insertBefore(newRow , nextRow);
			} else {
				_yui.one('#editDetailRowParentTbody').appendChild(newRow);
			} 
			
			var anim = new _yui.Anim({
				from: { height: 1 },
				node: newBaseDiv,
				to: {  height: function(node) { 
						return node.get('scrollHeight') + NOTES_DONE_BUTTON_BOTTOM_PADDING; 
					} },
				easing: _yui.Easing.easeIn,
				duration: 0.25
			});
			anim.run();
		    _NotesHandler.rowNo = _NotesHandler.currentRowInEditing;
			_NotesHandler.setRowNumberToRetriveDataFromServer(_NotesHandler.currentRowInEditing);
			var selectedRowBaseID = toRowBaseIdFromRowIndexUnEscaped(_NotesHandler.currentRowInEditing);
			if(_VFComponent.task_projOrAssig !=null){
				document.getElementById(_VFComponent.task_projOrAssig).value = document.getElementById(selectedRowBaseID + "projOrAssig").value;
				document.getElementById(_VFComponent.task_projectOrAssignmentId).value = document.getElementById(selectedRowBaseID + "projectOrAssignmentId").value;
				document.getElementById(_VFComponent.task_MilestoneId).value = document.getElementById(selectedRowBaseID + "hiddenMilestone").value;
			}
			jsGetNotesDetail();
	    	return;
    	}else{
    		notesWaitingDivNode = _yui.one(document.getElementById('notesWaitingDiv'));
			if(notesWaitingDivNode != null){
				notesWaitingDivNode.remove();
			}
    	}
    	
        // Cut paste  the notes container 
        notesContainerNode = _yui.one(document.getElementById('notesContainer'));
        notesContainerNode.all('.fakeSelectorClassForNotesInput').on('change', function(e) {_NotesHandler.currentNotesInEditingDirty = true; } );
        checkBoxFields = notesContainerNode.all('.fakeSelectorClassForNotesInputCheckBox');
        if(checkBoxFields != null){
        	checkBoxFields.on('change', function(e) {_NotesHandler.currentNotesInEditingDirty = true; } );
        }
        
        newBaseDiv.appendChild(notesContainerNode);

        
        var anim = new _yui.Anim({
            from: { height: 1 },
            node: newBaseDiv,
            to: {  height: function(node) { 
                    return node.get('scrollHeight') + NOTES_DONE_BUTTON_BOTTOM_PADDING; 
                } },
            easing: _yui.Easing.easeIn,
            duration: 0.25
        });
        anim.on('end', function (){
        	_RowsHandler.haltRowHighlighting = false;
        	_NotesHandler.onNotesDetailOpenComplete();
    	});
        anim.run();
		
		if(_NotesHandler.copyRowToNotes != null){
			_NotesHandler.copyRowToNotes(_NotesHandler.currentRowInEditing);
		}
		if(_NotesHandler.prepareNotesRowExtension != null){
			_NotesHandler.prepareNotesRowExtension(_NotesHandler.currentRowInEditing);
		}
    },
    
    onOK : function () {
        _NotesHandler.rowNo = _NotesHandler.currentRowInEditing;
        // On OK butn press the current editing row is the one to hide
        _NotesHandler.rowToHide = _NotesHandler.currentRowInEditing;
        
        // Added to implement toggle feature on notes icon on timecard
        if(_RowsHandler.onOkExtension != null){
			_RowsHandler.onOkExtension(_NotesHandler.currentRowInEditing);
        }
        // 2. Play Hide Animation
        _NotesHandler.hideNotes(true); 
        _NotesHandler.currentRowInEditing = null;
    }, 
    
    hideNotes : function (viaOKBtnClick) {
        
        _NotesHandler.isNextNotesLoadRequestInQueue = !viaOKBtnClick;
        
        // Reattach the mouse over event 
        _yui.on("mouseover", _RowsHandler.onMouseOver, '#'+_NotesHandler.rowToHide);
        
        // remove highlighting class
        _yui.one(document.getElementById(_NotesHandler.rowToHide)).replaceClass('onRowSelected' , '');
        
        saveNotesData = _NotesHandler.currentNotesInEditingDirty;
        if (!viaOKBtnClick && _NotesHandler.currentNotesInEditingDirty) {
            saveNotesData = confirm(_Label.unsavedNotesChanges);
        }
        
        if (saveNotesData && _NotesHandler.copyNotesToRow != null) {
            // function to copy data back to hidden
            _NotesHandler.copyNotesToRow(_NotesHandler.rowToHide);
        }
         
		_NotesHandler.isNotesDataUnsaved = saveNotesData;

        var anim = new _yui.Anim({
            node: _yui.one(document.getElementById('notesCellFor' + _NotesHandler.rowToHide)),
            from: { height: function(node) { 
                    return node.get('scrollHeight') + NOTES_DONE_BUTTON_BOTTOM_PADDING; 
                }},
            
            to: { height: 1 },
            easing: _yui.Easing.easeIn,
            duration: 0.2
        
         });

        //@TODO reset any view state if required
        anim.on('end', function (){
        				 _NotesHandler.onNotesDetailHide();
                    });
        
        
        anim.run();
        
		if(_NotesHandler.isNotesDataUnsaved && _NotesHandler.getIsParentRowNew(_NotesHandler.rowToHide)){
			_NotesHandler.setRowNumberToSaveDataToTheServer(_NotesHandler.rowToHide);
			_NotesHandler.setIsParentRowNew(_NotesHandler.rowToHide,'y');
		}
		else if(_NotesHandler.hideNotesExtension != null) { 
			_NotesHandler.hideNotesExtension(viaOKBtnClick);
		}
		
        _NotesHandler.currentNotesInEditingDirty = false;
        _NotesHandler.rowToHide = null;     
        
    },
    onNotesDetailHide : function (){
    	_yui.one('#notesContainerHolder').appendChild(_yui.one('#notesContainer'));
    	if(_NotesHandler.isNotesDataUnsaved){
    		_NotesHandler.onNotesDetailSaveAction();
    		return;
    	}
    	if(_NotesHandler.isNextNotesLoadRequestInQueue){
    		_NotesHandler.isNotesDataLoaded = false;
    		_NotesHandler.prepareNotesRow();
    	}else{
		/*Sometimes there may be other row which is highlighted 
		and the animation causes the edit overlay to detach from the highlighted row*/
			highlightedRow = _yui.one('.onRowSelected');
			if(highlightedRow != null){
				highlightedRow.replaceClass('onRowSelected' , '');
			}
			if(_RowsHandler.editOverlay.get('visible'))  {
				_RowsHandler.editOverlay.hide();
			}	
		}
    	_NotesHandler.isNotesDataLoaded = false;
		
    	
    },
	onNotesDetailOpenComplete : function (){
		if(_NotesHandler.onNotesDetailOpenCompleteExtension != null){
			_NotesHandler.onNotesDetailOpenCompleteExtension(_NotesHandler.currentRowInEditing);
		}
	},
	getIsParentRowNew : function(currentNotesparentRowID) {
		return (_yui.one('#'+currentNotesparentRowID).one('.fakeSelectorClassToDecideRowStatus').get('value') == 'n');
	},
	setIsParentRowNew : function(currentNotesparentRowID,rowStatus) {
		_yui.one('#'+currentNotesparentRowID).one('.fakeSelectorClassToDecideRowStatus').set('value',rowStatus);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////
//-------------------Row highlighting AND Notes section ends here----------------------//
/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////
//---------------------------Resource Lookup Handler STARTS----------------------------//
/////////////////////////////////////////////////////////////////////////////////////////
var _ResourceLookupHandler = {
    overlay : null,
    overlayContainer : null, 
    overlayEscKeyHandle : null,
    lastSearchString : null,
    onResourcesLoadExtension : null,
    config : {
    	toggleEditOverlay : true,
    	columnLabelManager : {
    		// commented as a fix for B-3466
    		//isLabelsLoaded : function(){ return _ResourceLookupHandler.config.columnLabelManager.columnLabels != null && _ResourceLookupHandler.config.columnLabelManager.columnLabels.length > 0 ;},
    		isLabelsLoaded : function(){ return false;},
    		columnLabels : new Array()	
    	}
    },
    prepare : function () {
        /* Create Overlay from script, this time. With no footer */
        _ResourceLookupHandler.overlay = new _yui.Overlay({
            contentBox : "#resourceOverlay", 
            width : "100%",
            zIndex:5
        });
        
        /* Center overlay in viewport */
        _ResourceLookupHandler.overlay.set("centered", true);
        _ResourceLookupHandler.overlay.render();
        _ResourceLookupHandler.overlay.show();
    
        _yui.on('key', function (e) { e.preventDefault(); _ResourceLookupHandler.search(true);}, '#delegatedResSearchString', 'down:13', _yui);
        
        _ResourceLookupHandler.overlayContainer = _yui.one('#resourceOverlayContainer'); 
    },
    
    attachEscKey : function ()
    {
       _ResourceLookupHandler.overlayEscKeyHandle = _yui.on('key', _ResourceLookupHandler.hide, document, 'down:27', _yui);
    },
    
    detachEscKey : function ()
    {
       _ResourceLookupHandler.overlayEscKeyHandle.detach();
    },
    
    show : function () {
		validateZIndexForOverlay(true);
		if(_ResourceLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        }
    	 //@TODO FIXME: This makes overlay open slow
        _ResourceLookupHandler.overlayContainer.setStyle('display', 'block');
        _ResourceLookupHandler.overlay.set("centered", true);
         stablizeOverlay(_ResourceLookupHandler.overlay);
        _ResourceLookupHandler.attachEscKey();
        /*Set focus to the search field.*/
        _yui.one('#delegatedResSearchString').focus();
    },
    
    hide : function() {
        _ResourceLookupHandler.overlayContainer.setStyle('display', 'none');
        _ResourceLookupHandler.detachEscKey();
		
		validateZIndexForOverlay(false);
        if(_ResourceLookupHandler.config.toggleEditOverlay){
        	toggleEditOverlayToPreventIE7Bug();
        }
    },
    
    search : function(listAll) {
        var searchString = listAll ? _yui.one('#delegatedResSearchString').get('value') : '';
        if(_ResourceLookupHandler.lastSearchString == searchString){return;}
        _ResourceLookupHandler.lastSearchString = searchString; 
        _yui.one("#resourceLoadWaitImageID").set('style.visibility', 'visible');
        var requestURL = _ajaxBrokerURL + encodeURI('?s=' + encodeURIComponent(searchString)) + '&core.apexpages.devmode.url=1&action=loadResources&loadLabels=' + ! _ResourceLookupHandler.config.columnLabelManager.isLabelsLoaded();
        _yui.io(requestURL, { method:"GET",on:{success:_ResourceLookupHandler.onResourcesLoad,failure:failureHandler } } );
   }, 
    
    onResourcesLoad : function(id, o) {
        /*The table string can be replaced by YUI node based dom*/
        var root = o.responseXML.documentElement;
        
        var resourceTags = root.getElementsByTagName('resource');
        
        /*Check if column labels are loaded for columns, If not then load them now*/
        if(!_ResourceLookupHandler.config.columnLabelManager.isLabelsLoaded()){
        	var mappingTag = root.getElementsByTagName('mapping');
        	
        	if(mappingTag.length > 0){ mappingTag = mappingTag[0];}
        	
        	var labelsTag = mappingTag.getElementsByTagName('label');
        	
        	if(labelsTag != null && labelsTag.length > 0){
	            _ResourceLookupHandler.config.columnLabelManager.columnLabels = new Array();
	            for(i= 0 ; i < labelsTag.length ; i++){
	                _ResourceLookupHandler.config.columnLabelManager.columnLabels.push(labelsTag[i].firstChild.nodeValue);
	            }
        	}
        }
        
        
        /*This is to decide columns width*/
        var totalColumns = _ResourceLookupHandler.config.columnLabelManager.columnLabels.length;
        var nameColumn_Width = 100/(totalColumns +1);
        var otherColumn_Width = nameColumn_Width;    
        
        
         
        var table = _yui.Node.create('<table width="100%" id="resourceResultsTable" cellspacing="0"></table>');
        
        var tbody = _yui.Node.create('<tbody></tbody>');
        var isDataFound = true;
        if(resourceTags != null && resourceTags.length > 0){
            for(i= 0 ; i < resourceTags.length ; i++){
                var rid = resourceTags[i].getElementsByTagName('id')[0].firstChild.nodeValue;
                var rname = resourceTags[i].getElementsByTagName('name')[0].firstChild.nodeValue;
        		
        		var tr = _yui.Node.create('<tr onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}"></tr>');
				var nameTd = _yui.Node.create('<td width="'+nameColumn_Width+'%"></td>');
                var resourceSelectLink = _yui.Node.create('<a href="#" onclick="doSelectResource(\''+rid +'\',\''+escape(rname)+'\');return false;" class="YUIFakeSelectorClassForResourceSelection"></a>');
                resourceSelectLink.set('innerHTML',rname);
                nameTd.appendChild(resourceSelectLink);
				
				tr.appendChild(nameTd);
				
				/*
				//adding new code by aditi
				var typeTags = resourceTags[i].getElementsByTagName('type');
				for(q = 0 ; q < typeTags.length ; q++){
					var fieldValue = typeTags[q].firstChild.nodeValue;
					alert(fieldValue);
				}
				*/
        		var fieldTags = resourceTags[i].getElementsByTagName('field');
        		for(j = 0 ; j < fieldTags.length ; j++){
        			var fieldValue = fieldTags[j].firstChild.nodeValue;
        			fieldValue = ( fieldValue == null || fieldValue == 'null' || isStringEmpty(fieldValue)) ? '--' : fieldValue;
        			var tdToAdd = _yui.Node.create('<td width="'+otherColumn_Width+'%">' + fieldValue + '</td>');
        			tr.appendChild(tdToAdd);		
        		}        
                
                tr.addClass('dataRow');
                tr.addClass(( i%2 == 0 ? 'even' : 'odd'));
                if(i == 0){tr.addClass(' first');}
                if(i == resourceTags.length-1){tr.addClass(' last');}
                tbody.appendChild(tr);
                    
            }
            var columnHeadLabels = new Array(_Label.name).concat(_ResourceLookupHandler.config.columnLabelManager.columnLabels);
            var thead = createThead(columnHeadLabels);
            table.appendChild(thead);
        }else{
        	var tr = _yui.Node.create('<tr onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}"></tr>');
			tr.appendChild(_yui.Node.create('<td> '+_Label.noResultsFound+' </td>'));
            
            // added new code as a fix for agile task 11222  Dated: 16 Feb  By: Aditi
            var tr2 = _yui.Node.create('<tr onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}"></tr>');
            var errorTag = root.getElementsByTagName('error');
            if (errorTag.length > 0 && errorTag[0].firstChild.nodeValue != null && errorTag[0].firstChild.nodeValue != '') {
            	tr2.appendChild(_yui.Node.create('<td> <font color=RED> ERROR : '+ errorTag[0].firstChild.nodeValue + ' </FONT></td>'));
            	tbody.appendChild(tr2);
            }
            tbody.appendChild(tr);
            isDataFound = false;
        }
        
        table.appendChild(tbody);
        table.addClass('list')
        _yui.all('#resourceResultsTable td').addClass('dataCell');
        
        _yui.one('#yuiRequestResultPanel').set("innerHTML", '');
        _yui.one('#yuiRequestResultPanel').appendChild(table);
        
        /*To sort the resources by name*/
        if(isDataFound){
            _TableSortHandler.sortTable(thead.all('th').item(0),0);
        }
        _yui.one("#resourceLoadWaitImageID").set('style.visibility', 'hidden');
        if(_ResourceLookupHandler.onResourcesLoadExtension != null){
			_ResourceLookupHandler.onResourcesLoadExtension(resourceTags);
		}
        
    } 
    
    
    
    
    
    /* Old resource load script 4 ref
    onResourcesLoad : function(id, o) {
        //This is to decide columns width
        var nameColumn_Width = _Config.displayAccountOnResourcePopup ? 28 : 32;
        var otherColumn_Width = _Config.displayAccountOnResourcePopup ? 18 : 22;    
        
        //The table string can be replaced by YUI node based dom
        var root = o.responseXML.documentElement;
        
        var resourceTags = root.getElementsByTagName('resource');
         
        var table = _yui.Node.create('<table width="100%" id="resourceResultsTable" cellspacing="0"></table>');
        
        var tbody = _yui.Node.create('<tbody></tbody>');
        var isDataFound = true;
        if(resourceTags.length > 0){
            for(i= 0 ; i < resourceTags.length ; i++){
                var rid = resourceTags[i].getElementsByTagName('id')[0].firstChild.nodeValue;
                var rname = resourceTags[i].getElementsByTagName('name')[0].firstChild.nodeValue; 
                var account = resourceTags[i].getElementsByTagName('account')[0].firstChild.nodeValue;
                var region = resourceTags[i].getElementsByTagName('region')[0].firstChild.nodeValue;
                var practice = resourceTags[i].getElementsByTagName('practice')[0].firstChild.nodeValue;
                var group = resourceTags[i].getElementsByTagName('group')[0].firstChild.nodeValue;
                
                var nameTd = _yui.Node.create('<td width="'+nameColumn_Width+'%"></td>');
                var resourceSelectLink = _yui.Node.create('<a href="#" onclick="doSelectResource(\''+rid +'\',\''+escape(rname)+'\');return false;" class="YUIFakeSelectorClassForResourceSelection"></a>');
                resourceSelectLink.set('innerHTML',rname);
                nameTd.appendChild(resourceSelectLink);
                
                var accountTd = _yui.Node.create('<td width="'+otherColumn_Width+'%">'+account+'</td>');
                var regionTd = _yui.Node.create('<td width="'+otherColumn_Width+'%">'+region+'</td>');
                var practiceTd = _yui.Node.create('<td width="'+otherColumn_Width+'%">'+practice+'</td>');
                var groupTd = _yui.Node.create('<td width="'+otherColumn_Width+'%">'+group+'</td>');
                
                var tr = _yui.Node.create('<tr onmouseout="if (window.hiOff){hiOff(this);}" onmouseover="if (window.hiOn){hiOn(this);}"></tr>');
                tr.appendChild(nameTd);
				
				if(_Config.displayAccountOnResourcePopup){
					tr.appendChild(accountTd);
				}
                
                tr.appendChild(regionTd);
                tr.appendChild(practiceTd);
                tr.appendChild(groupTd);
                
                tr.addClass('dataRow');
                tr.addClass(( i%2 == 0 ? 'even' : 'odd'));
                if(i == 0){tr.addClass(' first');}
                if(i == resourceTags.length-1){tr.addClass(' last');}
                tbody.appendChild(tr);
                    
            }
            var thead ;
            if(_Config.displayAccountOnResourcePopup){
            	thead = createThead(new Array(_Label.name, _Label.account, _Label.region, _Label.practice, _Label.group));
            }else{
            	thead = createThead(new Array(_Label.name, _Label.region, _Label.practice, _Label.group));
            }
            table.appendChild(thead);
        }else{
            var tr = _yui.Node.create('<tr></tr>');
            if(_Config.displayAccountOnResourcePopup){
            	tr.appendChild(_yui.Node.create('<td colspan="5"> '+_Label.noResultsFound+' </td>'));
            }else{
            	tr.appendChild(_yui.Node.create('<td colspan="4"> '+_Label.noResultsFound+' </td>'));
            }
            tbody.appendChild(tr);
            isDataFound = false;
        }
        
        table.appendChild(tbody);
        table.addClass('list')
        _yui.all('#resourceResultsTable td').addClass('dataCell');
        
        _yui.one('#yuiRequestResultPanel').set("innerHTML", '');
        _yui.one('#yuiRequestResultPanel').appendChild(table);
        
        //To sort the resources by name
        if(isDataFound){
            _TableSortHandler.sortTable(thead.all('th').item(0),0);
        }
        _yui.one("#resourceLoadWaitImageID").set('style.visibility', 'hidden');
        
    }, 
    
    */
    
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//-----------------------------_Resource Lookup Handler ENDS----------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------_Assignment/project Lookup Handler related methods STARTS------------------//
//////////////////////////////////////////////////////////////////////////////////////////////////
function toggleAssigResultTabs(triggerE) {
	var yuiTriggerNode = _yui.one(triggerE);
	if(yuiTriggerNode.get('id') == 'recentResultsLink'){
		if(!yuiTriggerNode.hasClass('selected')){
			yuiTriggerNode.addClass('selected');
			_yui.one('#searchResultsLink').removeClass('selected');
			
			_yui.one('#searchResultsTab').addClass('hide');
			_yui.one('#recentResultsTab').removeClass('hide');
		}
	}else if(yuiTriggerNode.get('id') == 'searchResultsLink'){
		yuiTriggerNode.addClass('selected');
		_yui.one('#recentResultsLink').removeClass('selected');
		
		_yui.one('#recentResultsTab').addClass('hide');
		_yui.one('#searchResultsTab').removeClass('hide');
	}     
 
}

//////////////////////////////////////////////////////////////////////////////////////////////////
/*------------------------------------Tooltip related JS code STARTS----------------------------*/
//////////////////////////////////////////////////////////////////////////////////////////////////
/*Must have a image with alt text define and image class name should be [infoImage]*/
var _TooltipHandler = {
	toolTipOverlay : null,
	
    onMouseOver : function (e)
    {	
    	if(this.hasClass('infoImageOff')){
    		this.replaceClass('infoImageOff','infoImageOn');
    	}
        _TooltipHandler.toolTipOverlay.set("bodyContent", this.get('alt'));
        _TooltipHandler.toolTipOverlay.set("align", {node:this, 
                 points:[_yui.WidgetPositionAlign.BL, _yui.WidgetPositionAlign.TR]});
        _TooltipHandler.toolTipOverlay.show();
        e.preventDefault();
    },
    onMouseOut : function (e)
    {
        if(this.hasClass('infoImageOn')){
    		this.replaceClass('infoImageOn','infoImageOff');
    	}
        _TooltipHandler.toolTipOverlay.hide();
        e.preventDefault();
    },

    prepare : function() {
    	_yui.one('body').append(_yui.Node.create('<div id="toolTipDiv" class="toolTipOverlay"></div>'));
        _TooltipHandler.toolTipOverlay = new _yui.Overlay({
	        contentBox:"#toolTipDiv",
	        visible:false
	    });
	    _TooltipHandler.toolTipOverlay.render();
    },
    bindTooltip : function() {
		_yui.on("mouseover", _TooltipHandler.onMouseOver, ".infoImage");
		_yui.on("mouseout", _TooltipHandler.onMouseOut, ".infoImage");
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////
/*----------Common methods[Sort table/create thead used in resource/assignment overlay]---------*/
//////////////////////////////////////////////////////////////////////////////////////////////////
//==================Methods to sort html table==========================//
var _TableSortHandler = {
    sortTable : function (thObj,columnToShort)
    {
        var thByWhichToSort = _yui.one(thObj);
        var tableToSort = thByWhichToSort.ancestor('thead').ancestor();
        
        isCurrentSortAsc = false;
        var sortedColumn = tableToSort.one('thead .sorted');
        if(sortedColumn != null){
            sortedColumn.set('className','');
            isCurrentSortAsc = (sortedColumn == thByWhichToSort ? (sortedColumn.one('img').get('className')) == 'sortAsc' : false);
            sortedColumn.one('img').remove();
        }
        _TableSortHandler.doSort(columnToShort, tableToSort, !isCurrentSortAsc);
        thByWhichToSort.set('className', 'sorted');
        if(isCurrentSortAsc){
            thByWhichToSort.append(_yui.Node.create('<img title="Sorted Descending" class="sortDesc" alt="Sorted Descending" src="/s.gif">'));//</img>
        }else{
            thByWhichToSort.append(_yui.Node.create('<img title="Sorted Ascending" class="sortAsc" alt="Sorted Ascending" src="/s.gif">'));//</img>
        }
    },
    
    doSort : function (columnToShort,tableToSort,isAssending)
    {
        var j = {"rows" : [ ]};
        var columnIndexToSort = columnToShort;
        var tbody = tableToSort.one('tbody');
        tbody.all('tr').each(function(currNode, currNodeIdx, allRows){
                                var allTDs = currNode.all('td');
                                if(allTDs != null){
                                    tdToWhichSortApply = allTDs.item(columnIndexToSort);
                                }
                                if(tdToWhichSortApply != null){
                                    j.rows.push({'index':currNodeIdx,'sortField':tdToWhichSortApply.get('text'), 'rowNode':currNode});
                                }
                            });
                            
        
        j.rows.sort(isAssending ? _TableSortHandler.compareAsc : _TableSortHandler.compareDesc);
        
        tbody.all('tr').remove();
        for(i = 0;i< j.rows.length ; i++ ){
            tbody.append(j.rows[i].rowNode);
        }
    },
    
    compareAsc : function (a, b)
    {
        if (a.sortField == b.sortField){
            return 0;
        }else if (a.sortField > b.sortField){ 
            return 1;
        }else
            return -1;
    },
    
    compareDesc : function(a, b)
    {
        if (a.sortField == b.sortField){
            return 0;
        } else if (a.sortField > b.sortField){ 
            return -1;
        } else
            return 1;
    }
    
        
}

function createThead(ths, sortedColumnIndex, headerRow){
    var thead = _yui.Node.create('<thead></thead>');
    if (headerRow != null)
    	thead.appendChild(headerRow);
    
    var tr = _yui.Node.create('<tr></tr>');
    tr.addClass('headerRow');
    for(i = 0; i<ths.length; i++){
        /*This means we need to show sort indicator */
        newTH = _yui.Node.create('<th onclick=\'_TableSortHandler.sortTable(this,'+i+')\'><a style="cursor:pointer;">'+ths[i]+'</a></th>');
        if(sortedColumnIndex != null && sortedColumnIndex == i){
        	newTH.addClass('sorted');
        	newTH.appendChild(_yui.Node.create('<img title="Sorted Ascending" class="sortAsc" alt="Sorted Ascending" src="/s.gif">'));/*</img>*/
        }
		tr.appendChild(newTH);
    }
    thead.appendChild(tr);
    return thead;
}
/////////////////////////////////////////////////////////////////////////////////////////
/*----------Common methods[Sort table used in resource/assignment overlay] ENDS--------*/
/////////////////////////////////////////////////////////////////////////////////////////


function validateZIndexForOverlay(prepareForOverlayOpen){
	
	if(!(_yui.UA.ie < 8.0 && _yui.UA.ie > 0))
            return;
	sidebarNode = _yui.one(document.getElementById('sidebarDiv'));
	if(prepareForOverlayOpen){
		if(sidebarNode != null){
			sidebarNode.set('style.zIndex','-1');
		}
	}else{
		if(sidebarNode != null){
			sidebarNode.set('style.zIndex','10');
		}
	}
}


/*Variable to keep track if we have hidden editoverlay to prevent it display over overlay in IE7*/
var _isEditOverlayHiddenByMe = false;
function toggleEditOverlayToPreventIE7Bug(){
    if(_RowsHandler.editOverlay.get('visible'))  {
        _RowsHandler.editOverlay.hide();
        _isEditOverlayHiddenByMe = true;
    }else{
        if(_isEditOverlayHiddenByMe && !_RowsHandler.editOverlay.get('visible')){
            _RowsHandler.editOverlay.show();
            _isEditOverlayHiddenByMe = false;
        }
    }
}





/////////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------UTILITY METHODS STARTS----------------------------------*/
/////////////////////////////////////////////////////////////////////////////////////////
function stablizeOverlay(overlayObj) {
    if(overlayObj.get('y') < 80) {
	   overlayObj.set('y', 80);
	}
}

/*Returns Float value for a text*/
function toFloat(valueToParse){
    var result = 0.0;
    if(isStringNotEmpty(valueToParse)){
  		v = valueToParse.replace(_DEC_SEP, ".");
      	result = isNaN(v) || v < 0 ? parseFloat('0.00') : parseFloat(v);
    }
    return result; 
}
 
/*Escapes the SFDC : seperated ids to make them usable with YUI*/
function sfdcToJSID(myid) {
   //Remove :
   var result = myid.replace(/:/g,"\\:")
   //remove .
   result = result.replace(/\./g,"\\.");
   return '#' + result; 
}
function isStringNotEmpty(sValue){
	return !isStringEmpty(sValue);
}
function isStringEmpty(sValue){
	if(sValue != null && sValue != undefined && sValue != "null" && sValue != "NULL"){
		sValue = String(sValue);
		sValue = sValue.replace(/^\s+|\s+$/, '');
		if(sValue.length > 0){
			return false;
		}
	}
	return true;
}

//Method is to use for string formating of custom labels having dyanamic arguments.
//Need to pass arguments in sequence of positions to replace.
String.prototype.format = function() {
   var content = this;
   for (var i=0; i < arguments.length; i++)
   {
        var replacement = '{' + i + '}';
        content = content.replace(replacement, arguments[i]);  
   }
   return content;
};

/////////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------UTILITY METHODS ENDS------------------------------------*/
/////////////////////////////////////////////////////////////////////////////////////////