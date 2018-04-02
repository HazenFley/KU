<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Activity_Type_Workaround_Event</fullName>
        <description>Workaround to get activity type to appear in custom reports</description>
        <field>Activity_Type_Workaround__c</field>
        <formula>TEXT(Type)</formula>
        <name>Activity Type Workaround: Event</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activity Type Workaround%3A Event</fullName>
        <actions>
            <name>Activity_Type_Workaround_Event</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Workaround to get activity type to appear in custom reports</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
