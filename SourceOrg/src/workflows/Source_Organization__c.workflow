<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Uncheck_PrimarySourceOrg</fullName>
        <description>Uncheck PrimarySourceOrg Checkbox - This will impact the PrimarySourceOrg Flag and in turn the rollup Primary Source Org Count on MasterOrg</description>
        <field>Primary_Source_Org__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck PrimarySourceOrg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Master Already Has A Primary Source Org</fullName>
        <actions>
            <name>Uncheck_PrimarySourceOrg</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If a MasterOrg already has Primary Source Org and a newly created SourceOrg has the PrimarySourceOrg flag checked, uncheck this flag.</description>
        <formula>AND( Master_Organization__r.Primary_Source_Org_Count__c = 1, Id &lt;&gt;  Master_Organization__r.Primary_Source_Org_Id__c, Primary_Source_Org__c = True)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
