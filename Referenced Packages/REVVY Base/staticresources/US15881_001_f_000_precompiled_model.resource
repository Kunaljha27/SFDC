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
            "type": "adjustment",
            "name": "200_1d127749-636f-405a-99b4-9e02e0fba064",
            "label": "bundlediscountrule",
            "filters": [
                {
                    "g": "QIS_76"
                },
                {
                    "g": null
                }
            ],
            "dbId": "a0Di000000Hj5Z9EAJ",
            "data": {
                "rows": [
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
            "uid": "QIS_76",
            "type": "regular",
            "showQty": true,
            "required": false,
            "quoteAttr": "idNode",
            "quotable": true,
            "options": [
                {
                    "userSelected": true,
                    "unitPrice": 100,
                    "uid": "200",
                    "qty": 1,
                    "price": 100,
                    "name": "balajibundle_200",
                    "manAdj": {
                        "t": "perc",
                        "v": 0
                    },
                    "label": "Option balajibundle_200",
                    "idNodeRef": "balajibundle",
                    "dbId": null,
                    "attributeValues": {}
                }
            ],
            "optionLabelField": "label",
            "multiSelect": true,
            "methods": null,
            "label": "Quote Items for Quote 76",
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
                "priceFreq": "Yearly",
                "path": [],
                "listprice": 0,
                "label": "balajibundle",
                "idNode": "balajibundle",
                "dbId": "a04i0000007pkOfAAI",
                "attributeValues": {},
                "attributes": {}
            }
        ],
        "prodSet": [
            {
                "qty": 1,
                "priceFreq": "Yearly",
                "path": [],
                "listprice": 0,
                "label": "balajibundle",
                "idNode": "balajibundle",
                "dbId": "a04i0000007pkOfAAI",
                "attributeValues": {},
                "attributes": {}
            }
        ],
        "categories": [],
        "attributes": []
    }
}