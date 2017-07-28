var MAX_NOTES_CHAR_LEN = 255;

//Changes done as fix for agile task:000003571    By:Ashok   Dated:04/23/2010 
function checkNotesLength(e) {
	if (this.get('value').length > MAX_NOTES_CHAR_LEN) {
		alert(_Label.dailyNotesAlertMsg);
		this.set('value', this.get('value').substring(0, MAX_NOTES_CHAR_LEN));
		e.preventDefault();
		return false;
	}
	
	return true;
}


function isStringNotEmpty(sValue){
	return !isStringEmpty(sValue);
}
function isStringEmpty(sValue){
	if(sValue != null){
		sValue = sValue.replace(/^\s+|\s+$/, '');
		if(sValue.length > 0){
			return false;
		}
	}
	return true;
}
   
    function onScheduleWeekPicked(val){
        jsGotoSchWeek(val);
    }
    
    function onSchPreviousWeekClick() {
        jsSchPreviousWeek();
    }

    function onSchNextWeekClick() {
        jsSchNextWeek();
    }
    

function sfdcToJSID(myid) {
   return '#' + myid.replace(/:/g,"\\:"); 
}

//Commented as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 15 2010, Added By: Nitin Jain
//------------------------Commented Code Block------------------------
//var _DEC_SEP = '.';
//------------------------Commented Code Block------------------------
function toFloat(valueToParse){
    var result = 0.0;
    if(isStringNotEmpty(valueToParse)){
    		v = valueToParse.replace(_DEC_SEP, ".");
           	result = isNaN(v) || v < 0 ? parseFloat('0.00') : parseFloat(v);
    }
    return result; 
}

// Added as fix for agile task: 000011136    By: Ashok   Dated: 13 Sep, 2011
function onSchHrTextBlur(hrInputDomElement, dayType){
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
}

/***************Tooltip code***********************/
/*
* although is is copy of jsComponents's code, but the only difference is, it uses old YUI version.
* The old version use "WidgetPositionExt" for overlay positioning but new YUI version has changed it to WidgetPositionAlign, which causes some issues with SG ui
*/
var _SGTooltipHandler = {
	toolTipOverlay : null,
	
    onMouseOver : function (e)
    {	
    	if(this.hasClass('infoImageOff')){
    		this.replaceClass('infoImageOff','infoImageOn');
    	}
        _SGTooltipHandler.toolTipOverlay.set("bodyContent", this.get('alt'));
        _SGTooltipHandler.toolTipOverlay.set("align", {node:this, 
                 points:[_yui.WidgetPositionExt.BL, _yui.WidgetPositionExt.TR]});
        _SGTooltipHandler.toolTipOverlay.show();
        e.preventDefault();
    },
    onMouseOut : function (e)
    {
        if(this.hasClass('infoImageOn')){
    		this.replaceClass('infoImageOn','infoImageOff');
    	}
        _SGTooltipHandler.toolTipOverlay.hide();
        e.preventDefault();
    },

    prepare : function() {
    	_yui.one('body').append(_yui.Node.create('<div id="toolTipDiv" class="toolTipOverlay"></div>'));
        _SGTooltipHandler.toolTipOverlay = new _yui.Overlay({
	        contentBox:"#toolTipDiv",
	        visible:false
	    });
	    _SGTooltipHandler.toolTipOverlay.render();
    },
    bindTooltip : function() {
		_yui.on("mouseover", _SGTooltipHandler.onMouseOver, ".infoImage");
		_yui.on("mouseout", _SGTooltipHandler.onMouseOut, ".infoImage");
	}
}

/***************STARTS Assignment notes display stuff************************/
var _SGRowsHandler = {
    haltRowHighlighting : false,
    hoveredRowNode : null,
    editOverlay : null,
    reset : function() {
        _SGRowsHandler.haltRowHighlighting = false;
        _SGRowsHandler.hoveredRowNode = null;
    },
    
    prepare : function () {
	     _SGRowsHandler.editOverlay =  new _yui.Overlay({
	        contentBox:"#notesLinkDiv",
	        visible:false
	    }); 
	    _SGRowsHandler.editOverlay.render();
	    /*_yui.on('mouseover', function(e) {e.halt();}, '#assigNotesLinkDiv');*/
    },
    
    onRendering : function(currNode, currNodeIdx, allRows) {
        _yui.on("mouseover", _SGRowsHandler.onMouseOver, currNode);
    },
    
    onMouseOver : function(e) {
        // To control display of edit link during animations
        if (_SGRowsHandler.haltRowHighlighting) return;
		
		alreadyHoveredRowNode = _yui.one('#SGTbody .onSGRowHovered');
		alreadySelectedRowNode = _yui.one('#SGTbody .onSGRowSelected');
		
		if(alreadySelectedRowNode == this || alreadyHoveredRowNode == this){
			return;
		}
		if(alreadyHoveredRowNode != null){
			_SGRowsHandler.editOverlay.hide(); 
			alreadyHoveredRowNode.replaceClass('onSGRowHovered' , '');
		}
		this.addClass('onSGRowHovered');
		/*
		_SGRowsHandler.editOverlay.set("bodyContent", 
            '<div style="cursor:pointer;" onclick="_SGNotesHandler.displayNotes();return false;"><span class="assigNotesLinkSpan">'+_Label.editDetails+'</span></div>');
		*/
		
		
 		_SGRowsHandler.editOverlay.set("bodyContent", 
        '<div style="cursor:pointer;" onclick="_SGNotesHandler.displayNotes();return false;">' 
        +'<table cellpadding="0" cellspacing="0">'
		+'<tr style="vertical-align:top;">'
		+'<td><img src="/s.gif" class="notesLinkBGLeft"/></td>'
		+'<td id="notesLinkTD">'
		+'<span class="notesLinkSpan">'+_Label.editDetails+'</span>'
		+'</td>'
		+'<td><img src="/s.gif" class="notesLinkBGRight"/></td>'
		+'</tr>'
		+'</table>'
		+'</div>'
            );
		
		
		
		_SGRowsHandler.editOverlay.set("align", {node:this, 
                 points:[_yui.WidgetPositionExt.TC, _yui.WidgetPositionExt.BC]});//comehere
        _SGRowsHandler.editOverlay.show(); 
		_SGRowsHandler.hoveredRowNode = this;
        
    }
}  
 
