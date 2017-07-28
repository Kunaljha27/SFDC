{
    "sendDiff": false,
    "step": {
        "groups": {
            "QIS_9": {
                "options": [
                    {
                        "attributes": {},
                        "_userSelected": true,
                        "_errors": {},
                        "path": [],
                        "name": "QAProduct14_5",
                        "priceFreq": "One Time",
                        "_selected": true,
                        "_ruleSetAttribute": {},
                        "listPrice": 20,
                        "idNode": "QAProduct14",
                        "_idNodeRef": "QAProduct14",
                        "_uid": "5",
                        "label": "QAProduct14",
                        "qty": 1,
                        "unitPrice": 20,
                        "listprice": 0,
                        "manAdj": {
                            "t": "perc",
                            "v": 0
                        },
                        "_available": true,
                        "dbId": "a0Bo0000000GS1wEAG",
                        "_adjustmentMapping": {
                            "votes": {
                                "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": {
                                    "QIS_9.idNode": {
                                        "vals": {
                                            "5": "QAProduct14"
                                        },
                                        "g": "QIS_9"
                                    }
                                }
                            },
                            "rulesDecisions": {
                                "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": []
                            },
                            "originalValues": {}
                        }
                    },
                    {
                        "userSelected": true,
                        "unitPrice": null,
                        "uid": "6",
                        "qty": 1,
                        "price": null,
                        "name": "QAProduct2_6",
                        "manAdj": {
                            "t": "perc",
                            "v": 0
                        },
                        "label": "Option QAProduct2_6",
                        "idNodeRef": "QAProduct2",
                        "dbId": null,
                        "attributeValues": {}
                    }
                ],
                "defaultVisibility": true,
                "quoteAttr": "idNode",
                "_errors": {},
                "uitype": "radiobutton",
                "_quotable": true,
                "description": "",
                "optionLabelField": "label",
                "_multiSelect": true,
                "_selects": {
                    "selectedOptions": {
                        "5": true
                    },
                    "selectedCount": 1
                },
                "type": "regular",
                "idNodeRef": null,
                "_uid": "QIS_9",
                "label": "Quote Items for Quote 9",
                "_required": false,
                "showQty": true,
                "_availability": {
                    "availableCount": 1,
                    "availableOptions": {
                        "5": true
                    }
                },
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
                                    "c": [
                                        {
                                            "a": "idNode",
                                            "condition": "QIS_9.idNode",
                                            "v": "QAProduct2",
                                            "g": "QIS_9"
                                        }
                                    ],
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
                                            "v": "5",
                                            "g": "QIS_9"
                                        }
                                    ]
                                }
                            ]
                        }
                    }
                },
                "methods": null
            }
        },
        "exprs": [],
        "name": "Model For Quote 9",
        "perf": {
            "totCompTime": 61,
            "evalTime": 3,
            "compileTime": 16
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
        "errors": {
            "values": []
        },
        "version": 13,
        "rules": [
            {
                "filters": [
                    {
                        "group": "Result"
                    },
                    {
                        "group": "PricingInfo"
                    }
                ],
                "type": "adjustment",
                "label": "TenPercentDiscount",
                "ctype": "g",
                "ruleId": "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2",
                "name": "TenPercentDiscount: QIS_9 --> QIS_9",
                "ogFrom": "QIS_9",
                "ogTo": "QIS_9"
            }
        ],
        "UI": {
            "version": 1,
            "layout": {
                "sections": [
                    {
                        "collapsed": true,
                        "groups": [
                            "QIS_9"
                        ],
                        "cssClass": null,
                        "name": "UISection_9",
                        "dbId": null,
                        "uid": "UISection_9"
                    }
                ]
            },
            "name": "UI Layout for 9",
            "dbId": null,
            "uid": "UILayout_9"
        },
        "catalog": {
            "products": [
                {
                    "qty": 1,
                    "priceFreq": "One Time",
                    "path": [],
                    "listprice": 0,
                    "label": "QAProduct2",
                    "idNode": "QAProduct2",
                    "dbId": "a0Bo0000000GS26EAG",
                    "attributeValues": {},
                    "attributes": {}
                }
            ],
            "prodSet": [
                {
                    "qty": 1,
                    "priceFreq": "One Time",
                    "path": [],
                    "listprice": 0,
                    "label": "QAProduct2",
                    "idNode": "QAProduct2",
                    "dbId": "a0Bo0000000GS26EAG",
                    "attributeValues": {},
                    "attributes": {}
                }
            ],
            "categories": [],
            "attributes": []
        },
        "result": {
            "nonqts": {
                "QIS_9": {}
            },
            "quotes": {
                "QIS_9": {
                    "5": true
                }
            }
        },
        "dbId": null,
        "uid": "dynModel_9"
    },
    "result": {
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
                    "5": true,
                    "6": true
                }
            },
            "nonqts": {
                "QIS_9": {}
            }
        },
        "pricingInfo": {},
        "perf": {
            "compileTime": 16,
            "evalTime": 2
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
                        "unitPrice": 18,
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
                                            "5": "QAProduct14",
                                            "6": "QAProduct2"
                                        }
                                    }
                                }
                            },
                            "rulesDecisions": {
                                "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2": [
                                    {
                                        "autoadj1": {
                                            "label": null,
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
                            "label": null,
                            "t": "perc",
                            "v": 10
                        }
                    },
                    {
                        "_userSelected": true,
                        "unitPrice": null,
                        "_uid": "6",
                        "qty": 1,
                        "listPrice": null,
                        "name": "QAProduct2_6",
                        "manAdj": {
                            "t": "perc",
                            "v": 0
                        },
                        "label": "QAProduct2",
                        "dbId": "a0Bo0000000GS26EAG",
                        "_idNodeRef": "QAProduct2",
                        "priceFreq": "One Time",
                        "path": [],
                        "listprice": 0,
                        "idNode": "QAProduct2",
                        "attributes": {},
                        "_available": true,
                        "_errors": {
                            "MISSING_PRICE": {}
                        },
                        "_selected": true
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
                        "5": true,
                        "6": true
                    },
                    "selectedCount": 2
                },
                "_availability": {
                    "availableOptions": {
                        "5": true,
                        "6": true
                    },
                    "availableCount": 2
                }
            }
        },
        "exprs": [],
        "errors": {
            "values": [
                {
                    "g": "QIS_9",
                    "o": "6"
                }
            ]
        },
        "dbId": null,
        "version": 13.9
    }
}