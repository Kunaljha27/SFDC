<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Attribute_Value_Set_Name_Field</fullName>
        <field>Name</field>
        <formula>IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Text&apos;), Value__c, 
    IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Boolean&apos;),  IF(Value_Boolean__c,&apos;Yes&apos;,&apos;No&apos;),
     IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Decimal&apos;),  TEXT(Value_Number__c),
     IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Integer&apos;),  TEXT(Floor(Value_Number__c)),
      IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Range&apos;), TEXT(Value_Min__c) &amp; &apos; - &apos; &amp; TEXT(Value_Max__c),
   Value__c)))))</formula>
        <name>Attribute Value Set Name Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Attribute_Value_Set_Name_Field_Boolean</fullName>
        <field>Name</field>
        <formula>IF(Value_Boolean__c, &apos;Yes&apos;,&apos;No&apos;)</formula>
        <name>Attribute Value Set Name Field Boolean</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Unique_Identifier</fullName>
        <field>Id__c</field>
        <formula>Catalog_Attribute__r.Id__c &amp; &apos;_&apos; &amp;
IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Text&apos;), Value__c,
IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Boolean&apos;), IF(Value_Boolean__c,&apos;Yes&apos;,&apos;No&apos;),
IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Integer&apos;), TEXT(Floor(Value_Number__c)),
IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Decimal&apos;), TEXT(Value_Number__c),
IF(ISPICKVAL(Catalog_Attribute__r.Format__c ,&apos;Range&apos;), TEXT(Value_Min__c) &amp; &apos; - &apos; &amp; TEXT(Value_Max__c),
Value__c)))))</formula>
        <name>Set Unique Identifier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Attribute Value Set Name Field</fullName>
        <actions>
            <name>Attribute_Value_Set_Name_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(Catalog_Attribute__r.Format__c, &apos;Text&apos;) &amp;&amp; Name != Value__c ||   ISPICKVAL(Catalog_Attribute__r.Format__c, &apos;Boolean&apos;) &amp;&amp; Name != IF(Value_Boolean__c,&apos;Yes&apos;,&apos;No&apos;) ||  ISPICKVAL(Catalog_Attribute__r.Format__c, &apos;Decimal&apos;)&amp;&amp; Name !=TEXT(Value_Number__c) ||   ISPICKVAL(Catalog_Attribute__r.Format__c, &apos;Integer&apos;)&amp;&amp; Name !=TEXT(FLOOR(Value_Number__c)) ||  ISPICKVAL(Catalog_Attribute__r.Format__c, &apos;Range&apos;) &amp;&amp; Name !=(TEXT(Value_Min__c) &amp; &apos; - &apos; &amp; TEXT(Value_Max__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
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