var _SGNotesHandler = {
    currentNotesInEditingDirty : false,
    currentRowNodeInEditing : null,
    
    reset : function () { 
        _SGNotesHandler.currentNotesInEditingDirty = false;
        _SGNotesHandler.currentRowNodeInEditing = null;
    },
    
    displayNotes : function () {
        _SGRowsHandler.haltRowHighlighting = true;
		_SGRowsHandler.editOverlay.hide();  
		
		/*This means we have notes in display*/
		if(_SGNotesHandler.currentRowNodeInEditing != null){
			_SGNotesHandler.hideNotes(true);
		}else{
			_SGNotesHandler.currentRowNodeInEditing = _SGRowsHandler.hoveredRowNode;
			//Mark this row as current active row
			_SGNotesHandler.currentRowNodeInEditing.addClass('onSGRowSelected');
			nextRowNode = _SGNotesHandler.currentRowNodeInEditing.next();

			_SGNotesHandler.currentRowNodeInEditing.next().replaceClass('SGNotesRow','SGNotesRowExpended');
			
			notesContainer = nextRowNode.one('div');
			notesContainer.all('.fakeSelectorClassForSGNotesInput').on( 'change', function(e) {
								_SGNotesHandler.currentNotesInEditingDirty = true; } );
			
			var anim = new _yui.Anim({
				from: { height: 1 },
				node: notesContainer,
				to: {  height: function(node) { 
						return node.get('scrollHeight');
					} },
				easing: _yui.Easing.easeOut,
				duration: 0.5
			});
			anim.on('end', function (){_SGRowsHandler.haltRowHighlighting = false;});
			anim.run();
		}
        
    },

    hideNotes : function (showNotes) {
		_SGRowsHandler.haltRowHighlighting = true;
		/*Check if some row is hovered and we don't want to show notes after hiding this one*/
		if(!showNotes && _SGRowsHandler.hoveredRowNode != null){
			_SGRowsHandler.editOverlay.hide();
			_SGRowsHandler.hoveredRowNode.replaceClass('onSGRowHovered' , '');
		}
        var anim = new _yui.Anim({
            node: _SGNotesHandler.currentRowNodeInEditing.next().one('div'),
            from: { height: function(node) { 
                    return node.get('scrollHeight'); 
                }},
            
            to: { height: 1 },
            easing: _yui.Easing.easeIn,
            duration: 0.3
        
         });

        anim.on('end', function (){
						_SGNotesHandler.currentRowNodeInEditing.next().replaceClass('SGNotesRowExpended', 'SGNotesRow');	
						_SGNotesHandler.currentRowNodeInEditing.replaceClass('onSGRowSelected', '');	
						_SGNotesHandler.currentRowNodeInEditing = null;
						if (showNotes) {
							_SGNotesHandler.displayNotes();
						}
						else{
							_SGRowsHandler.haltRowHighlighting = false;
						}
						
                    });
        anim.run();
        
    }
}
/***************ENDS Assignment notes display stuff**************************/

