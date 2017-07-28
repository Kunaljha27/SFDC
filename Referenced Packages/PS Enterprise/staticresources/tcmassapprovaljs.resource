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

 function selectAll(comp, matchingStr, rowMatchingPosfixStr, matchingPrimaryGrpStr, matchingSecondaryGrpStr)
 {
	 var isSelectAll = comp.checked;
	 var inputElem = document.getElementsByTagName("input");
	 for ( var i = 0; i < inputElem.length; i++) {
		if (inputElem[i].id.indexOf(matchingStr) != -1) {
			
			var primaryGrpId = null;
			var secondaryGrpId = null;
			var tcRecordId = null;
			if(matchingPrimaryGrpStr != null && inputElem[i].className.indexOf(matchingPrimaryGrpStr) != -1) {
				var idArray = getPrimaryGrpId(inputElem[i].className, matchingPrimaryGrpStr);
				primaryGrpId = idArray[0];
				tcRecordId = idArray[1];
				
			} else if(matchingSecondaryGrpStr != null && inputElem[i].className.indexOf(matchingSecondaryGrpStr) != -1) {
				var idArray = getPrimaryAndSecondaryGrpIds(inputElem[i].className, matchingSecondaryGrpStr);
				primaryGrpId = idArray[0];
				secondaryGrpId = idArray[1];
				tcRecordId = idArray[2];
				
			} else if(inputElem[i].className.indexOf('unGroupCompInfo') != -1) {
				tcRecordId = getTCRecordId(inputElem[i].className, 'unGroupCompInfo');
			}
			
			// Handling on actual TC rows. Not the header rows.
			if(inputElem[i].id.indexOf(rowMatchingPosfixStr) != -1) {
				if(inputElem[i].checked && !isSelectAll) {
					updateSelectedRecordCount('selectedTCRecordCount', false);
					updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, false);
				}
		 
				if(!inputElem[i].checked && isSelectAll) {
					updateSelectedRecordCount('selectedTCRecordCount', true);
					updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, true);
				}
			}
			inputElem[i].checked = isSelectAll;
		}
	 }     
 }
 
 function getTCRecordId(classNames, matchingClassNameStr) {
 	var classList = classNames.split(/\s+/);
 	var tcRecordId = null;
	for (var i = 0; i < classList.length; i++) {
		if (classList[i].indexOf(matchingClassNameStr) != -1) {
		 
		 	var matchingClassName = classList[i];
		 	// Record id split will be using "_" 
		 	var recordIdSplitStrIndex = matchingClassName.indexOf("_");
		 	tcRecordId = matchingClassName.substring(recordIdSplitStrIndex + 1); 
		}
	}
	return tcRecordId;
 }
 
 function getPrimaryGrpId(classNames, matchingClassNameStr) {
	var idArray = {};
	
	var classList = classNames.split(/\s+/);
	for (var i = 0; i < classList.length; i++) {
	   if (classList[i].indexOf(matchingClassNameStr) != -1) {
		 
		 var matchingClassName = classList[i];
		 // Primary id split will be using "_" 
		 var primaryIdSplitStrIndex = matchingClassName.indexOf("_");
		 
		 var tcRecordIdSplitStrIndex = matchingClassName.indexOf("-");
		 
		 var primaryGrpId = matchingClassName.substring(primaryIdSplitStrIndex + 1, tcRecordIdSplitStrIndex); 
		 var tcRecordId = matchingClassName.substring(tcRecordIdSplitStrIndex + 1); 	
		 
		 idArray[0] = primaryGrpId;
		 idArray[1] = tcRecordId;
	   }
	}
	return idArray;
 }
 
 function getPrimaryAndSecondaryGrpIds(classNames, matchingClassNameStr) {
	var idArray = {};
	
	var classList = classNames.split(/\s+/);
	for (var i = 0; i < classList.length; i++) {
	   if (classList[i].indexOf(matchingClassNameStr) != -1) {
		 
		 var matchingClassName = classList[i];
		 // Primary id split will be using "_" 
		 var primaryIdSplitStrIndex = matchingClassName.indexOf("_");
		 
		 // Secondary id split will be using "-" 
		 var secIdSplitStrIndex = matchingClassName.indexOf("-");
		 
		 var primaryGrpId = matchingClassName.substring(primaryIdSplitStrIndex + 1, secIdSplitStrIndex); 	
		 
		 // tc record id split will be using "-tc" 
		 var tcRecordIdSplitStrIndex = matchingClassName.indexOf("-tc");
		 
		 var secondaryGrpId = matchingClassName.substring(secIdSplitStrIndex + 1, tcRecordIdSplitStrIndex); 
		 
		 var tcRecordId = matchingClassName.substring(tcRecordIdSplitStrIndex + 3); 
		 
		 idArray[0] = primaryGrpId;
		 idArray[1] = secondaryGrpId;
		 idArray[2] = tcRecordId;
	   }
	}
	return idArray;
 }
 
 function selectAllGroup(comp, className, rowMatchingPosfixStr, selfGroupClassName, parentClassName, matchingPrimaryGrpStr, matchingSecondaryGrpStr)
 {
	 var isSelectAll = comp.checked;
	 var matchingElem = document.getElementsByClassName(className);
	 for ( var i = 0; i < matchingElem.length; i++) {
		
		var primaryGrpId = null;
		var secondaryGrpId = null;
		var tcRecordId = null;
		if(matchingPrimaryGrpStr != null && matchingElem[i].className.indexOf(matchingPrimaryGrpStr) != -1) {
			var idArray = getPrimaryGrpId(matchingElem[i].className, matchingPrimaryGrpStr);
			primaryGrpId = idArray[0];
			tcRecordId = idArray[1];
			
		} else if(matchingSecondaryGrpStr != null && matchingElem[i].className.indexOf(matchingSecondaryGrpStr) != -1) {
			var idArray = getPrimaryAndSecondaryGrpIds(matchingElem[i].className, matchingSecondaryGrpStr);
			primaryGrpId = idArray[0];
			secondaryGrpId = idArray[1];
			tcRecordId = idArray[2];
		}
		
		 // Handling on actual TC rows. Not the header rows.
		 if(matchingElem[i].id.indexOf(rowMatchingPosfixStr) != -1) {
			if(matchingElem[i].checked && !isSelectAll) {
				updateSelectedRecordCount('selectedTCRecordCount', false);
				updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, false);
			}
		 
			if(!matchingElem[i].checked && isSelectAll) { 
				updateSelectedRecordCount('selectedTCRecordCount', true);
				updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, true);
			}
		 }
		 matchingElem[i].checked = isSelectAll;
	 } 
   
	var allchecked = true;
	var allMatachingGrpElem = document.getElementsByClassName(selfGroupClassName);
	for ( var i = 0; i < allMatachingGrpElem.length; i++) 
	{
		if(!allMatachingGrpElem[i].checked) { 
			allchecked = false;
			break;
		}
	} 
	
	if(allchecked) {
		document.getElementsByClassName(parentClassName)[0].checked = true; 
	} else {
		document.getElementsByClassName(parentClassName)[0].checked = false;  
	}
	checkUncheckHeaderCheckBox(allchecked);     
 }
 
 function selectTimecard(comp, tcRecordId)
 {
	var allchecked = true;
	var lstindex = comp.id.lastIndexOf(':') + 1;
	var compID = comp.id.substring(lstindex, comp.id.length);
	var inputElem = document.getElementsByTagName("input");
	for ( var i = 0; i < inputElem.length; i++) 
	{
		if (inputElem[i].id.indexOf(compID) != -1)
		{
			if(!inputElem[i].checked)
				allchecked = false;
		}
   } 
   
   updateSelectedRecordCount('selectedTCRecordCount', comp.checked);
   updateSelectedRecordSummary(null, null, tcRecordId, comp.checked);
   
   if(allchecked)
	 document.getElementById('tcSelectAllCheckbox').checked = true; 
   else
	 document.getElementById('tcSelectAllCheckbox').checked = false;    
 }
 
 function selectPrimaryGrpByTimecard(comp, primaryGrpId, tcRecordId)
 {
	var allchecked = true;
	var className  = 'tcCheckbox'+ primaryGrpId;
	var matchingElem = document.getElementsByClassName(className);
	
	updateSelectedRecordCount('selectedTCRecordCount', comp.checked);
	updateSelectedRecordSummary(primaryGrpId, null, tcRecordId, comp.checked);
	
	for ( var i = 0; i < matchingElem.length; i++) 
	{
		if(!matchingElem[i].checked) {
		   allchecked = false;
		}
   } 
   
   if(allchecked) {
		document.getElementsByClassName('primaryGrp'+primaryGrpId)[0].checked = true; 
		checkUncheckHeaderCheckBox(allchecked);
		
   } else {
	 document.getElementsByClassName('primaryGrp'+primaryGrpId)[0].checked = false;
	 document.getElementById('tcSelectAllCheckbox').checked = false;
   }    
 }
 
  
 function selectSecondaryGrpByTimecard(comp, primaryGrpId, secondaryGrpId, tcRecordId)
 {
	var allchecked = true;
	var secClassName  = 'tcCheckbox'+ secondaryGrpId;
	var secMatchingElem = document.getElementsByClassName(secClassName);
	
	updateSelectedRecordCount('selectedTCRecordCount', comp.checked);
	updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, comp.checked);
	
	for ( var i = 0; i < secMatchingElem.length; i++) 
	{
		if(!secMatchingElem[i].checked) {
		   allchecked = false;
		}
   } 
   if(allchecked) {
		document.getElementsByClassName('secondaryGrp'+ secondaryGrpId)[0].checked = true; 
	 
		var priMatchingElem = document.getElementsByClassName('secondaryGrp'+ primaryGrpId);
		for ( var i = 0; i < priMatchingElem.length; i++) 
		{
			if(!priMatchingElem[i].checked)  allchecked = false;
		} 
		
		if(allchecked) {
			document.getElementsByClassName('primaryGrp'+primaryGrpId)[0].checked = true;
		}else {
			document.getElementsByClassName('primaryGrp'+primaryGrpId)[0].checked = false; 
		}
		checkUncheckHeaderCheckBox(allchecked);
	 
   } else {
	 document.getElementsByClassName('secondaryGrp'+secondaryGrpId)[0].checked = false;
	 document.getElementsByClassName('primaryGrp'+primaryGrpId)[0].checked = false;
	 document.getElementById('tcSelectAllCheckbox').checked = false;
   }
 }
 
 // Method to check uncheck header checkbox based on child checkboxes.
 function checkUncheckHeaderCheckBox(allchecked) {
	var priMatchingElem = document.getElementsByClassName('primaryGrp');
	for ( var i = 0; i < priMatchingElem.length; i++) 
	{
		if(!priMatchingElem[i].checked)  {
			allchecked = false;
			break;
		}
	} 
	
	if(allchecked) 
		document.getElementById('tcSelectAllCheckbox').checked = true; 
	else
		document.getElementById('tcSelectAllCheckbox').checked = false;
 }
 
 // Method to update the selected TC record count
 function updateSelectedRecordCount(selectedTCRecordCountClassName, incrementCount) {
	var val = document.getElementsByClassName(selectedTCRecordCountClassName)[0].innerHTML;
	var intNum = parseInt(val);
	
	if(isNaN(intNum)) intNum = 0;
	
	var newValue = intNum + 1;
	if(incrementCount == false) newValue = intNum - 1;
	
	document.getElementsByClassName(selectedTCRecordCountClassName)[0].innerHTML = newValue;
 }
 
 function updateSelectedRecordSummary(primaryGrpId, secondaryGrpId, tcRecordId, isChecked) {
	
	var updatePrimary = (primaryGrpId != null);
	var updateSecondary = (primaryGrpId != null && secondaryGrpId != null);
	
	if(updateSecondary) {
		var secGrpSelectedRecCountCN =  'secGrpCount'+ primaryGrpId +'_'+ secondaryGrpId;
		updateSelectedRecordCount(secGrpSelectedRecCountCN, isChecked);
		
		updateSecondarySelectedRecordsHours(primaryGrpId, secondaryGrpId, tcRecordId, isChecked);
		
		updateSecondarySelectedRecordsBillableAmount(primaryGrpId, secondaryGrpId, tcRecordId, isChecked);
	}
	
	if(updatePrimary) {
		var primaryGrpSelectedRecCountCN =  'primaryGrpCount'+ primaryGrpId;
		updateSelectedRecordCount(primaryGrpSelectedRecCountCN, isChecked);
		
		if(!updateSecondary) {
			updatePrimarySelectedRecordsHours(primaryGrpId, tcRecordId, isChecked);
			updatePrimarySelectedRecordsBillableAmount(primaryGrpId, tcRecordId, isChecked);
		}
	}
	
	var updateNonGroupedRecords = (!updatePrimary && !updateSecondary && tcRecordId != null);
	if(updateNonGroupedRecords) {
		updateUngroupedRecordSummary(tcRecordId, isChecked);
	}
 }
 
 function updateUngroupedRecordSummary(tcRecordId, isChecked) {
 	var unGrpSelectedRecHoursSrcCN = 'unGroupHoursTotalInfo_' + tcRecordId; 
	updateSelectedRecordValues(unGrpSelectedRecHoursSrcCN, 'selectedTCTotalHours', isChecked);
	
	var unGrpSelectedRecBillableSrcCN = 'unGroupBillableInfo_'+ tcRecordId;
	var isBillable = document.getElementsByClassName(unGrpSelectedRecBillableSrcCN)[0].value;
	
	// this to update count at approval section 
	var selectedBillableOrNonBillableCN = 'selectedTCBillableHours';
	if(isBillable === 'false') {
		selectedBillableOrNonBillableCN = 'selectedTCNonBillableHours';
	}
	updateSelectedRecordValues(unGrpSelectedRecHoursSrcCN, selectedBillableOrNonBillableCN, isChecked);
	
	if(isBillable === 'true') {
		var unGrpSelectedRecBillingAmtSrcCN = 'unGroupTotalBillingAmtInfo_' + tcRecordId;
		updateSelectedRecordValues(unGrpSelectedRecBillingAmtSrcCN, unGrpSelectedRecBillingAmtSrcCN, isChecked);
	}
 }
 
 // Updating primary selected hours
 function updatePrimarySelectedRecordsHours(primaryGrpId, tcRecordId, isChecked) {
 
	var priGrpSelectedRecHoursSrcCN = 'primaryHoursTotalInfo_'+ primaryGrpId +'_'+ tcRecordId;
		
	var priGrpSelectedRecBillableSrcCN = 'primaryBillableInfo_'+ primaryGrpId +'_'+ tcRecordId;
	var isBillable = document.getElementsByClassName(priGrpSelectedRecBillableSrcCN)[0].value;
	
	var primaryGrpSelectedRecHoursTargetCN =  'primaryBillableHrs'+ primaryGrpId;
	
	// this to update count at approval section 
	var selectedBillableOrNonBillableCN = 'selectedTCBillableHours';
	
	if(isBillable === 'false') {
		primaryGrpSelectedRecHoursTargetCN = 'primaryNonBillableHrs'+ primaryGrpId;
		selectedBillableOrNonBillableCN = 'selectedTCNonBillableHours';
	}
	
	//updateSelectedRecordValues(priGrpSelectedRecHoursSrcCN, secGrpSelectedRecHoursTargetCN, isChecked);
	updateSelectedRecordValues(priGrpSelectedRecHoursSrcCN, primaryGrpSelectedRecHoursTargetCN, isChecked);
	
	updateSelectedRecordValues(priGrpSelectedRecHoursSrcCN, 'selectedTCTotalHours', isChecked);
	updateSelectedRecordValues(priGrpSelectedRecHoursSrcCN, selectedBillableOrNonBillableCN, isChecked);
 }
 
 // Updating secondary selected hours
 function updateSecondarySelectedRecordsHours(primaryGrpId, secondaryGrpId, tcRecordId, isChecked) {
 
	var secGrpSelectedRecHoursSrcCN = 'secondaryHoursTotalInfo_'+ primaryGrpId +'_'+ secondaryGrpId +'_'+ tcRecordId;
		
	var secGrpSelectedRecBillableSrcCN = 'secondaryBillableInfo_'+ primaryGrpId +'_'+ secondaryGrpId +'_'+ tcRecordId;
	var isBillable = document.getElementsByClassName(secGrpSelectedRecBillableSrcCN)[0].value;
	
	var secGrpSelectedRecHoursTargetCN = 'secBillableHrs'+ primaryGrpId +'_'+ secondaryGrpId;
	var primaryGrpSelectedRecHoursTargetCN =  'primaryBillableHrs'+ primaryGrpId;
	
	// this to update count at approval section 
	var selectedBillableOrNonBillableCN = 'selectedTCBillableHours';
	
	if(isBillable === 'false') {
		secGrpSelectedRecHoursTargetCN = 'secNonBillableHrs'+ primaryGrpId +'_'+ secondaryGrpId;
		primaryGrpSelectedRecHoursTargetCN = 'primaryNonBillableHrs'+ primaryGrpId;
		selectedBillableOrNonBillableCN = 'selectedTCNonBillableHours';
	}
	
	updateSelectedRecordValues(secGrpSelectedRecHoursSrcCN, secGrpSelectedRecHoursTargetCN, isChecked);
	updateSelectedRecordValues(secGrpSelectedRecHoursSrcCN, primaryGrpSelectedRecHoursTargetCN, isChecked);
	
	updateSelectedRecordValues(secGrpSelectedRecHoursSrcCN, 'selectedTCTotalHours', isChecked);
	updateSelectedRecordValues(secGrpSelectedRecHoursSrcCN, selectedBillableOrNonBillableCN, isChecked);
 }
 
 // Updating Secondary record Billable Amount
 function updateSecondarySelectedRecordsBillableAmount(primaryGrpId, secondaryGrpId, tcRecordId, isChecked) {
 
	var secGrpSelectedRecBillingAmtSrcCN = 'secondaryTotalBillingAmtInfo_'+ primaryGrpId +'_'+ secondaryGrpId +'_'+ tcRecordId;
		
	var secGrpSelectedRecBillableSrcCN = 'secondaryBillableInfo_'+ primaryGrpId +'_'+ secondaryGrpId +'_'+ tcRecordId;
	var isBillable = document.getElementsByClassName(secGrpSelectedRecBillableSrcCN)[0].value;
	
	var secGrpSelectedRecBillingAmtTargetCN = 'secBillableAmt'+ primaryGrpId +'_'+ secondaryGrpId;
	var primaryGrpSelectedRecBillingAmtTargetCN =  'primaryBillableAmt'+ primaryGrpId;
	
	//  If non billable return from method as nothing to update.
	if(isBillable === 'false') return;
	
	updateSelectedRecordValues(secGrpSelectedRecBillingAmtSrcCN, secGrpSelectedRecBillingAmtTargetCN, isChecked);
	updateSelectedRecordValues(secGrpSelectedRecBillingAmtSrcCN, primaryGrpSelectedRecBillingAmtTargetCN, isChecked);
 }
 
 // Updating Primary record Billable Amount
 function updatePrimarySelectedRecordsBillableAmount(primaryGrpId, tcRecordId, isChecked) {
 
	var priGrpSelectedRecBillingAmtSrcCN = 'primaryTotalBillingAmtInfo_'+ primaryGrpId +'_'+ tcRecordId;
		
	var priGrpSelectedRecBillableSrcCN = 'primaryBillableInfo_'+ primaryGrpId +'_'+ tcRecordId;
	var isBillable = document.getElementsByClassName(priGrpSelectedRecBillableSrcCN)[0].value;
	
	var primaryGrpSelectedRecBillingAmtTargetCN =  'primaryBillableAmt'+ primaryGrpId;
	
	//  If non billable return from method as nothing to update.
	if(isBillable === 'false') return;
	
	updateSelectedRecordValues(priGrpSelectedRecBillingAmtSrcCN, primaryGrpSelectedRecBillingAmtTargetCN, isChecked);
 }
 
 function updateSelectedRecordValues(selectedTCRecordSrcClassName, selectedTCRecordTargetClassName, incrementCount) {
 
	var srcVal = document.getElementsByClassName(selectedTCRecordSrcClassName)[0].value;
	var floatSrcNum = parseFloat(srcVal);
	
	if(isNaN(floatSrcNum)) floatSrcNum = 0;
 
	var targetVal = document.getElementsByClassName(selectedTCRecordTargetClassName)[0].innerHTML;
	var floatTargetNum = parseFloat(targetVal);
	
	if(isNaN(floatTargetNum)) floatTargetNum = 0;
	
	var newValue = floatTargetNum + floatSrcNum;
	if(incrementCount == false) newValue = floatTargetNum - floatSrcNum;
	
	newValue = newValue.toFixed(2);
	
	document.getElementsByClassName(selectedTCRecordTargetClassName)[0].innerHTML = newValue;
 }
 
 function toggleClass(thisEl, elementId) { 
	var obj = document.getElementById(elementId);
	
	if(obj.className == "classShow") { 
		obj.className = "classHide"; 
		thisEl.className = "collapseImage"; 
	} else { 
		obj.className = "classShow"; 
		thisEl.className = "expandImage"; 
	} 
 }