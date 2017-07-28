{
    "uid": "dynModel_76",
    "UI": {
        "version": 1,
        "uid": "UILayout_76",
        "name": "UI Layout for 76",
        "layout": {
            "sections": [
                {
                    "uid": "UISection_76",
                    "name": "UISection_76",
                    "groups": [
                        "QIS_76"
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
            "name": "bundlediscountrule: QIS_76 --> QIS_76",
            "type": "adjustment",
            "ogFrom": "QIS_76",
            "ogTo": "QIS_76",
            "ruleId": "200_1d127749-636f-405a-99b4-9e02e0fba064",
            "label": "bundlediscountrule",
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
            "QIS_76": {
                "200": true
            }
        },
        "nonqts": {
            "QIS_76": {}
        }
    },
    "pricingInfo": {},
    "perf": {
        "compileTime": 6,
        "evalTime": 3
    },
    "objs": {
        "MnQuote__c": {
            "_uid": "MnQuote__c",
            "attributes": {
                "url": "/services/data/v30.0/sobjects/b1__MnQuote__c/a0Mi0000006VIeEEAW",
                "type": "b1__MnQuote__c"
            },
            "Id": "a0Mi0000006VIeEEAW",
            "b1__Status__c": "Draft",
            "b1__ProposalSignStatus__c": "Not Signed",
            "b1__Segment__c": "General",
            "b1__Currency__c": "USD"
        },
        "Account": {
            "Industry": "Apparel",
            "b1__SLA__c": "Silver",
            "_uid": "Account",
            "Ownership": "Public",
            "attributes": {
                "url": "/services/data/v30.0/sobjects/Account/001i000000RZxodAAD",
                "type": "Account"
            },
            "Id": "001i000000RZxodAAD",
            "b1__MnCurrency__c": "USD",
            "Type": "Customer - Direct",
            "Rating": "Warm",
            "b1__UpsellOpportunity__c": "Maybe",
            "b1__MnSegment__c": "General"
        },
        "Opportunity": {
            "_uid": "Opportunity"
        }
    },
    "name": "Model For Quote 76",
    "groups": {
        "QIS_76": {
            "uitype": "radiobutton",
            "_uid": "QIS_76",
            "type": "regular",
            "showQty": true,
            "_required": false,
            "quoteAttr": "idNode",
            "_quotable": true,
            "options": [
                {
                    "_userSelected": true,
                    "unitPrice": 86,
                    "_uid": "200",
                    "qty": 1,
                    "_price": 100,
                    "name": "balajibundle_200",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "balajibundle",
                    "dbId": "a04i0000007pkOfAAI",
                    "_idNodeRef": "balajibundle",
                    "priceFreq": "Yearly",
                    "path": [],
                    "listprice": 0,
                    "idNode": "balajibundle",
                    "attributes": {},
                    "_available": true,
                    "_errors": {},
                    "_selected": true,
                    "_adjustmentMapping": {
                        "rulesDecisions": {
                            "200_1d127749-636f-405a-99b4-9e02e0fba064": [
                                {
                                    "autoadj1": {
                                        "label": "bundleisdiscounted",
                                        "t": "perc",
                                        "v": 14
                                    }
                                }
                            ]
                        },
                        "originalValues": {}
                    },
                    "_ruleSetAttribute": {
                        "autoadj1": true
                    },
                    "autoadj1": {
                        "label": "bundleisdiscounted",
                        "t": "perc",
                        "v": 14
                    }
                }
            ],
            "optionLabelField": "label",
            "_multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 76",
            "idNodeRef": null,
            "description": "",
            "defaultVisibility": true,
            "dbId": null,
            "_visible": true,
            "_adjustmentMapping": {
                "mapping": {
                    "200_1d127749-636f-405a-99b4-9e02e0fba064": {
                        "attributes": {},
                        "conditionsList": [
                            {
                                "t": [
                                    {
                                        "a": "_uid",
                                        "set": {
                                            "autoadj1": {
                                                "label": "bundleisdiscounted",
                                                "t": "perc",
                                                "v": 14
                                            }
                                        },
                                        "g": "QIS_76",
                                        "v": "200"
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
                    "200": true
                },
                "selectedCount": 1
            },
            "_availability": {
                "availableOptions": {
                    "200": true
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