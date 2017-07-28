<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MnSetNeedApproval</fullName>
        <description>sets need approval flag on quote item.</description>
        <field>NeedsApproval__c</field>
        <literalValue>1</literalValue>
        <name>MnSetNeedApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MnUnSetNeedApproval</fullName>
        <description>un-checks need approval flag on quote item</description>
        <field>NeedsApproval__c</field>
        <literalValue>0</literalValue>
        <name>MnUnSetNeedApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MnFlagApproval</fullName>
        <actions>
            <name>MnSetNeedApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>MnQuoteItem__c.Discount__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <description>Default workflow rule to set a quote to go through approval. This sets needs approval flag if discount is &gt; 10%</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MnUnFlagApproval</fullName>
        <actions>
            <name>MnUnSetNeedApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>MnQuoteItem__c.Discount__c</field>
            <operation>lessOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <description>remove needs approval flag if discount is reduced down to be lower than 10%</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
