<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Check_CP_Ownership</fullName>
        <field>Corporate_Partnership_Ownership__c</field>
        <literalValue>1</literalValue>
        <name>Check CP Ownership</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KUIC_Ownership</fullName>
        <field>KUIC_Ownership__c</field>
        <literalValue>1</literalValue>
        <name>KUIC Ownership</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>KUIC Ownership</fullName>
        <actions>
            <name>KUIC_Ownership</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>Licensing &amp; Tech Transfer</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>KUIC</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>Economic Development</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>a0Gi000000MFjhLEAT_Purge</fullName>
        <active>false</active>
        <description>Account.a0Gi000000MFjhLEAT_Purge</description>
        <formula>OR(ISCHANGED(BillingStreet),ISCHANGED(BillingCity),ISCHANGED(BillingState),ISCHANGED(BillingPostalCode),ISCHANGED(BillingCountry))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
