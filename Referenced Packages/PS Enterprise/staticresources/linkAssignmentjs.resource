var _hasUnsavedChanges ;

	/*
	* although is is copy of jsComponents's code, but the only difference is, it uses old YUI version.
	* The old version use "WidgetPositionExt" for overlay positioning but new YUI version has changed it to WidgetPositionAlign, which causes some issues with SG ui
	*/
	var _TooltipHandler = {
		toolTipOverlay : null,
		
	    onMouseOver : function (e)
	    {	
	    	if(this.hasClass('infoImageOff')){
	    		this.replaceClass('infoImageOff','infoImageOn');
	    	}
	        _TooltipHandler.toolTipOverlay.set("bodyContent", this.get('alt'));
	        _TooltipHandler.toolTipOverlay.set("align", {node:this, 
	                 points:[_yui.WidgetPositionExt.BL, _yui.WidgetPositionExt.TR]});
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
	
	/*Added as a fix for AT11088*/
	/*Show conformation box when any row is dirty and Done button is clicked*/
	var _confirmBoxHandler = {	
		confirmBoxOverlay : null,
		confirmBoxOverlayContainer : null,
		
	    prepare : function () {
	        _confirmBoxHandler.confirmBoxOverlay = _yui.one('#confirmBoxOverlay'); 
	        _confirmBoxHandler.confirmBoxOverlayContainer = _yui.one('#confirmBoxOverlayContainer'); 
	    },
	    
	    show : function () {
	    	_confirmBoxHandler.confirmBoxOverlayContainer.setStyle('display', 'block');
	    },
	    
	    hide : function () {
	    	_confirmBoxHandler.confirmBoxOverlayContainer.setStyle('display', 'none');
	    },
	}

	function selectAll(comp, matchingStr)
	{
	     var isSelectAll = comp.checked;
	     var inputElem = document.getElementsByTagName("input");
	     var totalCheckboxCount = 0;
	     for ( var i = 0; i < inputElem.length; i++) {
	        if (inputElem[i].id.indexOf(matchingStr) != -1) {
	            inputElem[i].checked = isSelectAll;
	            totalCheckboxCount += 1;
	         }
	     }
	     
	    var countInfo = '';
	    if(isSelectAll) { 
		    countInfo = _Label.selectedRecordCount.format(totalCheckboxCount, totalCheckboxCount);
		} else {
			countInfo = _Label.selectedRecordCount.format(0, totalCheckboxCount);
		}
		document.getElementById(_Component.recordCountInfo).innerHTML = countInfo;	  
	}
	 
	function selectItem(comp, selectAllCheckboxStr)
	{
	    var allchecked = true;
	    var lstindex = comp.id.lastIndexOf(':') + 1;
	    var compID = comp.id.substring(lstindex, comp.id.length);
	    var inputElem = document.getElementsByTagName("input");
	    
	    var checkedCount = 0; 
	    var totalCheckboxCount = 0; 
	    for ( var i = 0; i < inputElem.length; i++) 
	    {
	        if (inputElem[i].id.indexOf(compID) != -1)
	        {	
	        	totalCheckboxCount += 1;
	            if(inputElem[i].checked) {
	            	checkedCount += 1;
	            } else {
	            	allchecked = false;
	            }
	        }
	   } 
	   if(allchecked)
	     document.getElementById(selectAllCheckboxStr).checked = true; 
	   else
	     document.getElementById(selectAllCheckboxStr).checked = false;    
	   
	   var countInfo = _Label.selectedRecordCount.format(checkedCount, totalCheckboxCount);
	   document.getElementById(_Component.recordCountInfo).innerHTML = countInfo;	     
	}
	
	String.prototype.format = function() {
	   var content = this;
	   for (var i=0; i < arguments.length; i++)
	   {
	        var replacement = '{' + i + '}';
	        content = content.replace(replacement, arguments[i]);  
	   }
	   return content;
	};
	 
	function setDirty(dirtyId){           
	    _hasUnsavedChanges = true;
	    document.getElementById(dirtyId).value = "true";
	}
	
	function onDoneClick(){
		if(!_hasUnsavedChanges){
			jsdoCancel();
			return false;	
		}		
		_confirmBoxHandler.show();
	}
	
	function onSaveClick(){
		if(!_hasUnsavedChanges){
			alert(_Label.noUnsavedChanges);
			return false;
		}
		jsdoSave();
	}
	
	function onResetClick(){
		jsdoReset();
	}
	
	function updateAnchorTargetAttribute() {
		_hasUnsavedChanges = false;
		// This is to set the anchor tag target as _blank to open in new tab.
		var parentDiv = document.getElementById(_Component.recordResultPBT); 
		var inputElem = parentDiv.getElementsByTagName("a"); 
	    for ( var i = 0; i < inputElem.length; i++) {
	        inputElem[i].target = '_blank';
	        inputElem[i].onmouseover = '';
	    } 
	}
	
	function bindConfirmOverlay(){
		_confirmBoxHandler.prepare();
	}	