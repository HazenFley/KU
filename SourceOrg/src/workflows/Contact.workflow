<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Primary_Email_From_Supplied_Email</fullName>
        <description>Set Primary Email From Supplied Email</description>
        <field>Email</field>
        <formula>Supplied_Email__c</formula>
        <name>Set Primary Email From Supplied Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Primary Email From Supplied Email</fullName>
        <actions>
            <name>Set_Primary_Email_From_Supplied_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Primary Email From Supplied Email When Contact is Created or When Supplied Email is edited and standard Email field is still blank</description>
        <formula>AND(ISCHANGED(Supplied_Email__c),ISBLANK(Email))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
