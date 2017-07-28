{
    "uid": "dynModel_9",
    "UI": {
        "version": 1,
        "uid": "UILayout_9",
        "name": "UI Layout for 9",
        "layout": {
            "sections": [
                {
                    "uid": "UISection_9",
                    "name": "UISection_9",
                    "groups": [
                        "QIS_9"
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
            "name": "TenPercentDiscount: QIS_9 --> QIS_9",
            "type": "adjustment",
            "ogFrom": "QIS_9",
            "ogTo": "QIS_9",
            "ruleId": "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2",
            "label": "TenPercentDiscount",
            "ctype": "g",
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
            "QIS_9": {
                "5": true
            }
        },
        "nonqts": {
            "QIS_9": {}
        }
    },
    "pricingInfo": {},
    "perf": {
        "compileTime": 16,
        "evalTime": 3
    },
    "objs": {
        "MnQuote__c": {
            "_uid": "MnQuote__c",
            "attributes": {
                "url": "/services/data/v31.0/sobjects/kkashyap__MnQuote__c/a0co0000000jpa4AAA",
                "type": "kkashyap__MnQuote__c"
            },
            "Id": "a0co0000000jpa4AAA",
            "kkashyap__ProposalSignStatus__c": "Not Signed",
            "kkashyap__Status__c": "Draft",
            "kkashyap__Currency__c": "USD",
            "kkashyap__Segment__c": "General"
        },
        "Account": {
            "Industry": "Apparel",
            "_uid": "Account",
            "Ownership": "Public",
            "attributes": {
                "url": "/services/data/v31.0/sobjects/Account/001o0000002z6eoAAA",
                "type": "Account"
            },
            "Id": "001o0000002z6eoAAA",
            "Type": "Customer - Direct",
            "Rating": "Warm",
            "kkashyap__SLA__c": "Silver",
            "kkashyap__UpsellOpportunity__c": "Maybe"
        },
        "Opportunity": {
            "_uid": "Opportunity"
        }
    },
    "name": "Model For Quote 9",
    "groups": {
        "QIS_9": {
            "uitype": "radiobutton",
            "_uid": "QIS_9",
            "type": "regular",
            "showQty": true,
            "_required": false,
            "quoteAttr": "idNode",
            "_quotable": true,
            "options": [
                {
                    "_userSelected": true,
                    "unitPrice": 20,
                    "_uid": "5",
                    "qty": 1,
                    "listPrice": 20,
                    "name": "QAProduct14_5",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "QAProduct14",
                    "dbId": "a0Bo0000000GS1wEAG",
                    "_idNodeRef": "QAProduct14",
                    "priceFreq": "One Time",
                    "path": [],
                    "listprice": 0,
                    "idNode": "QAProduct14",
                    "attributes": {},
                    "_available": true,
                    "_errors": {},
                    "_selected": true,
                    "_adjustmentMapping": {
                        "votes": {
                            "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": {
                                "QIS_9.idNode": {
                                    "g": "QIS_9",
                                    "vals": {
                                        "5": "QAProduct14"
                                    }
                                }
                            }
                        },
                        "rulesDecisions": {
                            "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": []
                        },
                        "originalValues": {}
                    },
                    "_ruleSetAttribute": {}
                }
            ],
            "optionLabelField": "label",
            "_multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 9",
            "idNodeRef": null,
            "description": "",
            "defaultVisibility": true,
            "dbId": null,
            "_visible": true,
            "_adjustmentMapping": {
                "mapping": {
                    "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": {
                        "attributes": {
                            "QIS_9": [
                                "idNode"
                            ]
                        },
                        "conditionsList": [
                            {
                                "t": [
                                    {
                                        "a": "_uid",
                                        "set": {
                                            "autoadj1": {
                                                "label": null,
                                                "t": "perc",
                                                "v": 10
                                            }
                                        },
                                        "g": "QIS_9",
                                        "v": "5"
                                    }
                                ],
                                "c": [
                                    {
                                        "a": "idNode",
                                        "g": "QIS_9",
                                        "v": "QAProduct2",
                                        "condition": "QIS_9.idNode"
                                    }
                                ]
                            }
                        ]
                    }
                }
            },
            "_errors": {},
            "_selects": {
                "selectedOptions": {
                    "5": true
                },
                "selectedCount": 1
            },
            "_availability": {
                "availableOptions": {
                    "5": true
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
    "version": 13.9
}