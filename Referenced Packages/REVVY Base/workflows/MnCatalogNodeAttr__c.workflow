<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Unique_Identifier</fullName>
        <field>Id__c</field>
        <formula>Catalog_Node__r.Id__c &amp; &apos;_&apos; &amp;
                 Catalog_Attribute__r.Id__c</formula>
        <name>Set Unique Identifier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Unique Identifier</fullName>
        <actions>
            <name>Set_Unique_Identifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
