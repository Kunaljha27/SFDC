{
    "uid": "dynModel_13",
    "UI": {
        "version": 1,
        "uid": "UILayout_13",
        "name": "UI Layout for 13",
        "layout": {
            "sections": [
                {
                    "uid": "UISection_13",
                    "name": "UISection_13",
                    "groups": [
                        "QIS_13"
                    ],
                    "dbId": null,
                    "cssClass": null,
                    "collapsed": true
                }
            ]
        },
        "dbId": null
    },
    "rules": [
        {
            "name": "QARule1: QIS_13 --> QIS_13",
            "type": "adjustment",
            "ogFrom": "QIS_13",
            "ogTo": "QIS_13",
            "ruleId": "25_879ff32a-01bc-492f-80e9-d0b205283e53",
            "label": "QARule1",
            "ctype": "none",
            "filters": [
                {
                    "group": "Result"
                },
                {
                    "group": "PricingInfo"
                }
            ]
        }
    ],
    "result": {
        "quotes": {
            "QIS_13": {
                "25": true
            }
        },
        "nonqts": {
            "QIS_13": {}
        }
    },
    "pricingInfo": {},
    "perf": {
        "compileTime": 4,
        "evalTime": 2
    },
    "objs": {
        "MnQuote__c": {
            "krishna85__Status__c": "Draft",
            "_uid": "MnQuote__c",
            "krishna85__Segment__c": "General",
            "attributes": {
                "url": "/services/data/v30.0/sobjects/krishna85__MnQuote__c/a0UF000000S76JeMAJ",
                "type": "krishna85__MnQuote__c"
            },
            "Id": "a0UF000000S76JeMAJ",
            "krishna85__ProposalSignStatus__c": "Not Signed",
            "krishna85__Currency__c": "USD"
        },
        "Account": {
            "Industry": "Apparel",
            "_uid": "Account",
            "Ownership": "Public",
            "attributes": {
                "url": "/services/data/v30.0/sobjects/Account/001F0000015ET8pIAG",
                "type": "Account"
            },
            "Id": "001F0000015ET8pIAG",
            "krishna85__SLA__c": "Silver",
            "krishna85__UpsellOpportunity__c": "Maybe",
            "Type": "Customer - Direct",
            "Rating": "Warm"
        },
        "Opportunity": {
            "_uid": "Opportunity"
        }
    },
    "name": "Model For Quote 13",
    "groups": {
        "QIS_13": {
            "uitype": "radiobutton",
            "_uid": "QIS_13",
            "type": "regular",
            "showQty": true,
            "_required": false,
            "quoteAttr": "idNode",
            "_quotable": true,
            "options": [
                {
                    "_userSelected": true,
                    "unitPrice": 9,
                    "_uid": "25",
                    "qty": 1,
                    "listPrice": 10,
                    "name": "QAProduct1_25",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "QAProduct1",
                    "dbId": "a04F000000ci4AkIAI",
                    "_idNodeRef": "QAProduct1",
                    "priceFreq": "One Time",
                    "path": [],
                    "listprice": 0,
                    "idNode": "QAProduct1",
                    "attributes": {},
                    "_available": true,
                    "_errors": {},
                    "_selected": true,
                    "_adjustmentMapping": {
                        "rulesDecisions": {
                            "25_879ff32a-01bc-492f-80e9-d0b205283e53": [
                                {
                                    "autoadj1": {
                                        "label": "Discount Rule1",
                                        "t": "perc",
                                        "v": 10
                                    }
                                }
                            ]
                        },
                        "originalValues": {
                            "autoadj1": null
                        }
                    },
                    "_ruleSetAttribute": {
                        "autoadj1": true
                    },
                    "autoadj1": {
                        "label": "Discount Rule1",
                        "t": "perc",
                        "v": 10
                    }
                }
            ],
            "optionLabelField": "label",
            "_multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 13",
            "idNodeRef": null,
            "description": "",
            "defaultVisibility": true,
            "dbId": null,
            "_visible": true,
            "_adjustmentMapping": {
                "mapping": {
                    "25_879ff32a-01bc-492f-80e9-d0b205283e53": {
                        "attributes": {},
                        "conditionsList": [
                            {
                                "t": [
                                    {
                                        "a": "_uid",
                                        "set": {
                                            "autoadj1": {
                                                "label": "Discount Rule1",
                                                "t": "perc",
                                                "v": 10
                                            }
                                        },
                                        "g": "QIS_13",
                                        "v": "25"
                                    }
                                ],
                                "c": []
                            }
                        ]
                    }
                }
            },
            "_errors": {},
            "_selects": {
                "selectedOptions": {
                    "25": true
                },
                "selectedCount": 1
            },
            "_availability": {
                "availableOptions": {
                    "25": true
                },
                "availableCount": 1
            }
        }
    },
    "exprs": [],
    "errors": {
        "values": []
    },
    "dbId": null,
    "version": 12
}