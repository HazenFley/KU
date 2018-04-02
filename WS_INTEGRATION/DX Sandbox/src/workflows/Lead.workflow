<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>a0Gi000000MFjhNEAT_Purge</fullName>
        <active>false</active>
        <description>Lead.a0Gi000000MFjhNEAT_Purge</description>
        <formula>OR(ISCHANGED(Street),ISCHANGED(City),ISCHANGED(State),ISCHANGED(PostalCode),ISCHANGED(Country))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
