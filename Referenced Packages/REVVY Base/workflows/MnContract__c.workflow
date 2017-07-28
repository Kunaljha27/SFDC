<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MnSetContractId</fullName>
        <field>ContractId__c</field>
        <formula>ContractNum__c</formula>
        <name>MnSetContractId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MnSetContractId</fullName>
        <actions>
            <name>MnSetContractId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>MnContract__c.AmendmentNumber__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MnContract__c.AmendmentNumber__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>Set Contract ID value for contracts on creation</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
