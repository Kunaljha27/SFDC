<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>RuleOGJnImport</label>
    <protected>false</protected>
    <values>
        <field>BatchSize__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Custom_Object_Name__c</field>
        <value xsi:type="xsd:string">REVVY__MnConfigEngineRuleOptionGroupJunction__c</value>
    </values>
    <values>
        <field>External_Id__c</field>
        <value xsi:type="xsd:string">Id</value>
    </values>
    <values>
        <field>NeedUpsert__c</field>
        <value xsi:type="xsd:boolean">false</value>
    </values>
    <values>
        <field>Product_Where_Clause__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Sequence__c</field>
        <value xsi:type="xsd:double">28.0</value>
    </values>
    <values>
        <field>Upsert_Field__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Where_Clause__c</field>
        <value xsi:type="xsd:string">where revvy__rule__c in (Select  r.REVVY__Rule_Id__c From REVVY__MnConfigEngineModelRuleJunction__c r where REVVY__Model_Id__r.REVVY__Id__c = &apos;@REVVYID&apos;)</value>
    </values>
</CustomMetadata>
