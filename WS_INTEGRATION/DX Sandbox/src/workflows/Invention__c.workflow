<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EIR_Format</fullName>
        <description>Format number field to match XXXXXXX-XX-XXXX (all numbers).</description>
        <field>EIR_Number__c</field>
        <formula>IF( LEN(  SUBSTITUTE( SUBSTITUTE( Invention_Report_Number_EIR__c , &quot;-&quot;,&quot;&quot;) , &quot; &quot;,&quot;&quot;)  ) = 13,
LEFT(Invention_Report_Number_EIR__c , 7) &amp; &quot;-&quot; &amp;  MID(Invention_Report_Number_EIR__c , 8, 2) &amp; &quot;-&quot; &amp; MID(Invention_Report_Number_EIR__c , 10, 4),
Invention_Report_Number_EIR__c )</formula>
        <name>EIR Format</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>On_Hold_False</fullName>
        <field>On_Hold__c</field>
        <literalValue>0</literalValue>
        <name>On Hold False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>iEdison_Reporting_Required</fullName>
        <description>Check to TRUE</description>
        <field>iEdison_Reporting_Required__c</field>
        <literalValue>1</literalValue>
        <name>iEdison Reporting Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Closeout On Hold</fullName>
        <actions>
            <name>On_Hold_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invention__c.Close_Invention__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Changes On Hold to false if the invention is marked as closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Create Federally Funded Invention</fullName>
        <actions>
            <name>iEdison_Reporting_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invention__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Invention - Federally Funded</value>
        </criteriaItems>
        <description>Defaults the iEdison Reporting Required box to TRUE when an invention is created of the type Federally Funded invention. Only triggers on create.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>EIR Format</fullName>
        <actions>
            <name>EIR_Format</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Invention__c.Invention_Report_Number_EIR__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Automatically formats the field. XXXXXXX-XX-XXXX (all numbers)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
