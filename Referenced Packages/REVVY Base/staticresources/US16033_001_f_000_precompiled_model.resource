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
            "type": "adjustment",
            "name": "25_879ff32a-01bc-492f-80e9-d0b205283e53",
            "label": "QARule1",
            "filters": [
                {
                    "g": "QIS_13"
                },
                {
                    "g": null
                }
            ],
            "dbId": "a0DF000000I1tiSMAR",
            "data": {
                "rows": [
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
            "uid": "QIS_13",
            "type": "regular",
            "showQty": true,
            "required": false,
            "quoteAttr": "idNode",
            "quotable": true,
            "options": [
                {
                    "userSelected": true,
                    "unitPrice": 10,
                    "uid": "25",
                    "qty": 1,
                    "price": 10,
                    "name": "QAProduct1_25",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "Option QAProduct1_25",
                    "idNodeRef": "QAProduct1",
                    "dbId": null,
                    "attributeValues": {}
                }
            ],
            "optionLabelField": "label",
            "multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 13",
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
                "label": "QAProduct1",
                "idNode": "QAProduct1",
                "dbId": "a04F000000ci4AkIAI",
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
                "label": "QAProduct1",
                "idNode": "QAProduct1",
                "dbId": "a04F000000ci4AkIAI",
                "attributeValues": {},
                "attributes": {}
            }
        ],
        "categories": [],
        "attributes": []
    }
}