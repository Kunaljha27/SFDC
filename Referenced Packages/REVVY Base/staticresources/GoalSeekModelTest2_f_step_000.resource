{
    "sendDiff": false,
    "reqHasDiffModel": false,
    "step": {
        "extb": {},
        "tieredPricing": {},
        "compVersion": 4,
        "dbId": "a0C1a000000VM6REAW",
        "errors": {
            "values": []
        },
        "exprs": null,
        "groups": {
            "Sid_OG_101": {
                "_availability": {
                    "availableOptions": {
                        "d4a27e6e-ce70-4d4b-846d-f22a2afe243b": true
                    },
                    "availableCount": 1
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000WjMXEA0",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid OG 101",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "1.1",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "1.1",
                        "adj1": null,
                        "costPrice": null,
                        "dbId": "a091a000000UxT1AAK",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": null,
                        "isSystemUnitPrice": null,
                        "label": "1.1",
                        "listPrice": null,
                        "manAdj": null,
                        "name": "1.1",
                        "qty": 1,
                        "_uid": "d4a27e6e-ce70-4d4b-846d-f22a2afe243b",
                        "unitPrice": null,
                        "_userSelected": false
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_OG_101",
                "uitype": "dropdown"
            },
            "sidSolutionOG1": {
                "_availability": {
                    "availableOptions": {
                        "400043cf-52bf-4498-b11a-6ca2aacad92f": true,
                        "046c5bca-78ca-4f98-9d3c-d647d85bd510": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {
                        "400043cf-52bf-4498-b11a-6ca2aacad92f": true
                    },
                    "selectedCount": 1,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000grItEAI",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "sidSolutionOG1",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "RJ_Size001": 10,
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [
                            "Compute Options",
                            "Node Hardware",
                            "OpenStack",
                            "RJ_Category_Yearly",
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Yearly",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxWDAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": false,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": false,
                        "label": "Test_Prod",
                        "listPrice": 475,
                        "manAdj": null,
                        "name": "Test_Prod",
                        "qty": 1,
                        "_uid": "400043cf-52bf-4498-b11a-6ca2aacad92f",
                        "unitPrice": 100,
                        "_userSelected": true,
                        "dpa": true,
                        "parentId": "sidSolutionOG1",
                        "CurrencyIsoCode": "USD",
                        "uiType": "dropdown",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": false,
                        "defaultQty": 1
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "RJ_Monthly_ConditionProduct_002_ID",
                        "path": [
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Monthly",
                        "_idNodeRef": "RJ_Monthly_ConditionProduct_002_ID",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxWCAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Yearly_ConditionProduct_002_Name",
                        "listPrice": 75,
                        "manAdj": null,
                        "name": "RJ_Monthly_ConditionProduct_002_Name",
                        "qty": 1,
                        "_uid": "046c5bca-78ca-4f98-9d3c-d647d85bd510",
                        "unitPrice": 75,
                        "_userSelected": false,
                        "dpa": true,
                        "parentId": "sidSolutionOG1",
                        "CurrencyIsoCode": "USD",
                        "uiType": "dropdown",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": false,
                        "defaultQty": 1
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "sidSolutionOG1",
                "uitype": "dropdown"
            },
            "Sid_OG_102": {
                "_availability": {
                    "availableOptions": {
                        "product_0": true
                    },
                    "availableCount": 1
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000WjMcEAK",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": "Router",
                "label": "Sid OG 102",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "label",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "_uid": "product_0",
                        "attributes": {},
                        "dbId": "a091a000000Uxg5AAC",
                        "idNode": "Router1",
                        "label": "Router1",
                        "path": [
                            "Router"
                        ],
                        "priceFreq": "One Time",
                        "qty": 1,
                        "listPrice": 1000,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 1000,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "category",
                "uea": null,
                "_uid": "Sid_OG_102",
                "uitype": "dropdown"
            },
            "Solution_OG_for_SDR": {
                "_availability": {
                    "availableOptions": {
                        "product_0": true,
                        "product_1": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000g2C3EAI",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": "SidSDRCatagory",
                "label": "Solution OG for SDR",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "label",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "_uid": "product_0",
                        "attributes": {},
                        "dbId": "a091a000000UxWCAA0",
                        "idNode": "RJ_Monthly_ConditionProduct_002_ID",
                        "label": "RJ_Yearly_ConditionProduct_002_Name",
                        "path": [
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Monthly",
                        "qty": 1,
                        "listPrice": 75,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 75,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "RJ_Size001": 10,
                        "_uid": "product_1",
                        "attributes": {},
                        "dbId": "a091a000000UxWDAA0",
                        "idNode": "Test_Prod",
                        "label": "Test_Prod",
                        "path": [
                            "Compute Options",
                            "Node Hardware",
                            "OpenStack",
                            "RJ_Category_Yearly",
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Yearly",
                        "qty": 1,
                        "listPrice": 475,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 100,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "category",
                "uea": null,
                "_uid": "Solution_OG_for_SDR",
                "uitype": "dropdown"
            }
        },
        "name": "Solution Model 10",
        "objs": {
            "Account": {
                "AnnualRevenue": 350000000,
                "NumberOfEmployees": 9000,
                "Id": "0011a000002JZ0BAAW",
                "sah__SLA__c": "Silver",
                "Rating": "Warm",
                "Type": "Customer - Direct",
                "Ownership": "Public",
                "Industry": "Apparel",
                "attributes": {
                    "type": "Account",
                    "url": "/services/data/v35.0/sobjects/Account/0011a000002JZ0BAAW"
                },
                "_uid": "Account"
            },
            "Opportunity": {
                "_uid": "Opportunity"
            },
            "MnQuote__c": {
                "sah__Monthly_Value_Before_Discount_S__c": 0,
                "sah__Monthly_Margin_F__c": 0,
                "sah__NeedApprovalCount__c": 0,
                "sah__Yearly_Adjustment1_Absolute_F__c": 475,
                "sah__One_Time_Adjustment1_Absolute_F__c": 0,
                "sah__MonthlyInterestRate__c": 0.003,
                "sah__Yearly_Unit_Price_S__c": 475,
                "sah__Yearly_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Segment__c": "General",
                "sah__Weekly_Adjustment1_Absolute_F__c": 0,
                "sah__Adjustment__c": 0,
                "sah__WeeklyTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__Weekly_Adjustment1_F__c": 0,
                "sah__Term__c": 12,
                "sah__OneTimeTotalAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Adjustment1_F__c": 0,
                "RecordTypeId": "0121a000000PGJdAAO",
                "sah__One_Time_Value_Before_Discount_S__c": 0,
                "sah__WeeklyTotalAdjustmentDisplay_F__c": 0,
                "sah__Following_Years_Value_F__c": 475,
                "sah__Quote_Value_Display_F__c": 475,
                "sah__Monthly_Adjustment1_F__c": 0,
                "sah__One_Time_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Weekly_Unit_Price_S__c": 0,
                "sah__TotalTargetPrice__c": 0,
                "sah__Yearly_Margin_F__c": 0,
                "sah__Yearly_Margin_Absolute_F__c": 0,
                "sah__OneTimeTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Line_Discount_Absolute__c": 0,
                "sah__Monthly_Line_Discount__c": 0,
                "sah__Weekly_Margin_F__c": 0,
                "sah__Weekly_Total_Value_S__c": 0,
                "sah__QuoteItemsNeedApprovalCount__c": 0,
                "sah__ExtId__c": 170,
                "sah__One_Time_Margin_Absolute_F__c": 0,
                "sah__GPTerm__c": 5,
                "sah__Monthly_Cost_Price_Before_Adjustment_S__c": 0,
                "Id": "a0i1a000000wfGQAAY",
                "sah__YearlyTotalAfterAdjustmentDisplay_F__c": 475,
                "sah__MonthlyTotalAdjustmentDisplay_F__c": 0,
                "sah__Weekly_Line_Discount__c": 0,
                "sah__InstallationCostViolation__c": 0,
                "sah__Monthly_Total_Value_S__c": 0,
                "sah__Overall_Discount__c": 0,
                "sah__Monthly_Margin_Absolute_F__c": 0,
                "sah__Yearly_Line_Discount_Absolute__c": 0,
                "sah__One_Time_Line_Discount__c": 0,
                "sah__ProposalSignStatus__c": "Not Signed",
                "sah__OneTimeTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Status__c": "Draft",
                "sah__One_Time_Margin_F__c": 0,
                "sah__Weekly_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Yearly_Line_Discount__c": 0,
                "sah__Yearly_Total_Value_S__c": 475,
                "sah__YearlyTotalAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Total_Value_S__c": 0,
                "sah__Monthly_Adjustment1_Absolute_F__c": 0,
                "sah__TermYear__c": "1",
                "sah__WeeklyTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Yearly_Value_Before_Discount_S__c": 475,
                "sah__Weekly_Margin_Absolute_F__c": 0,
                "sah__YearlyTotalBeforeAdjustmentDisplay_F__c": 475,
                "sah__Yearly_Adjustment1_F__c": 0,
                "sah__One_Time_Unit_Price_S__c": 0,
                "sah__MonthlyTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Monthly_Line_Discount_Absolute__c": 0,
                "sah__Monthly_Unit_Price_S__c": 0,
                "sah__Total_List_Price__c": 475,
                "sah__Quote_Value__c": 475,
                "sah__MonthlyTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__SapPartnerCountry__c": "US",
                "sah__Currency__c": "USD",
                "sah__Weekly_Value_Before_Discount_S__c": 0,
                "sah__QuoteItemSubLinesNeedApprovalCount__c": 0,
                "sah__Weekly_Line_Discount_Absolute__c": 0,
                "attributes": {
                    "type": "sah__MnQuote__c",
                    "url": "/services/data/v35.0/sobjects/sah__MnQuote__c/a0i1a000000wfGQAAY"
                },
                "_uid": "MnQuote__c"
            },
            "MnQuoteItem__c": {
                "_uid": "MnQuoteItem__c"
            }
        },
        "perf": {
            "totCompTime": 108,
            "evalTime": 1,
            "compileTime": 19,
            "totEvalTime": 4
        },
        "result": {
            "nonqts": {
                "Solution_OG_for_SDR": {},
                "Sid_OG_102": {},
                "sidSolutionOG1": {},
                "Sid_OG_101": {}
            },
            "quotes": {
                "Solution_OG_for_SDR": {},
                "Sid_OG_102": {},
                "sidSolutionOG1": {
                    "400043cf-52bf-4498-b11a-6ca2aacad92f": true
                },
                "Sid_OG_101": {}
            }
        },
        "rules": [],
        "UI": {
            "dbId": "a0J1a000000WnTUEA0",
            "layout": {
                "sections": [
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000000XPXhEAO",
                        "groups": [
                            "sidSolutionOG1"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_fak0v"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000000XPe7EAG",
                        "groups": [
                            "Sid_OG_101",
                            "Sid_OG_102",
                            "Solution_OG_for_SDR"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_6pq48"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000003afXMEAY",
                        "groups": [],
                        "name": "New Section",
                        "uid": "OG_99ysy"
                    }
                ]
            },
            "name": "Layout For a0C1a000000VM6REAW",
            "uid": "a0C1a000000VM6REAW_Layout_20150528_143601",
            "version": 1
        },
        "uid": "Model_sybgl",
        "version": 23
    },
    "result": {
        "extb": {},
        "tieredPricing": {},
        "compVersion": 4,
        "dbId": "a0C1a000000VM6REAW",
        "errors": {
            "values": []
        },
        "exprs": null,
        "groups": {
            "Sid_OG_101": {
                "_availability": {
                    "availableOptions": {
                        "d4a27e6e-ce70-4d4b-846d-f22a2afe243b": true
                    },
                    "availableCount": 1
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000WjMXEA0",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid OG 101",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "1.1",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "1.1",
                        "adj1": null,
                        "costPrice": null,
                        "dbId": "a091a000000UxT1AAK",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": null,
                        "isSystemUnitPrice": null,
                        "label": "1.1",
                        "listPrice": null,
                        "manAdj": null,
                        "name": "1.1",
                        "qty": 1,
                        "_uid": "d4a27e6e-ce70-4d4b-846d-f22a2afe243b",
                        "unitPrice": null,
                        "_userSelected": false
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_OG_101",
                "uitype": "dropdown"
            },
            "sidSolutionOG1": {
                "_availability": {
                    "availableOptions": {
                        "400043cf-52bf-4498-b11a-6ca2aacad92f": true,
                        "046c5bca-78ca-4f98-9d3c-d647d85bd510": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {
                        "400043cf-52bf-4498-b11a-6ca2aacad92f": true
                    },
                    "selectedCount": 1,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000grItEAI",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "sidSolutionOG1",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "RJ_Size001": 10,
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [
                            "Compute Options",
                            "Node Hardware",
                            "OpenStack",
                            "RJ_Category_Yearly",
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Yearly",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxWDAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": false,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": false,
                        "label": "Test_Prod",
                        "listPrice": 475,
                        "manAdj": null,
                        "name": "Test_Prod",
                        "qty": 1,
                        "_uid": "400043cf-52bf-4498-b11a-6ca2aacad92f",
                        "unitPrice": 100,
                        "_userSelected": true,
                        "dpa": true,
                        "parentId": "sidSolutionOG1",
                        "CurrencyIsoCode": "USD",
                        "uiType": "dropdown",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": false,
                        "defaultQty": 1
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "RJ_Monthly_ConditionProduct_002_ID",
                        "path": [
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Monthly",
                        "_idNodeRef": "RJ_Monthly_ConditionProduct_002_ID",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxWCAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Yearly_ConditionProduct_002_Name",
                        "listPrice": 75,
                        "manAdj": null,
                        "name": "RJ_Monthly_ConditionProduct_002_Name",
                        "qty": 1,
                        "_uid": "046c5bca-78ca-4f98-9d3c-d647d85bd510",
                        "unitPrice": 75,
                        "_userSelected": false,
                        "dpa": true,
                        "parentId": "sidSolutionOG1",
                        "CurrencyIsoCode": "USD",
                        "uiType": "dropdown",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": false,
                        "defaultQty": 1
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "sidSolutionOG1",
                "uitype": "dropdown"
            },
            "Sid_OG_102": {
                "_availability": {
                    "availableOptions": {
                        "product_0": true
                    },
                    "availableCount": 1
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000WjMcEAK",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": "Router",
                "label": "Sid OG 102",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "label",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "_uid": "product_0",
                        "attributes": {},
                        "dbId": "a091a000000Uxg5AAC",
                        "idNode": "Router1",
                        "label": "Router1",
                        "path": [
                            "Router"
                        ],
                        "priceFreq": "One Time",
                        "qty": 1,
                        "listPrice": 1000,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 1000,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "category",
                "uea": null,
                "_uid": "Sid_OG_102",
                "uitype": "dropdown"
            },
            "Solution_OG_for_SDR": {
                "_availability": {
                    "availableOptions": {
                        "product_0": true,
                        "product_1": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {},
                    "selectedCount": 0,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000g2C3EAI",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": "SidSDRCatagory",
                "label": "Solution OG for SDR",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "label",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "_uid": "product_0",
                        "attributes": {},
                        "dbId": "a091a000000UxWCAA0",
                        "idNode": "RJ_Monthly_ConditionProduct_002_ID",
                        "label": "RJ_Yearly_ConditionProduct_002_Name",
                        "path": [
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Monthly",
                        "qty": 1,
                        "listPrice": 75,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 75,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "RJ_Size001": 10,
                        "_uid": "product_1",
                        "attributes": {},
                        "dbId": "a091a000000UxWDAA0",
                        "idNode": "Test_Prod",
                        "label": "Test_Prod",
                        "path": [
                            "Compute Options",
                            "Node Hardware",
                            "OpenStack",
                            "RJ_Category_Yearly",
                            "SidSDRCatagory",
                            "HDD-SAS",
                            "HDD",
                            "Storage Options",
                            "Node Hardware",
                            "OpenStack",
                            "SidSDRCatagory"
                        ],
                        "priceFreq": "Yearly",
                        "qty": 1,
                        "listPrice": 475,
                        "isSystemListPrice": true,
                        "dpa": true,
                        "unitPrice": 100,
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "category",
                "uea": null,
                "_uid": "Solution_OG_for_SDR",
                "uitype": "dropdown"
            }
        },
        "name": "Solution Model 10",
        "objs": {
            "Account": {
                "AnnualRevenue": 350000000,
                "NumberOfEmployees": 9000,
                "Id": "0011a000002JZ0BAAW",
                "sah__SLA__c": "Silver",
                "Rating": "Warm",
                "Type": "Customer - Direct",
                "Ownership": "Public",
                "Industry": "Apparel",
                "attributes": {
                    "type": "Account",
                    "url": "/services/data/v35.0/sobjects/Account/0011a000002JZ0BAAW"
                },
                "_uid": "Account"
            },
            "Opportunity": {
                "_uid": "Opportunity"
            },
            "MnQuote__c": {
                "sah__Monthly_Value_Before_Discount_S__c": 0,
                "sah__Monthly_Margin_F__c": 0,
                "sah__NeedApprovalCount__c": 0,
                "sah__Yearly_Adjustment1_Absolute_F__c": 475,
                "sah__One_Time_Adjustment1_Absolute_F__c": 0,
                "sah__MonthlyInterestRate__c": 0.003,
                "sah__Yearly_Unit_Price_S__c": 475,
                "sah__Yearly_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Segment__c": "General",
                "sah__Weekly_Adjustment1_Absolute_F__c": 0,
                "sah__Adjustment__c": 0,
                "sah__WeeklyTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__Weekly_Adjustment1_F__c": 0,
                "sah__Term__c": 12,
                "sah__OneTimeTotalAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Adjustment1_F__c": 0,
                "RecordTypeId": "0121a000000PGJdAAO",
                "sah__One_Time_Value_Before_Discount_S__c": 0,
                "sah__WeeklyTotalAdjustmentDisplay_F__c": 0,
                "sah__Following_Years_Value_F__c": 475,
                "sah__Quote_Value_Display_F__c": 475,
                "sah__Monthly_Adjustment1_F__c": 0,
                "sah__One_Time_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Weekly_Unit_Price_S__c": 0,
                "sah__TotalTargetPrice__c": 0,
                "sah__Yearly_Margin_F__c": 0,
                "sah__Yearly_Margin_Absolute_F__c": 0,
                "sah__OneTimeTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Line_Discount_Absolute__c": 0,
                "sah__Monthly_Line_Discount__c": 0,
                "sah__Weekly_Margin_F__c": 0,
                "sah__Weekly_Total_Value_S__c": 0,
                "sah__QuoteItemsNeedApprovalCount__c": 0,
                "sah__ExtId__c": 170,
                "sah__One_Time_Margin_Absolute_F__c": 0,
                "sah__GPTerm__c": 5,
                "sah__Monthly_Cost_Price_Before_Adjustment_S__c": 0,
                "Id": "a0i1a000000wfGQAAY",
                "sah__YearlyTotalAfterAdjustmentDisplay_F__c": 475,
                "sah__MonthlyTotalAdjustmentDisplay_F__c": 0,
                "sah__Weekly_Line_Discount__c": 0,
                "sah__InstallationCostViolation__c": 0,
                "sah__Monthly_Total_Value_S__c": 0,
                "sah__Overall_Discount__c": 0,
                "sah__Monthly_Margin_Absolute_F__c": 0,
                "sah__Yearly_Line_Discount_Absolute__c": 0,
                "sah__One_Time_Line_Discount__c": 0,
                "sah__ProposalSignStatus__c": "Not Signed",
                "sah__OneTimeTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Status__c": "Draft",
                "sah__One_Time_Margin_F__c": 0,
                "sah__Weekly_Cost_Price_Before_Adjustment_S__c": 0,
                "sah__Yearly_Line_Discount__c": 0,
                "sah__Yearly_Total_Value_S__c": 475,
                "sah__YearlyTotalAdjustmentDisplay_F__c": 0,
                "sah__One_Time_Total_Value_S__c": 0,
                "sah__Monthly_Adjustment1_Absolute_F__c": 0,
                "sah__TermYear__c": "1",
                "sah__WeeklyTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Yearly_Value_Before_Discount_S__c": 475,
                "sah__Weekly_Margin_Absolute_F__c": 0,
                "sah__YearlyTotalBeforeAdjustmentDisplay_F__c": 475,
                "sah__Yearly_Adjustment1_F__c": 0,
                "sah__One_Time_Unit_Price_S__c": 0,
                "sah__MonthlyTotalBeforeAdjustmentDisplay_F__c": 0,
                "sah__Monthly_Line_Discount_Absolute__c": 0,
                "sah__Monthly_Unit_Price_S__c": 0,
                "sah__Total_List_Price__c": 475,
                "sah__Quote_Value__c": 475,
                "sah__MonthlyTotalAfterAdjustmentDisplay_F__c": 0,
                "sah__SapPartnerCountry__c": "US",
                "sah__Currency__c": "USD",
                "sah__Weekly_Value_Before_Discount_S__c": 0,
                "sah__QuoteItemSubLinesNeedApprovalCount__c": 0,
                "sah__Weekly_Line_Discount_Absolute__c": 0,
                "attributes": {
                    "type": "sah__MnQuote__c",
                    "url": "/services/data/v35.0/sobjects/sah__MnQuote__c/a0i1a000000wfGQAAY"
                },
                "_uid": "MnQuote__c"
            },
            "MnQuoteItem__c": {
                "_uid": "MnQuoteItem__c"
            }
        },
        "perf": {
            "totCompTime": 108,
            "evalTime": 7,
            "compileTime": 19,
            "totEvalTime": 4
        },
        "result": {
            "nonqts": {
                "Solution_OG_for_SDR": {},
                "Sid_OG_102": {},
                "sidSolutionOG1": {},
                "Sid_OG_101": {}
            },
            "quotes": {
                "Solution_OG_for_SDR": {},
                "Sid_OG_102": {},
                "sidSolutionOG1": {
                    "400043cf-52bf-4498-b11a-6ca2aacad92f": true
                },
                "Sid_OG_101": {}
            }
        },
        "rules": [],
        "UI": {
            "dbId": "a0J1a000000WnTUEA0",
            "layout": {
                "sections": [
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000000XPXhEAO",
                        "groups": [
                            "sidSolutionOG1"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_fak0v"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000000XPe7EAG",
                        "groups": [
                            "Sid_OG_101",
                            "Sid_OG_102",
                            "Solution_OG_for_SDR"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_6pq48"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000003afXMEAY",
                        "groups": [],
                        "name": "New Section",
                        "uid": "OG_99ysy"
                    }
                ]
            },
            "name": "Layout For a0C1a000000VM6REAW",
            "uid": "a0C1a000000VM6REAW_Layout_20150528_143601",
            "version": 1
        },
        "uid": "Model_sybgl",
        "version": 23
    }
}