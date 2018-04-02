<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MALatitude_c_Purge</fullName>
        <field>MALatitude__c</field>
        <name>Account.MALatitude_c_Purge</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MALongitude_c_Purge</fullName>
        <field>MALongitude__c</field>
        <name>Account.MALongitude_c_Purge</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_FTE_in_Kansas</fullName>
        <description>Account: # Company FTE Located In Kansas</description>
        <field>N_Company_FTE_Located_In_Kansas__c</field>
        <formula>Formula_FTE_In_Kansas__c</formula>
        <name>Set FTE in Kansas</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Location_FTE_Details</fullName>
        <description>Set Location FTE Details</description>
        <field>N_Company_FTE_Located_In_Region_OK_MO__c</field>
        <formula>DandbCompany.EmployeesHere</formula>
        <name>Set Location FTE Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Master_RA_In_Place_As_True</fullName>
        <description>Set Master RA In Place As True</description>
        <field>Is_Master_RA_In_Place__c</field>
        <literalValue>1</literalValue>
        <name>Set Master RA In Place As True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Strategic_Hiring_Partner_As_True</fullName>
        <description>Set Strategic Hiring Partner As True</description>
        <field>Is_KU_A_Strategic_Hiring_Partner__c</field>
        <literalValue>1</literalValue>
        <name>Set Strategic Hiring Partner As True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Valuation_Ration_History_Tracking_Fi</fullName>
        <description>Set Valuation Ration History Tracking Field Value</description>
        <field>Valuation_Ratio_History_Tracking__c</field>
        <formula>Valuation_Ratio__c</formula>
        <name>Set Valuation Ration History Tracking Fi</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_ED_Score</fullName>
        <field>Total_ED_Score__c</field>
        <formula>Ratio_Weight_ED_1__c +
Ratio_Weight_ED_2__c +
Ratio_Weight_ED_3__c +
Ratio_Weight_ED_4__c +
Ratio_Weight_ED_5__c +
Ratio_Weight_ED_6__c +
Ratio_Weight_ED_7__c +
Ratio_Weight_ED_8__c</formula>
        <name>Update Total ED Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_ITE_Score</fullName>
        <field>Total_ITE_Score__c</field>
        <formula>Ratio_Weight_ITE_1__c +
Ratio_Weight_ITE_2__c</formula>
        <name>Update Total ITE Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_KT_Score</fullName>
        <field>Total_KT_Score__c</field>
        <formula>Ratio_Weight_KT_1__c +
Ratio_Weight_KT_2__c +
Ratio_Weight_KT_3__c +
Ratio_Weight_KT_4__c +
Ratio_Weight_KT_5__c +
Ratio_Weight_KT_6__c +
Ratio_Weight_KT_7__c +
Ratio_Weight_KT_8__c</formula>
        <name>Update Total KT Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_PC_Score</fullName>
        <field>Total_PC_Score__c</field>
        <formula>Ratio_Weight_PC_1__c +
Ratio_Weight_PC_2__c +
Ratio_Weight_PC_3__c +
Ratio_Weight_PC_4__c +
Ratio_Weight_PC_5__c +
Ratio_Weight_PC_6__c +
Ratio_Weight_PC_7__c +
Ratio_Weight_PC_8__c +
Ratio_Weight_PC_9__c</formula>
        <name>Update Total PC Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_R_S_Score</fullName>
        <field>Total_R_S_Score__c</field>
        <formula>Ratio_Weight_R_S_1__c +
 Ratio_Weight_R_S_2__c +
 Ratio_Weight_R_S_3__c +
 Ratio_Weight_R_S_4__c +
 Ratio_Weight_R_S_5__c</formula>
        <name>Update Total R&amp;S Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Check Hiring MasterRA Checkboxes</fullName>
        <actions>
            <name>Set_Master_RA_In_Place_As_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Strategic_Hiring_Partner_As_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Account.RU_Count_Master_RA__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RU_Count_Strategic_Hiring_Partner__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Set the Checkboxes , Is KU A Strategic Hiring Partner?, Master RA In Place?</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set FTE in Location</fullName>
        <actions>
            <name>Set_Location_FTE_Details</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set FTE in Location</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Kansas FTE Details</fullName>
        <actions>
            <name>Set_FTE_in_Kansas</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Kansas FTE Details</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Valuation Ration History Tracking Field Value</fullName>
        <actions>
            <name>Set_Valuation_Ration_History_Tracking_Fi</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Valuation Ration History Tracking Field Value</description>
        <formula>ISCHANGED( Valuation_Ratio__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Category Score</fullName>
        <actions>
            <name>Update_Total_ED_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Total_ITE_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Total_KT_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Total_PC_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Total_R_S_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>a0Gi000000MFjhLEAT_Purge</fullName>
        <actions>
            <name>MALatitude_c_Purge</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MALongitude_c_Purge</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Account.a0Gi000000MFjhLEAT_Purge</description>
        <formula>OR(ISCHANGED(BillingStreet),ISCHANGED(BillingCity),ISCHANGED(BillingState),ISCHANGED(BillingPostalCode),ISCHANGED(BillingCountry))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
