<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_RU_Main_Count_to_1</fullName>
        <description>RU Main Count Should Always Be 1</description>
        <field>RU_MainCount__c</field>
        <formula>1</formula>
        <name>Set RU Main Count to 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>RU Main Count Should Always Be 1</fullName>
        <actions>
            <name>Set_RU_Main_Count_to_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>RU Main Count Should Always Be 1</description>
        <formula>RU_MainCount__c &lt;&gt; 1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
