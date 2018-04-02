<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Activity_Type_Workaround_Task</fullName>
        <description>Activity Type Workaround: Task</description>
        <field>Activity_Type_Workaround__c</field>
        <formula>TEXT(Type)</formula>
        <name>Activity Type Workaround: Task</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_Subtype</fullName>
        <description>Pulls the Task Subtype into a different field for reporting purposes.
https://help.salesforce.com/articleView?id=000004232&amp;language=en_US&amp;type=1</description>
        <field>Activity_Type_Workaround__c</field>
        <formula>TEXT(Type)</formula>
        <name>Task Subtype</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pardot_Record_Type</fullName>
        <description>Updates the record type to Marketing Email when the Subject contains Pardot</description>
        <field>RecordTypeId</field>
        <lookupValue>Marketing_Email</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Pardot Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activity Type Workaround%3A Task</fullName>
        <actions>
            <name>Activity_Type_Workaround_Task</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Workaround to get activity type to appear in custom reports</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