/***************STARTS Row total stuff***************************************/
var _ColumnTotalHandler = {
	hrTextValueBeforeGotFocus : null,
   	prepare : function () {
		_yui.all(".schHrInputText").each(function(currNode, currNodeIdx, allRows){
								_yui.on("focus", _ColumnTotalHandler.onHrTextFocus, currNode);
								_yui.on("blur", _ColumnTotalHandler.onHrTextBlur, currNode);
							});
	
   	},
   	onHrTextFocus : function (e){
   		_ColumnTotalHandler.hrTextValueBeforeGotFocus = toFloat(this.get('value'));
   	},
	onHrTextBlur :function (e){
		newHrValue = toFloat(this.get('value'));
		this.set('value',((newHrValue.toFixed(2)).replace(".", _DEC_SEP)));
    	if(_ColumnTotalHandler.hrTextValueBeforeGotFocus == newHrValue){ 
    		return;
    	}
    	rowTDs = this.ancestor('tr').all('td');
	
		//Row total column
    	columnTotalColumn = _yui.all('#scheduleTable tfoot tr th').item(rowTDs.indexOf(this.ancestor()));
    	//Total column is the last in the row
    	rowTotalColumn = rowTDs.item(rowTDs.size()-1);
    	
    	//Modified as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 16 2010, Added By: Nitin Jain
    	//------------------------Modified Code Block------------------------
   		//rowTotal = toFloat(rowTotalColumn.get('children').item(0).get('innerHTML'));
   		rowTotal = toFloat(rowTotalColumn.get('children').item(0).one('span').get('innerHTML'));
   		//------------------------Modified Code Block------------------------
   		
    	columnTotal = toFloat(columnTotalColumn.get('text'));
    
  	  	rowTotal = rowTotal + (newHrValue - _ColumnTotalHandler.hrTextValueBeforeGotFocus);
  	  	rowTotalToDisplay = (rowTotal.toFixed(2)).replace(".", _DEC_SEP);
    
    	columnTotal = columnTotal + (newHrValue - _ColumnTotalHandler.hrTextValueBeforeGotFocus);
    	columnTotalToDisplay = (columnTotal.toFixed(2)).replace(".", _DEC_SEP);
    	
    	//Modified as fix for agile task: 000010865 (Ref. Task ID: 000009297), Dated: Dec 16 2010, Added By: Nitin Jain
    	//------------------------Modified Code Block------------------------
    	//rowTotalColumn.get('children').item(0).set('innerHTML', +rowTotalToDisplay);
    	rowTotalColumn.get('children').item(0).one('span').set('innerHTML', rowTotalToDisplay);
    	//------------------------Modified Code Block------------------------
    	columnTotalColumn.set('text', columnTotalToDisplay);
    
	}
}
/***************ENDS Row total stuff***************************************/


// Added as fix for Agile task: AT1612 	    Dated: 31 May, 2012 
function selectAllAssignmentSchedule(checkBoxObj, checkBoxIdPattern) {
	var isChecked = checkBoxObj.checked;
	var selectedAssigIdStr = '';
	var inputElem = document.getElementsByTagName("input");
	for ( var i = 0; i < inputElem.length; i++) {
		if (inputElem[i].id.indexOf(checkBoxIdPattern) != -1) {
			inputElem[i].checked = isChecked;
		}
	}
	if(isChecked) {
		selectedAssigIdStr = 'ALL'; // All schedule assignments are selected for "copy from selected schedule" action.
	}
	document.getElementById('selectedAssignmentIDs').value = selectedAssigIdStr;
}

function checkIsAllSelected(checkBoxId) {
	var isAllChecked = true;
	
	var inputElem = document.getElementsByTagName("input");
	var selectedAssigIdStr = '';
	for ( var i = 0; i < inputElem.length; i++) {
		if (inputElem[i].id.indexOf(checkBoxId) != -1) {
			var assgnmntId = inputElem[i].value;
			
			if (inputElem[i].checked) {
				if(selectedAssigIdStr == ''){
					selectedAssigIdStr = ''+assgnmntId;
				} else {
					selectedAssigIdStr = selectedAssigIdStr + ',' + assgnmntId;
				}
			} else {
				isAllChecked = false;
			}
		}
	}
	document.getElementById('selectAllAssignSchCheckbox').checked = isAllChecked;
	document.getElementById('selectedAssignmentIDs').value = selectedAssigIdStr;
}



function resizeIframe() { 
	var scheduleFrame = parent.document.getElementById('scheduleFrame'); 
	if (scheduleFrame) { 
		var height = document.body.scrollHeight; 
		// Added 300 px to avoid scrollbars during inline notes editing
		scheduleFrame.style.height = (height + 300) + "px"; 
	} 
}

/*********************Methods to be called on various events by YUI*********************************/
function bindAll() {
	_SGRowsHandler.editOverlay.hide();
	_SGNotesHandler.reset();
	_yui.all("#SGTbody .fakeSelectorClassForSGRow").each(_SGRowsHandler.onRendering);
	_yui.on("keypress", checkNotesLength, ".assigDailyNotesTextArea"); 
	_ColumnTotalHandler.prepare();
	if(_Config.showScheduleTooltips){
		_SGTooltipHandler.bindTooltip();
	}
}

function onGotoSchWeekDone(){
	bindAll();
	resizeIframe(); 
}  

function onSchPreviousWeekDone(){
	bindAll();
	resizeIframe();
}

function onNextWeekDone(){
	bindAll();
	resizeIframe();
}

function onSaveDone(){
	bindAll();
} 

  
