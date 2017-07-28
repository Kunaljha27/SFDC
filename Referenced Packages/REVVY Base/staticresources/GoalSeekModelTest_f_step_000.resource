{
    "sendDiff": false,
    "reqHasDiffModel": false,
    "step": {
        "extb": {},
        "tieredPricing": {
            "RJ_N17Product001": [
                {
                    "lp": 50,
                    "v": 10,
                    "t": "lpow",
                    "max": 200,
                    "min": 1
                },
                {
                    "v": 40,
                    "t": "lpow",
                    "max": 300,
                    "min": 201
                },
                {
                    "v": 50,
                    "t": "lpow",
                    "max": 500,
                    "min": 301
                }
            ],
            "RJ_Weekly_Product006": [
                {
                    "lp": 200,
                    "v": 195,
                    "t": "lpow",
                    "max": 10,
                    "min": 6
                },
                {
                    "v": 190,
                    "t": "lpow",
                    "max": 15,
                    "min": 11
                },
                {
                    "v": 170,
                    "t": "lpow",
                    "max": 20,
                    "min": 16
                }
            ],
            "sid_regular_with_Tiers": [
                {
                    "lp": 10,
                    "v": 5,
                    "t": "abs",
                    "max": 100,
                    "min": 1
                },
                {
                    "v": 8,
                    "t": "abs",
                    "max": 201,
                    "min": 101
                }
            ]
        },
        "compVersion": 40,
        "dbId": "a0C1a0000016EkqEAE",
        "errors": {
            "values": []
        },
        "exprs": null,
        "groups": {
            "tiers_OG": {
                "_availability": {
                    "availableCount": 2,
                    "availableOptions": {
                        "e4da5f58-8789-47b8-961e-d57c56d792a3": true,
                        "2f74d5a9-cfc8-4b54-9eaf-968e0332e878": true
                    }
                },
                "_selects": {
                    "reqAttrErrCnt": 0,
                    "reqAttrErr": {},
                    "selectedCount": 1,
                    "selectedOptions": {
                        "e4da5f58-8789-47b8-961e-d57c56d792a3": true
                    }
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": true,
                "allowedQty": null,
                "dbId": "a0E1a000001Un5lEAC",
                "defaultQty": 500,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "tiers OG",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "RJ_N17Product001",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "RJ_N17Product001",
                        "adj1": {
                            "t": "perc",
                            "v": -44.44444444444444
                        },
                        "costPrice": 90,
                        "dbId": "a091a000000UxWGAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": true,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_N17Product001_Name",
                        "listPrice": 50,
                        "manAdj": null,
                        "name": "Tier Option",
                        "qty": 500,
                        "_uid": "2f74d5a9-cfc8-4b54-9eaf-968e0332e878",
                        "unitPrice": 50,
                        "_userSelected": false,
                        "dpa": true,
                        "dca": true,
                        "parentId": "tiers_OG",
                        "CurrencyIsoCode": "USD",
                        "uiType": "radio",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": true,
                        "defaultQty": 500
                    },
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [],
                        "priceFreq": "Yearly",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002IfePAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": false,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": false,
                        "label": "Test_Prod",
                        "listPrice": 300,
                        "manAdj": {
                            "v": 83.443709,
                            "t": "perc"
                        },
                        "name": "Test_Prod",
                        "qty": 500,
                        "_uid": "e4da5f58-8789-47b8-961e-d57c56d792a3",
                        "unitPrice": 100,
                        "_userSelected": true,
                        "dpa": true,
                        "parentId": "tiers_OG",
                        "CurrencyIsoCode": "USD",
                        "uiType": "radio",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": true,
                        "defaultQty": 500
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "tiers_OG",
                "uitype": "radiobutton"
            },
            "Sid_PD_UEV_OG": {
                "_availability": {
                    "availableCount": 3,
                    "availableOptions": {
                        "8cf08054-3ad8-4121-b3e6-4472f96775bc": true,
                        "bc582838-7d53-4754-9df7-f340d12427c0": true,
                        "8581e3b6-85ae-4aaf-adbc-f49c8857be9b": true
                    }
                },
                "_selects": {
                    "reqAttrErrCnt": 0,
                    "reqAttrErr": {},
                    "selectedCount": 0,
                    "selectedOptions": {}
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000hBR2EAM",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid PD UEV OG12",
                "methods": null,
                "_multiSelect": true,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "X_WeightProductNet": 11.1,
                        "HW_MemPinCount": 204,
                        "attributes": {},
                        "idNode": "CBT829",
                        "path": [
                            "HW523 DDR2",
                            "HW52 Memory",
                            "HW5 Components"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "CBT829",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdDAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "16GB DDR2, 1333 MT/s, Standard Volt, Single Rank, x8 Data Width",
                        "listPrice": 312.22,
                        "manAdj": null,
                        "name": "16GB DDR2, 1333 MT/s, Standard Volt, Single Rank, x8 Data Width",
                        "qty": 1,
                        "_uid": "8581e3b6-85ae-4aaf-adbc-f49c8857be9b",
                        "unitPrice": 312.22,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "900453",
                        "path": [
                            "HW525 DDR3",
                            "HW52 Memory",
                            "HW5 Components"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "900453",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdLAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "16GB DDR2, 2x 8GB 1600 MT/s, Low Volt, Dual Rank, x4 Data Width",
                        "listPrice": 69.99,
                        "manAdj": null,
                        "name": "16GB DDR2, 2x 8GB 1600 MT/s, Low Volt, Dual Rank, x4 Data Width",
                        "qty": 1,
                        "_uid": "bc582838-7d53-4754-9df7-f340d12427c0",
                        "unitPrice": 69.99,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Green001",
                        "RJ_Available_ID": "Yes",
                        "attributes": {},
                        "idNode": "RJ_Weekly_Product006",
                        "path": [
                            "RJ_Category_Weekly"
                        ],
                        "priceFreq": "Weekly",
                        "_idNodeRef": "RJ_Weekly_Product006",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdoAAC",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Weekly_Product006",
                        "listPrice": 200,
                        "manAdj": null,
                        "name": "RJ_Weekly_Product006",
                        "qty": 1,
                        "_uid": "8cf08054-3ad8-4121-b3e6-4472f96775bc",
                        "unitPrice": 200,
                        "_userSelected": false,
                        "dpa": true
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_PD_UEV_OG",
                "uitype": "checkbox"
            },
            "Sid_TP_OG": {
                "_availability": {
                    "availableCount": 1,
                    "availableOptions": {
                        "bed16512-6c15-49d9-966e-d6403cb90256": true
                    }
                },
                "_selects": {
                    "reqAttrErrCnt": 0,
                    "reqAttrErr": {},
                    "selectedCount": 0,
                    "selectedOptions": {}
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": true,
                "allowedQty": null,
                "dbId": "a0E1a000001VQviEAG",
                "defaultQty": 10,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid TP OG",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_regular_with_Tiers",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_regular_with_Tiers",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002HYMkAAO",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "Sid regular with Tiers",
                        "listPrice": 10,
                        "manAdj": null,
                        "name": "TP PRod",
                        "qty": 10,
                        "_uid": "bed16512-6c15-49d9-966e-d6403cb90256",
                        "unitPrice": 5,
                        "_userSelected": false,
                        "dpa": true,
                        "volumeDiscount": {
                            "v": 5,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_TP_OG",
                "uitype": "radiobutton"
            },
            "OG_One_Time": {
                "_availability": {
                    "availableCount": 3,
                    "availableOptions": {
                        "2fe72bf6-1550-4fc1-94be-906f7eb4d135": true,
                        "f799cfd7-3fc5-4d22-bb59-2f3799bb5113": true,
                        "3afe7223-6668-425f-9f9d-62a424a26eb5": true
                    }
                },
                "_selects": {
                    "reqAttrErrCnt": 0,
                    "reqAttrErr": {},
                    "selectedCount": 0,
                    "selectedOptions": {}
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000001X8b4EAC",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "OG One Time",
                "methods": null,
                "_multiSelect": true,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_3",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_3",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JBFSAA4",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_3",
                        "listPrice": 1000,
                        "manAdj": null,
                        "name": "One time 1",
                        "qty": 1,
                        "_uid": "3afe7223-6668-425f-9f9d-62a424a26eb5",
                        "unitPrice": 1000,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_1",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_1",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JAWXAA4",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_1",
                        "listPrice": 800,
                        "manAdj": null,
                        "name": "One time 2",
                        "qty": 1,
                        "_uid": "f799cfd7-3fc5-4d22-bb59-2f3799bb5113",
                        "unitPrice": 800,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_2",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_2",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JAWcAAO",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_2",
                        "listPrice": 700,
                        "manAdj": null,
                        "name": "One time 3",
                        "qty": 1,
                        "_uid": "2fe72bf6-1550-4fc1-94be-906f7eb4d135",
                        "unitPrice": 700,
                        "_userSelected": false,
                        "dpa": true
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "OG_One_Time",
                "uitype": "table"
            },
            "Sid_OG_Regular": {
                "_availability": {
                    "availableCount": 2,
                    "availableOptions": {
                        "0e073a58-61e5-4964-9f5b-134987ec2ac7": true,
                        "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true
                    }
                },
                "_selects": {
                    "reqAttrErrCnt": 0,
                    "reqAttrErr": {},
                    "selectedCount": 1,
                    "selectedOptions": {
                        "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true
                    }
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000jEFdEAM",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid OG Regular",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [
                            "RJ_Category001_ID",
                            "RJ_Category_OneTime",
                            "RJ_OneLevelCategory001_ID"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxTJAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "Test_Prod_Name",
                        "listPrice": 5000,
                        "manAdj": null,
                        "name": "Test_Prod_Name",
                        "qty": 1,
                        "_uid": "29d9b124-b7c4-4a24-aa13-7e477efe1a39",
                        "unitPrice": 5000,
                        "_userSelected": true,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "attributes": {},
                        "idNode": "RJ_Bundle_OneTime_002",
                        "path": [
                            "RJ_Category_OneTime"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "RJ_Bundle_OneTime_002",
                        "adj1": null,
                        "costPrice": null,
                        "dbId": "a091a000000Uxb3AAC",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": null,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Bundle_OneTime_002_Name",
                        "listPrice": null,
                        "manAdj": null,
                        "name": "RJ_Bundle_OneTime_002_Name",
                        "qty": 1,
                        "_uid": "0e073a58-61e5-4964-9f5b-134987ec2ac7",
                        "unitPrice": null,
                        "_userSelected": false
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": true,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_OG_Regular",
                "uitype": "radiobutton"
            }
        },
        "name": "Sid New UEV Predefined Model",
        "objs": {
            "Account": {
                "AnnualRevenue": 350000000,
                "NumberOfEmployees": 9000,
                "Id": "0011a000002JZ0BAAW",
                "SLA__c": "Silver",
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
                "Monthly_Value_Before_Discount_S__c": 0,
                "NeedApprovalCount__c": 0,
                "Yearly_Adjustment1_Absolute_F__c": 151000,
                "One_Time_Adjustment1_Absolute_F__c": 5000,
                "MonthlyInterestRate__c": 0.003,
                "Yearly_Unit_Price_S__c": 264.9,
                "Segment__c": "General",
                "Weekly_Adjustment1_Absolute_F__c": 0,
                "Adjustment__c": 64.85,
                "WeeklyTotalAfterAdjustmentDisplay_F__c": 0,
                "Weekly_Adjustment1_F__c": 0,
                "Term__c": 12,
                "OneTimeTotalAdjustmentDisplay_F__c": 0,
                "One_Time_Adjustment1_F__c": 0,
                "RecordTypeId": "0121a000000PGJdAAO",
                "One_Time_Value_Before_Discount_S__c": 5000,
                "WeeklyTotalAdjustmentDisplay_F__c": 0,
                "Following_Years_Value_F__c": 49834.44,
                "Quote_Value_Display_F__c": 54834.44,
                "Monthly_Adjustment1_F__c": 0,
                "Weekly_Unit_Price_S__c": 0,
                "TotalTargetPrice__c": 0,
                "OneTimeTotalAfterAdjustmentDisplay_F__c": 5000,
                "One_Time_Line_Discount_Absolute__c": 0,
                "Monthly_Line_Discount__c": 0,
                "Weekly_Total_Value_S__c": 0,
                "QuoteItemsNeedApprovalCount__c": 1,
                "ExtId__c": 162,
                "GPTerm__c": 5,
                "Id": "a0i1a000000wcKVAAY",
                "YearlyTotalAfterAdjustmentDisplay_F__c": 49834.44,
                "MonthlyTotalAdjustmentDisplay_F__c": 0,
                "Weekly_Line_Discount__c": 0,
                "InstallationCostViolation__c": 0,
                "Monthly_Total_Value_S__c": 0,
                "Overall_Discount__c": 64.85,
                "Yearly_Line_Discount_Absolute__c": 101165.56209,
                "One_Time_Line_Discount__c": 0,
                "ProposalSignStatus__c": "Not Signed",
                "OneTimeTotalBeforeAdjustmentDisplay_F__c": 5000,
                "Status__c": "Target Price in progress...",
                "Yearly_Line_Discount__c": 67,
                "Yearly_Total_Value_S__c": 49834.43791,
                "YearlyTotalAdjustmentDisplay_F__c": 67,
                "One_Time_Total_Value_S__c": 5000,
                "Monthly_Adjustment1_Absolute_F__c": 0,
                "TermYear__c": "1",
                "WeeklyTotalBeforeAdjustmentDisplay_F__c": 0,
                "Yearly_Value_Before_Discount_S__c": 151000,
                "YearlyTotalBeforeAdjustmentDisplay_F__c": 151000,
                "Yearly_Adjustment1_F__c": 0,
                "One_Time_Unit_Price_S__c": 5000,
                "MonthlyTotalBeforeAdjustmentDisplay_F__c": 0,
                "Monthly_Line_Discount_Absolute__c": 0,
                "Monthly_Unit_Price_S__c": 0,
                "Total_List_Price__c": 156000,
                "Quote_Value__c": 54834.43791,
                "MonthlyTotalAfterAdjustmentDisplay_F__c": 0,
                "SapPartnerCountry__c": "US",
                "Currency__c": "USD",
                "Weekly_Value_Before_Discount_S__c": 0,
                "QuoteItemSubLinesNeedApprovalCount__c": 0,
                "Weekly_Line_Discount_Absolute__c": 0,
                "attributes": {
                    "type": "MnQuote__c",
                    "url": "/services/data/v35.0/sobjects/MnQuote__c/a0i1a000000wcKVAAY"
                },
                "_uid": "MnQuote__c"
            },
            "MnQuoteItem__c": {
                "AutoDiscountAbsolute__c": 0,
                "One_Time_Unit_Price_F__c": 5000,
                "ContractDiscount__c": 0,
                "Weekly_Discount_Absolute_F__c": 0,
                "Yearly_Extended_Price_F__c": 49834.43791,
                "Monthly_Extended_Price_S__c": 0,
                "Monthly_Margin_F__c": 0,
                "Quantity__c": 1,
                "One_Time_Total_Value_F__c": 5000,
                "Monthly_Price_Before_Discount_Display_F__c": 0,
                "Weekly_Discount_F__c": 0,
                "Yearly_Adjustment1_Absolute_F__c": 151000,
                "One_Time_Adjustment1_Absolute_F__c": 5000,
                "ContractPrice__c": 0,
                "Price_Display_F__c": 1000,
                "Weekly_Value_Before_Discount_F__c": 0,
                "TotalDiscount__c": 83.44,
                "Yearly_Total_Value_F__c": 49834.43791,
                "TotalCostPrice__c": 0,
                "Weekly_Adjustment1_Absolute_F__c": 0,
                "Yearly_Discount_F__c": 67,
                "Weekly_Adjustment1_F__c": 0,
                "One_Time_Extended_Price_S__c": 5000,
                "Weekly_Price_Before_Discount_Display_F__c": 0,
                "One_Time_Adjustment1_F__c": 0,
                "Monthly_Extended_Price_F__c": 0,
                "Monthly_Value_Before_Discount_F__c": 0,
                "Monthly_Total_Value_Display_F__c": 0,
                "Monthly_Unit_Price_F__c": 0,
                "Yearly_Unit_Price_F__c": 264.9,
                "Monthly_Price_Before_Discount_F__c": 0,
                "One_Time_Total_Value_Display_F__c": 5000,
                "TotalDiscountAbsolute__c": 834.43709,
                "Weekly_Total_Value_F__c": 0,
                "One_Time_Extended_Price_F__c": 5000,
                "MarginType__c": "Percent",
                "Weekly_Extended_Price_F__c": 0,
                "Yearly_Price_Before_Discount_F__c": 151000,
                "Id__c": 428,
                "Monthly_Adjustment1_F__c": 0,
                "Weekly_Price_Before_Discount_F__c": 0,
                "Discount_Type__c": "Percent",
                "Yearly_Price_Before_Discount_Display_F__c": 151000,
                "One_Time_Discount_Absolute_F__c": 0,
                "Yearly_Value_Before_Discount_F__c": 151000,
                "Yearly_Margin_F__c": 100,
                "AutoDiscount__c": 0,
                "Monthly_Price_Before_Discount_S__c": 0,
                "Weekly_Margin_F__c": 0,
                "One_Time_Price_Before_Discount_Display_F__c": 5000,
                "Weekly_Total_Value_Display_F__c": 0,
                "Id": "a0e1a000001KHFwAAO",
                "Discount__c": 83.443709,
                "Unit_Price_F__c": 165.56,
                "LineType__c": "Not tracked on contract",
                "Extended_Price_Display_F__c": 165.56,
                "One_Time_Margin_F__c": 100,
                "Yearly_Discount_Absolute_F__c": 101165.56209,
                "Total_Value_Display_F__c": 49834.44,
                "One_Time_Price_Before_Discount_S__c": 5000,
                "Extended_Price_F__c": 165.56291,
                "Record_Number__c": 1,
                "Total_Price__c": 1000,
                "Unit_Price__c": 165.56291,
                "Monthly_Adjustment1_Absolute_F__c": 0,
                "AutoDiscountType__c": "Percent",
                "Discount_Absolute__c": 834.43709,
                "Yearly_Total_Value_Display_F__c": 49834.44,
                "Price__c": 1000,
                "Yearly_Extended_Price_S__c": 49668.875,
                "Yearly_Price_Before_Discount_S__c": 150000,
                "Yearly_Adjustment1_F__c": 0,
                "Weekly_Unit_Price_F__c": 0,
                "One_Time_Price_Before_Discount_F__c": 5000,
                "PriceType__c": "List",
                "One_Time_Discount_F__c": 0,
                "One_Time_Value_Before_Discount_F__c": 5000,
                "Monthly_Discount_F__c": 0,
                "Weekly_Price_Before_Discount_S__c": 0,
                "Weekly_Extended_Price_S__c": 0,
                "Monthly_Discount_Absolute_F__c": 0,
                "QuoteItemSubLinesNeedApprovalCount__c": 0,
                "Adjustment1Type__c": "Percent",
                "Monthly_Total_Value_F__c": 0,
                "attributes": {
                    "type": "MnQuoteItem__c",
                    "url": "/services/data/v35.0/sobjects/MnQuoteItem__c/a0e1a000001KHFwAAO"
                },
                "_uid": "MnQuoteItem__c",
                "Monthly_Unit_Price_S__c": 0,
                "One_Time_Unit_Price_S__c": 5000,
                "Weekly_Unit_Price_S__c": 0,
                "Yearly_Unit_Price_S__c": 99.33775
            }
        },
        "perf": {
            "totCompTime": 47,
            "evalTime": 7,
            "compileTime": 12,
            "totEvalTime": 41
        },
        "result": {
            "nonqts": {
                "Sid_OG_Regular": {},
                "OG_One_Time": {},
                "Sid_TP_OG": {},
                "Sid_PD_UEV_OG": {},
                "tiers_OG": {}
            },
            "quotes": {
                "Sid_OG_Regular": {
                    "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true
                },
                "OG_One_Time": {},
                "Sid_TP_OG": {},
                "Sid_PD_UEV_OG": {},
                "tiers_OG": {
                    "e4da5f58-8789-47b8-961e-d57c56d792a3": true
                }
            }
        },
        "rules": [],
        "UI": {
            "dbId": "a0J1a0000019ORFEA2",
            "layout": {
                "sections": [
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001hG95EAE",
                        "groups": [
                            "Sid_PD_UEV_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_40aub"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001iwyfEAA",
                        "groups": [
                            "Sid_OG_Regular"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_rlfpa"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001jvLmEAI",
                        "groups": [
                            "tiers_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_kwdqz"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001kdEOEAY",
                        "groups": [
                            "Sid_TP_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_c1tn2"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000003b3cXEAQ",
                        "groups": [
                            "OG_One_Time"
                        ],
                        "name": "New Section",
                        "uid": "OG_aai4g"
                    }
                ]
            },
            "name": "Layout For a0C1a0000016EkqEAE",
            "uid": "a0C1a0000016EkqEAE_Layout_20150707_131229",
            "version": 1
        },
        "uid": "Model_ebr4m",
        "version": 23
    },
    "result": {
        "extb": {},
        "tieredPricing": {
            "RJ_N17Product001": [
                {
                    "lp": 50,
                    "v": 10,
                    "t": "lpow",
                    "max": 200,
                    "min": 1
                },
                {
                    "v": 40,
                    "t": "lpow",
                    "max": 300,
                    "min": 201
                },
                {
                    "v": 50,
                    "t": "lpow",
                    "max": 500,
                    "min": 301
                }
            ],
            "RJ_Weekly_Product006": [
                {
                    "lp": 200,
                    "v": 195,
                    "t": "lpow",
                    "max": 10,
                    "min": 6
                },
                {
                    "v": 190,
                    "t": "lpow",
                    "max": 15,
                    "min": 11
                },
                {
                    "v": 170,
                    "t": "lpow",
                    "max": 20,
                    "min": 16
                }
            ],
            "sid_regular_with_Tiers": [
                {
                    "lp": 10,
                    "v": 5,
                    "t": "abs",
                    "max": 100,
                    "min": 1
                },
                {
                    "v": 8,
                    "t": "abs",
                    "max": 201,
                    "min": 101
                }
            ]
        },
        "compVersion": 40,
        "dbId": "a0C1a0000016EkqEAE",
        "errors": {
            "values": []
        },
        "exprs": null,
        "groups": {
            "tiers_OG": {
                "_availability": {
                    "availableOptions": {
                        "2f74d5a9-cfc8-4b54-9eaf-968e0332e878": true,
                        "e4da5f58-8789-47b8-961e-d57c56d792a3": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {
                        "e4da5f58-8789-47b8-961e-d57c56d792a3": true
                    },
                    "selectedCount": 1,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": true,
                "allowedQty": null,
                "dbId": "a0E1a000001Un5lEAC",
                "defaultQty": 500,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "tiers OG",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "RJ_N17Product001",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "RJ_N17Product001",
                        "adj1": {
                            "t": "perc",
                            "v": -44.44444444444444
                        },
                        "costPrice": 90,
                        "dbId": "a091a000000UxWGAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": true,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_N17Product001_Name",
                        "listPrice": 50,
                        "manAdj": null,
                        "name": "Tier Option",
                        "qty": 500,
                        "_uid": "2f74d5a9-cfc8-4b54-9eaf-968e0332e878",
                        "unitPrice": 50,
                        "_userSelected": false,
                        "dpa": true,
                        "dca": true,
                        "parentId": "tiers_OG",
                        "CurrencyIsoCode": "USD",
                        "uiType": "radio",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": true,
                        "defaultQty": 500
                    },
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [],
                        "priceFreq": "Yearly",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002IfePAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": false,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": false,
                        "label": "Test_Prod",
                        "listPrice": 300,
                        "manAdj": {
                            "v": 83.443709,
                            "t": "perc"
                        },
                        "name": "Test_Prod",
                        "qty": 500,
                        "_uid": "e4da5f58-8789-47b8-961e-d57c56d792a3",
                        "unitPrice": 100,
                        "_userSelected": true,
                        "dpa": true,
                        "parentId": "tiers_OG",
                        "CurrencyIsoCode": "USD",
                        "uiType": "radio",
                        "displayProdId": false,
                        "displayListPrice": false,
                        "showQty": true,
                        "defaultQty": 500
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "tiers_OG",
                "uitype": "radiobutton"
            },
            "Sid_PD_UEV_OG": {
                "_availability": {
                    "availableOptions": {
                        "8581e3b6-85ae-4aaf-adbc-f49c8857be9b": true,
                        "bc582838-7d53-4754-9df7-f340d12427c0": true,
                        "8cf08054-3ad8-4121-b3e6-4472f96775bc": true
                    },
                    "availableCount": 3
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
                "dbId": "a0E1a000000hBR2EAM",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid PD UEV OG12",
                "methods": null,
                "_multiSelect": true,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "X_WeightProductNet": 11.1,
                        "HW_MemPinCount": 204,
                        "attributes": {},
                        "idNode": "CBT829",
                        "path": [
                            "HW523 DDR2",
                            "HW52 Memory",
                            "HW5 Components"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "CBT829",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdDAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "16GB DDR2, 1333 MT/s, Standard Volt, Single Rank, x8 Data Width",
                        "listPrice": 312.22,
                        "manAdj": null,
                        "name": "16GB DDR2, 1333 MT/s, Standard Volt, Single Rank, x8 Data Width",
                        "qty": 1,
                        "_uid": "8581e3b6-85ae-4aaf-adbc-f49c8857be9b",
                        "unitPrice": 312.22,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "900453",
                        "path": [
                            "HW525 DDR3",
                            "HW52 Memory",
                            "HW5 Components"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "900453",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdLAAS",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "16GB DDR2, 2x 8GB 1600 MT/s, Low Volt, Dual Rank, x4 Data Width",
                        "listPrice": 69.99,
                        "manAdj": null,
                        "name": "16GB DDR2, 2x 8GB 1600 MT/s, Low Volt, Dual Rank, x4 Data Width",
                        "qty": 1,
                        "_uid": "bc582838-7d53-4754-9df7-f340d12427c0",
                        "unitPrice": 69.99,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Green001",
                        "RJ_Available_ID": "Yes",
                        "attributes": {},
                        "idNode": "RJ_Weekly_Product006",
                        "path": [
                            "RJ_Category_Weekly"
                        ],
                        "priceFreq": "Weekly",
                        "_idNodeRef": "RJ_Weekly_Product006",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxdoAAC",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Weekly_Product006",
                        "listPrice": 200,
                        "manAdj": null,
                        "name": "RJ_Weekly_Product006",
                        "qty": 1,
                        "_uid": "8cf08054-3ad8-4121-b3e6-4472f96775bc",
                        "unitPrice": 200,
                        "_userSelected": false,
                        "dpa": true
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_PD_UEV_OG",
                "uitype": "checkbox"
            },
            "Sid_TP_OG": {
                "_availability": {
                    "availableOptions": {
                        "bed16512-6c15-49d9-966e-d6403cb90256": true
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
                "allowAttributes": true,
                "allowedQty": null,
                "dbId": "a0E1a000001VQviEAG",
                "defaultQty": 10,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid TP OG",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_regular_with_Tiers",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_regular_with_Tiers",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002HYMkAAO",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "Sid regular with Tiers",
                        "listPrice": 10,
                        "manAdj": null,
                        "name": "TP PRod",
                        "qty": 10,
                        "_uid": "bed16512-6c15-49d9-966e-d6403cb90256",
                        "unitPrice": 5,
                        "_userSelected": false,
                        "dpa": true,
                        "volumeDiscount": {
                            "v": 5,
                            "t": "abs"
                        }
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": true,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_TP_OG",
                "uitype": "radiobutton"
            },
            "OG_One_Time": {
                "_availability": {
                    "availableOptions": {
                        "3afe7223-6668-425f-9f9d-62a424a26eb5": true,
                        "f799cfd7-3fc5-4d22-bb59-2f3799bb5113": true,
                        "2fe72bf6-1550-4fc1-94be-906f7eb4d135": true
                    },
                    "availableCount": 3
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
                "dbId": "a0E1a000001X8b4EAC",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "OG One Time",
                "methods": null,
                "_multiSelect": true,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_3",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_3",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JBFSAA4",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_3",
                        "listPrice": 1000,
                        "manAdj": null,
                        "name": "One time 1",
                        "qty": 1,
                        "_uid": "3afe7223-6668-425f-9f9d-62a424a26eb5",
                        "unitPrice": 1000,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_1",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_1",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JAWXAA4",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_1",
                        "listPrice": 800,
                        "manAdj": null,
                        "name": "One time 2",
                        "qty": 1,
                        "_uid": "f799cfd7-3fc5-4d22-bb59-2f3799bb5113",
                        "unitPrice": 800,
                        "_userSelected": false,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "attributes": {},
                        "idNode": "sid_one_time_prod_2",
                        "path": [],
                        "priceFreq": "One Time",
                        "_idNodeRef": "sid_one_time_prod_2",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000002JAWcAAO",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "sid_one_time_prod_2",
                        "listPrice": 700,
                        "manAdj": null,
                        "name": "One time 3",
                        "qty": 1,
                        "_uid": "2fe72bf6-1550-4fc1-94be-906f7eb4d135",
                        "unitPrice": 700,
                        "_userSelected": false,
                        "dpa": true
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": false,
                "type": "regular",
                "uea": null,
                "_uid": "OG_One_Time",
                "uitype": "table"
            },
            "Sid_OG_Regular": {
                "_availability": {
                    "availableOptions": {
                        "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true,
                        "0e073a58-61e5-4964-9f5b-134987ec2ac7": true
                    },
                    "availableCount": 2
                },
                "_selects": {
                    "selectedOptions": {
                        "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true
                    },
                    "selectedCount": 1,
                    "reqAttrErr": {},
                    "reqAttrErrCnt": 0
                },
                "_errors": {},
                "_visible": true,
                "allowAttributes": false,
                "allowedQty": null,
                "dbId": "a0E1a000000jEFdEAM",
                "defaultQty": 1,
                "defaultVisibility": true,
                "description": null,
                "displayListPrice": false,
                "displayProdId": false,
                "idNodeRef": null,
                "label": "Sid OG Regular",
                "methods": null,
                "_multiSelect": false,
                "ogAliasNameInModel": "",
                "optionLabelField": "name",
                "options": [
                    {
                        "_selected": true,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "attributes": {},
                        "idNode": "Test_Prod",
                        "path": [
                            "RJ_Category001_ID",
                            "RJ_Category_OneTime",
                            "RJ_OneLevelCategory001_ID"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "Test_Prod",
                        "adj1": {
                            "v": null,
                            "t": "abs"
                        },
                        "costPrice": null,
                        "dbId": "a091a000000UxTJAA0",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": true,
                        "isSystemUnitPrice": null,
                        "label": "Test_Prod_Name",
                        "listPrice": 5000,
                        "manAdj": null,
                        "name": "Test_Prod_Name",
                        "qty": 1,
                        "_uid": "29d9b124-b7c4-4a24-aa13-7e477efe1a39",
                        "unitPrice": 5000,
                        "_userSelected": true,
                        "dpa": true
                    },
                    {
                        "_selected": false,
                        "_errors": {},
                        "_optVis": true,
                        "_iavb": true,
                        "_available": true,
                        "RJ_Color": "RJ_Red001",
                        "attributes": {},
                        "idNode": "RJ_Bundle_OneTime_002",
                        "path": [
                            "RJ_Category_OneTime"
                        ],
                        "priceFreq": "One Time",
                        "_idNodeRef": "RJ_Bundle_OneTime_002",
                        "adj1": null,
                        "costPrice": null,
                        "dbId": "a091a000000Uxb3AAC",
                        "IsChanged": null,
                        "isSystemCostPrice": null,
                        "isSystemListPrice": null,
                        "isSystemUnitPrice": null,
                        "label": "RJ_Bundle_OneTime_002_Name",
                        "listPrice": null,
                        "manAdj": null,
                        "name": "RJ_Bundle_OneTime_002_Name",
                        "qty": 1,
                        "_uid": "0e073a58-61e5-4964-9f5b-134987ec2ac7",
                        "unitPrice": null,
                        "_userSelected": false
                    }
                ],
                "_quotable": true,
                "quoteAttr": "idNode",
                "_required": false,
                "showQty": false,
                "showUploadFileBtn": true,
                "type": "regular",
                "uea": null,
                "_uid": "Sid_OG_Regular",
                "uitype": "radiobutton"
            }
        },
        "name": "Sid New UEV Predefined Model",
        "objs": {
            "Account": {
                "AnnualRevenue": 350000000,
                "NumberOfEmployees": 9000,
                "Id": "0011a000002JZ0BAAW",
                "SLA__c": "Silver",
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
                "Monthly_Value_Before_Discount_S__c": 0,
                "NeedApprovalCount__c": 0,
                "Yearly_Adjustment1_Absolute_F__c": 151000,
                "One_Time_Adjustment1_Absolute_F__c": 5000,
                "MonthlyInterestRate__c": 0.003,
                "Yearly_Unit_Price_S__c": 264.9,
                "Segment__c": "General",
                "Weekly_Adjustment1_Absolute_F__c": 0,
                "Adjustment__c": 64.85,
                "WeeklyTotalAfterAdjustmentDisplay_F__c": 0,
                "Weekly_Adjustment1_F__c": 0,
                "Term__c": 12,
                "OneTimeTotalAdjustmentDisplay_F__c": 0,
                "One_Time_Adjustment1_F__c": 0,
                "RecordTypeId": "0121a000000PGJdAAO",
                "One_Time_Value_Before_Discount_S__c": 5000,
                "WeeklyTotalAdjustmentDisplay_F__c": 0,
                "Following_Years_Value_F__c": 49834.44,
                "Quote_Value_Display_F__c": 54834.44,
                "Monthly_Adjustment1_F__c": 0,
                "Weekly_Unit_Price_S__c": 0,
                "TotalTargetPrice__c": 0,
                "OneTimeTotalAfterAdjustmentDisplay_F__c": 5000,
                "One_Time_Line_Discount_Absolute__c": 0,
                "Monthly_Line_Discount__c": 0,
                "Weekly_Total_Value_S__c": 0,
                "QuoteItemsNeedApprovalCount__c": 1,
                "ExtId__c": 162,
                "GPTerm__c": 5,
                "Id": "a0i1a000000wcKVAAY",
                "YearlyTotalAfterAdjustmentDisplay_F__c": 49834.44,
                "MonthlyTotalAdjustmentDisplay_F__c": 0,
                "Weekly_Line_Discount__c": 0,
                "InstallationCostViolation__c": 0,
                "Monthly_Total_Value_S__c": 0,
                "Overall_Discount__c": 64.85,
                "Yearly_Line_Discount_Absolute__c": 101165.56209,
                "One_Time_Line_Discount__c": 0,
                "ProposalSignStatus__c": "Not Signed",
                "OneTimeTotalBeforeAdjustmentDisplay_F__c": 5000,
                "Status__c": "Target Price in progress...",
                "Yearly_Line_Discount__c": 67,
                "Yearly_Total_Value_S__c": 49834.43791,
                "YearlyTotalAdjustmentDisplay_F__c": 67,
                "One_Time_Total_Value_S__c": 5000,
                "Monthly_Adjustment1_Absolute_F__c": 0,
                "TermYear__c": "1",
                "WeeklyTotalBeforeAdjustmentDisplay_F__c": 0,
                "Yearly_Value_Before_Discount_S__c": 151000,
                "YearlyTotalBeforeAdjustmentDisplay_F__c": 151000,
                "Yearly_Adjustment1_F__c": 0,
                "One_Time_Unit_Price_S__c": 5000,
                "MonthlyTotalBeforeAdjustmentDisplay_F__c": 0,
                "Monthly_Line_Discount_Absolute__c": 0,
                "Monthly_Unit_Price_S__c": 0,
                "Total_List_Price__c": 156000,
                "Quote_Value__c": 54834.43791,
                "MonthlyTotalAfterAdjustmentDisplay_F__c": 0,
                "SapPartnerCountry__c": "US",
                "Currency__c": "USD",
                "Weekly_Value_Before_Discount_S__c": 0,
                "QuoteItemSubLinesNeedApprovalCount__c": 0,
                "Weekly_Line_Discount_Absolute__c": 0,
                "attributes": {
                    "type": "MnQuote__c",
                    "url": "/services/data/v35.0/sobjects/MnQuote__c/a0i1a000000wcKVAAY"
                },
                "_uid": "MnQuote__c"
            },
            "MnQuoteItem__c": {
                "AutoDiscountAbsolute__c": 0,
                "One_Time_Unit_Price_F__c": 5000,
                "ContractDiscount__c": 0,
                "Weekly_Discount_Absolute_F__c": 0,
                "Yearly_Extended_Price_F__c": 49834.43791,
                "Monthly_Extended_Price_S__c": 0,
                "Monthly_Margin_F__c": 0,
                "Quantity__c": 1,
                "One_Time_Total_Value_F__c": 5000,
                "Monthly_Price_Before_Discount_Display_F__c": 0,
                "Weekly_Discount_F__c": 0,
                "Yearly_Adjustment1_Absolute_F__c": 151000,
                "One_Time_Adjustment1_Absolute_F__c": 5000,
                "ContractPrice__c": 0,
                "Price_Display_F__c": 1000,
                "Weekly_Value_Before_Discount_F__c": 0,
                "TotalDiscount__c": 83.44,
                "Yearly_Total_Value_F__c": 49834.43791,
                "TotalCostPrice__c": 0,
                "Weekly_Adjustment1_Absolute_F__c": 0,
                "Yearly_Discount_F__c": 67,
                "Weekly_Adjustment1_F__c": 0,
                "One_Time_Extended_Price_S__c": 5000,
                "Weekly_Price_Before_Discount_Display_F__c": 0,
                "One_Time_Adjustment1_F__c": 0,
                "Monthly_Extended_Price_F__c": 0,
                "Monthly_Value_Before_Discount_F__c": 0,
                "Monthly_Total_Value_Display_F__c": 0,
                "Monthly_Unit_Price_F__c": 0,
                "Yearly_Unit_Price_F__c": 264.9,
                "Monthly_Price_Before_Discount_F__c": 0,
                "One_Time_Total_Value_Display_F__c": 5000,
                "TotalDiscountAbsolute__c": 834.43709,
                "Weekly_Total_Value_F__c": 0,
                "One_Time_Extended_Price_F__c": 5000,
                "MarginType__c": "Percent",
                "Weekly_Extended_Price_F__c": 0,
                "Yearly_Price_Before_Discount_F__c": 151000,
                "Id__c": 428,
                "Monthly_Adjustment1_F__c": 0,
                "Weekly_Price_Before_Discount_F__c": 0,
                "Discount_Type__c": "Percent",
                "Yearly_Price_Before_Discount_Display_F__c": 151000,
                "One_Time_Discount_Absolute_F__c": 0,
                "Yearly_Value_Before_Discount_F__c": 151000,
                "Yearly_Margin_F__c": 100,
                "AutoDiscount__c": 0,
                "Monthly_Price_Before_Discount_S__c": 0,
                "Weekly_Margin_F__c": 0,
                "One_Time_Price_Before_Discount_Display_F__c": 5000,
                "Weekly_Total_Value_Display_F__c": 0,
                "Id": "a0e1a000001KHFwAAO",
                "Discount__c": 83.443709,
                "Unit_Price_F__c": 165.56,
                "LineType__c": "Not tracked on contract",
                "Extended_Price_Display_F__c": 165.56,
                "One_Time_Margin_F__c": 100,
                "Yearly_Discount_Absolute_F__c": 101165.56209,
                "Total_Value_Display_F__c": 49834.44,
                "One_Time_Price_Before_Discount_S__c": 5000,
                "Extended_Price_F__c": 165.56291,
                "Record_Number__c": 1,
                "Total_Price__c": 1000,
                "Unit_Price__c": 165.56291,
                "Monthly_Adjustment1_Absolute_F__c": 0,
                "AutoDiscountType__c": "Percent",
                "Discount_Absolute__c": 834.43709,
                "Yearly_Total_Value_Display_F__c": 49834.44,
                "Price__c": 1000,
                "Yearly_Extended_Price_S__c": 49668.875,
                "Yearly_Price_Before_Discount_S__c": 150000,
                "Yearly_Adjustment1_F__c": 0,
                "Weekly_Unit_Price_F__c": 0,
                "One_Time_Price_Before_Discount_F__c": 5000,
                "PriceType__c": "List",
                "One_Time_Discount_F__c": 0,
                "One_Time_Value_Before_Discount_F__c": 5000,
                "Monthly_Discount_F__c": 0,
                "Weekly_Price_Before_Discount_S__c": 0,
                "Weekly_Extended_Price_S__c": 0,
                "Monthly_Discount_Absolute_F__c": 0,
                "QuoteItemSubLinesNeedApprovalCount__c": 0,
                "Adjustment1Type__c": "Percent",
                "Monthly_Total_Value_F__c": 0,
                "attributes": {
                    "type": "MnQuoteItem__c",
                    "url": "/services/data/v35.0/sobjects/MnQuoteItem__c/a0e1a000001KHFwAAO"
                },
                "_uid": "MnQuoteItem__c",
                "Monthly_Unit_Price_S__c": 0,
                "One_Time_Unit_Price_S__c": 5000,
                "Weekly_Unit_Price_S__c": 0,
                "Yearly_Unit_Price_S__c": 99.33775
            }
        },
        "perf": {
            "totCompTime": 47,
            "evalTime": 6,
            "compileTime": 12,
            "totEvalTime": 41
        },
        "result": {
            "nonqts": {
                "Sid_OG_Regular": {},
                "OG_One_Time": {},
                "Sid_TP_OG": {},
                "Sid_PD_UEV_OG": {},
                "tiers_OG": {}
            },
            "quotes": {
                "Sid_OG_Regular": {
                    "29d9b124-b7c4-4a24-aa13-7e477efe1a39": true
                },
                "OG_One_Time": {},
                "Sid_TP_OG": {},
                "Sid_PD_UEV_OG": {},
                "tiers_OG": {
                    "e4da5f58-8789-47b8-961e-d57c56d792a3": true
                }
            }
        },
        "rules": [],
        "UI": {
            "dbId": "a0J1a0000019ORFEA2",
            "layout": {
                "sections": [
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001hG95EAE",
                        "groups": [
                            "Sid_PD_UEV_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_40aub"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001iwyfEAA",
                        "groups": [
                            "Sid_OG_Regular"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_rlfpa"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001jvLmEAI",
                        "groups": [
                            "tiers_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_kwdqz"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000001kdEOEAY",
                        "groups": [
                            "Sid_TP_OG"
                        ],
                        "name": "&nbsp;",
                        "uid": "OG_c1tn2"
                    },
                    {
                        "collapsed": true,
                        "cssClass": null,
                        "dbId": "a0K1a000003b3cXEAQ",
                        "groups": [
                            "OG_One_Time"
                        ],
                        "name": "New Section",
                        "uid": "OG_aai4g"
                    }
                ]
            },
            "name": "Layout For a0C1a0000016EkqEAE",
            "uid": "a0C1a0000016EkqEAE_Layout_20150707_131229",
            "version": 1
        },
        "uid": "Model_ebr4m",
        "version": 23
    }
}