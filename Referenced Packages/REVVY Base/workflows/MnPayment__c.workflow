<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Rebate_Payment_Notification</fullName>
        <description>Rebate Payment Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Rebate_Email_Templates/Rebate_Payment_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>MnPaymentDraft</fullName>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>MnPaymentDraft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Rebate Payment Due Notification</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MnPayment__c.Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>Send me notification of rebate payments that are still in draft status that still need to be released for payment 5 days before the payment due date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
