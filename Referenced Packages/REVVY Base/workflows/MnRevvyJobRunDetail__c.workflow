<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Job_Process_Notification</fullName>
        <description>Job Process Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Rebate_Email_Templates/Job_Process_Notifications</template>
    </alerts>
    <rules>
        <fullName>Job Process Notifications</fullName>
        <actions>
            <name>Job_Process_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>MnRevvyJobRunDetail__c.Status__c</field>
            <operation>equals</operation>
            <value>FINISHED,FAILED,PARTITAL_FINISHED</value>
        </criteriaItems>
        <criteriaItems>
            <field>MnRevvyJobRunDetail__c.Type__c</field>
            <operation>equals</operation>
            <value>User</value>
        </criteriaItems>
        <description>Send me a notification whenever a revvy jobs status changes so I can see the progress of a rebate calculation</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
