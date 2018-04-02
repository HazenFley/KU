<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CP_EE_Check</fullName>
        <description>Checks the CP/EE Ownership checkbox</description>
        <field>Corporate_Partnership_Ownership__c</field>
        <literalValue>1</literalValue>
        <name>CP/EE Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_CP_Ownership</fullName>
        <field>Corporate_Partnership_Ownership__c</field>
        <literalValue>1</literalValue>
        <name>Contact: CP Ownership</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Contact%3A Econ Dev Creation</fullName>
        <actions>
            <name>Contact_CP_Ownership</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>Economic Development</value>
        </criteriaItems>
        <description>If the contact is created or edited by someone in Economic Development, then the Corporate Partnership field is automatically checked.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>EE Creation Check</fullName>
        <actions>
            <name>CP_EE_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>Corporate Partnerships</value>
        </criteriaItems>
        <description>Marks a contact as being owned by Corporate Partnerships / Economic Engagement when the owner of the contact is a member of that group.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
