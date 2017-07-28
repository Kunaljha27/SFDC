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
            "type": "adjustment",
            "name": "5_c97429e3-d232-4cb7-83b3-18b9b0f767f2",
            "label": "TenPercentDiscount",
            "filters": [
                {
                    "g": "QIS_9"
                },
                {},
                {
                    "g": null
                }
            ],
            "dbId": "a0Ko0000000kBouEAE",
            "data": {
                "rows": [
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
                                "v": "QAProduct2"
                            }
                        ]
                    }
                ],
                "default": false
            },
            "action": null
        }
    ],
    "result": null,
    "pricingInfo": null,
    "perf": null,
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
            "uid": "QIS_9",
            "type": "regular",
            "showQty": true,
            "required": false,
            "quoteAttr": "idNode",
            "quotable": true,
            "options": [
                {
                    "userSelected": true,
                    "unitPrice": 20,
                    "uid": "5",
                    "qty": 1,
                    "price": 20,
                    "name": "QAProduct14_5",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "Option QAProduct14_5",
                    "idNodeRef": "QAProduct14",
                    "dbId": null,
                    "attributeValues": {}
                }
            ],
            "optionLabelField": "label",
            "multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 9",
            "idNodeRef": null,
            "description": "",
            "defaultVisibility": true,
            "dbId": null
        }
    },
    "exprs": [],
    "errors": null,
    "dbId": null,
    "catalog": {
        "products": [
            {
                "qty": 1,
                "priceFreq": "One Time",
                "path": [],
                "listprice": 0,
                "label": "QAProduct14",
                "idNode": "QAProduct14",
                "dbId": "a0Bo0000000GS1wEAG",
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
                "label": "QAProduct14",
                "idNode": "QAProduct14",
                "dbId": "a0Bo0000000GS1wEAG",
                "attributeValues": {},
                "attributes": {}
            }
        ],
        "categories": [],
        "attributes": []
    }
}