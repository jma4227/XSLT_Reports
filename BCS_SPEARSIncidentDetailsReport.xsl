<?xml version="1.0" encoding="Windows-1252"?>
<root>
    <!--    SPEARS_IncidentDetailsReport.xml 02/10/2020

         Version 1.25 Bexar County -  James Ma
            - Added Incident Classification output to the report
            - Added Alternate names to Involved Persons if exists. (Aliases, nicknames etc)
            - Added condtion in left join SQL statement to only add names only if they exists.
            - Default parameters for all checkboxes = '1'.

         -->
    <VersionInfo>
        <Filename>SPEARS_IncidentDetailsReport.xml</Filename>
        <Revision>1.20.1</Revision>
        <NMLVersion>5.04.11.02.18</NMLVersion>
        <NicheBuildName>BexarCounty</NicheBuildName>
        <BuildTime>2018/07/21 22:08:08</BuildTime>
        <UpdateTime>2020/02/05 09:23:30</UpdateTime>
        <Developer>Niche</Developer>
    </VersionInfo><!-- Information to be used when loading the report -->
    <AllowedEntity>Occurrence</AllowedEntity>
    <IsDomainReport>0</IsDomainReport>
    <IsPrintTemplate>1</IsPrintTemplate>
    <CFDSComponentGroupTemplateSelectEntity>CF occurrence details
    </CFDSComponentGroupTemplateSelectEntity>
    <ReportName>SPEARS Incident Report</ReportName>
    <Documentation>
        <![CDATA[
This report displays detailed information about an Occurrence and the following
related items:	Occurrences, Persons, GPersonArrest, GPersonVictim, GPersonDeath, GPersonMissing
		GPersonStatement, GPersonPolExtDoc, Addresses, CommAddresses
		Vehicles, Officers, Property, MO, GenOccReport, SupOccReport
		FraudDocOccReport, NotesOccReport, MVCOccReport, ExtDocOccReport
Allowed entities:
	Occurrence (903)
	]]>
    </Documentation><!-- List parameters to the SQL query here. -->
    <SQLParameter>ShowDescriptors</SQLParameter>
    <SQLParameter>ShowACL</SQLParameter>
    <!-- List parameters to the XSLT report here. -->
    <XSLTParameter>CreTimeG</XSLTParameter>
    <XSLTParameter>ShowClassification</XSLTParameter>
    <XSLTParameter>ShowDOB</XSLTParameter>
    <XSLTParameter>ShowDL</XSLTParameter>
    <XSLTParameter>ShowSSN</XSLTParameter>
    <XSLTParameter>ShowAddress</XSLTParameter>
    <XSLTParameter>ShowPhone</XSLTParameter>
    <XSLTParameter>ShowEmail</XSLTParameter>
    <XSLTParameter>ShowDescriptors</XSLTParameter>
    <XSLTParameter>ShowOccurrences</XSLTParameter>
    <XSLTParameter>ShowInvolvedAddress</XSLTParameter>
    <XSLTParameter>ShowPersons</XSLTParameter>
    <XSLTParameter>ShowAddresses</XSLTParameter>
    <XSLTParameter>ShowCommAddresses</XSLTParameter>
    <XSLTParameter>ShowVehicles</XSLTParameter>
    <XSLTParameter>ShowOfficers</XSLTParameter>
    <XSLTParameter>ShowProperty</XSLTParameter>
    <XSLTParameter>ShowMO</XSLTParameter>
    <XSLTParameter>ShowGenOccReport</XSLTParameter>
    <XSLTParameter>ShowSupOccReport</XSLTParameter>
    <XSLTParameter>ShowFraudDocOccReport</XSLTParameter>
    <XSLTParameter>ShowGPersonArrest</XSLTParameter>
    <XSLTParameter>ShowGPersonVictim</XSLTParameter>
    <XSLTParameter>ShowGPersonDeath</XSLTParameter>
    <XSLTParameter>ShowGPersonMissing</XSLTParameter>
    <XSLTParameter>ShowGPersonSC</XSLTParameter>
    <XSLTParameter>ShowGPersonIntox</XSLTParameter>
    <XSLTParameter>ShowGVehicleSC</XSLTParameter>
    <XSLTParameter>ShowGPersonStatement</XSLTParameter>
    <XSLTParameter>ShowGPersonPolExtDoc</XSLTParameter>
    <XSLTParameter>ShowNotesOccReport</XSLTParameter>
    <XSLTParameter>ShowMVCOccReport</XSLTParameter>
    <XSLTParameter>ShowExtDocOccReport</XSLTParameter>
    <XSLTParameter>ShowEnquiryLog</XSLTParameter>
    <XSLTParameter>ShowNames</XSLTParameter>
    <!-- List parameters to the SQL here. -->

    <!-- Report format parameters. -->
    <ReportHeader></ReportHeader>
    <!-- MLS in CDATA -->
    <ReportFooter>
        <![CDATA[e"""<p style='float: left; text-align: left;'>Printed: [DATE] [TIME] by [@AGBL=USERNUM]</p><p style='float: right; text-align: right;'>Page: [PAGENUM] of [PAGETOTAL]</p>"]]>
    </ReportFooter><!-- MLS in CDATA -->
    <!--<ReportHeaderTop></ReportHeaderTop>-->
    <!-- Default is: printer.unprintableTop/100 -->
    <ReportFooterBottom></ReportFooterBottom><!-- Default is: printer.unprintableBottom/100 -->
    <ReportDetailMarginTop></ReportDetailMarginTop><!-- Default is: printer.marginTop/100 -->
    <ReportDetailMarginLeft></ReportDetailMarginLeft><!-- Default is: printer.marginLeft/100 -->
    <ReportDetailMarginRight></ReportDetailMarginRight><!-- Default is: printer.marginRight/100 -->
    <ReportDetailMarginBottom></ReportDetailMarginBottom><!-- Default is: printer.marginBottom/100 -->
    <DefaultProtectiveMarking></DefaultProtectiveMarking><!-- MLS -->
    <!-- SQLSelect must be enclosed in CDATA. -->
    <SQLSelectXSLT><![CDATA[


        <xsl:stylesheet version = "1.0"
                        xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
				<xsl:output method = "text"
				            omit-xml-declaration = "yes"/>
				<xsl:param name = "ShowACL"/>
				<xsl:param name = "PARAM_ID"/>
				<xsl:param name = "ShowDescriptors"
				           select = "'1'"/>

				<xsl:template match = "/">

					SELECT
						MainOccurrence__Id, MainOccurrence__OccurrenceFileNoG, MainOccurrence__OccurrenceStdOccTypeRId_L, MainOccurrence__CallPriorityG,
						MainOccurrence__StartTimeTZV2G, MainOccurrence__EndTimeTZV2G, MainOccurrence__ReportedTimeTZV2G, MainOccurrence__GOccIvPA_cache,
						MainOccurrence__UCRClearanceStatusG, MainOccurrence__Summary, MainOccurrence__Concluded, MainOccurrence__ConcludedDateG,
						MainOccurrence__EntityDisplayName, MainOccurrence__CallSourceG, MainOccurrence__DispatchOccTypeG, MainOccurrence__UCRClearanceStatusDateG,
						MainOccurrence__ClassificationG,

						GOccIdCADEventNumber__IdNumberG, GOccIdExternalFileNumber__IDNumberG, GOccIDOccurrenceReportFileNumber__IDNumberG,
						GOccIdGId1__IDNumberG, GOccIdGId4__IDNumberG, GOccIdServedDocumentFileNumber__IDNumberG, GOccIdOtherAgencyId__IdNumberG, GOccIdGId3__IDNumberG,
						GOccIdOperationName__IdNumberG,

						InvolvedOccurrencesLeft__LabelRightTab(EXPAND('Delimiter = '' / ''')),
						InvolvedOccurrencesRight__LabelLeftTab(EXPAND('Delimiter = '' / ''')),
						InvolvedGPersons__LabelRightTab(EXPAND('Delimiter = '' / ''')),
							InvolvedGPersons__ClassificationHasPropertyValue(property='clvIsArrested', value='1') AS InvolvedGPersons_ClassificationIsArrested,
							InvolvedGPersons__ClassificationHasPropertyValue(property='clvIsSuspect', value='1') AS InvolvedGPersons_ClassificationIsSuspect,
							InvolvedGPersons__ClassificationHasPropertyValue(property='clvIsVictim', value='1') AS InvolvedGPersons_ClassificationIsVictim,
							InvolvedGPersons__ClassificationHasPropertyValue(property='clvIsWitness', value='1') AS InvolvedGPersons_ClassificationIsWitness,
							InvolvedGPersons__ClassificationHasPropertyValue(property='clvIsArrested', value='1') AS InvolvedGPersons_ClassificationIsArrested,
							InvolvedGPersons__ClassificationG,
							GPerson__Id,
								GPerson__LabelName, GPerson__PhysicalAddress_cacheG, GPerson__DateOfBirthG, GPerson__GenderG,
								GPerson__GPIDDLDisplay, GPerson__GPIDUSSSNIdNumber,
                            GPersonName__Id, GPersonName__SurNameG, GPersonName__Given1G, GPersonName__GenderGA,GPersonName__Type1,
							PersonTelephone__Label, TelephoneLink__Type1G,
							PersonEmail__Label, EmailLink__Type1G,
							<xsl:if test = "$ShowDescriptors = '1'">
								PersonDesc__HeightG, PersonDesc__MassG, PersonDesc__BuildG, PersonDesc__RaceG, PersonDesc__HairColorG, PersonDesc__EyeColorG,
							</xsl:if>
							GPersonArrest__Id, GPersonArrest__Id AS BlobData_DocData_GPersonArrest_Id, GPersonArrest__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonArrest__EntityDisplayName,
								GPersonArrest__GPPEventGOccRId_L, GPersonArrest__OccurrenceFileNoG, GPersonArrest__GPersonPolTREventTRRId_L, GPersonArrest__GPersonPolReportAuthRId_L,
								GPersonArrest__ReportTimeTZV2G, GPersonArrest__GPersonPolReportEnterRId_L, GPersonArrest__EnteredTimeTZV2G,
								GPersonCharge__Label,
							GPersonVictim__Id, GPersonVictim__Id AS BlobData_DocData_GPersonVictim_Id, GPersonVictim__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonVictim__EntityDisplayName,
								GPersonVictim__GPPEventGOccRId_L, GPersonVictim__OccurrenceFileNoG, GPersonVictim__GPersonPolTREventTRRId_L, GPersonVictim__GPersonPolReportAuthRId_L,
								GPersonVictim__ReportTimeTZV2G, GPersonVictim__GPersonPolReportEnterRId_L, GPersonVictim__EnteredTimeTZV2G,
								GPersonVictim__StartTimeTZV2G, GPersonVictim__SexAssaultKit, GPersonVictim__SexAssaultKitTimeTZV2G,
								GPersonVictim__UCRMostSeriousViolationG, GPersonVictim__UCRAttemptedCompletedG, GPersonVictim__UCRWeaponCausingInjuryG,
								GPersonVictim__UCRLevelOfInjuryG, GPersonVictim__UCRRelationshipToVictimG, GPersonVictim__UCROccupancyG,
								GPersonVictim__UCRLivingTogetherG, GPersonVictim__UCRPeaceOfficerStatusG, GPersonVictim__VictimServicesNotifiedG,
								GPersonVictim__VictimServicesAcceptedG, GPersonVictim__GPersonPolReportVictimServicesNotifiedByForReports,
								GPersonVictim__VictimImpactStatementNotificationG, GPersonVictim__IdNumberG,
							GPersonDeath__Id, GPersonDeath__Id AS BlobData_DocData_GPersonDeath_Id, GPersonDeath__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonDeath__EntityDisplayName,
								GPersonDeath__GPPEventGOccRId_L, GPersonDeath__OccurrenceFileNoG, GPersonDeath__GPersonPolTREventTRRId_L, GPersonDeath__GPersonPolReportAuthRId_L,
								GPersonDeath__ReportTimeTZV2G, GPersonDeath__GPersonPolReportEnterRId_L, GPersonDeath__EnteredTimeTZV2G,
								GPersonDeath__Type1G, GPersonDeath__StartTimeTZV2G, GPersonDeath__StartTime2TZV2G,
								GPersonDeath__DiscoveryLocationTypeG, GPersonDeath__DiscoveryTimeTZV2G, GPersonDeath__GPDPronDeadRId_L,
								GPersonDeath__GPDPronDeadCommAddressG, GPersonDeath__GPDPronDeadTimeTZV2G, GPersonDeath__GPDPronDeadAddrRId_L,
								GPersonDeath__GPDCoronerRId_L, GPersonDeath__GPDCoronerCommAddressG, GPersonDeath__GPDCoronerTimeTZV2G,
								GPersonDeath__GPDPathologistRId_L, GPersonDeath__GPDPathologistCommAddressG, GPersonDeath__GPDPathologistTimeTZV2G,
								GPersonDeath__PostMortemTimeTZV2G, GPersonDeath__GPDPostMortemAddrRId_L, GPersonDeath__PostMortemTypeG,
								GPersonDeath__GPDNOKRId_L, GPersonDeath__GPDNOKCommAddressG, GPersonDeath__GPDNOKNotifByRId_L, GPersonDeath__GPDNOKTimeTZV2G,
								GPersonDeath__GPDBodyRelByRId_L, GPersonDeath__BodyRelTimeTZV2G, GPersonDeath__GPDBodyTakenByRId_L,
								GPersonDeath__BodyTakenTimeTZV2G, GPersonDeath__GPDBodyTakenToRId_L, GPersonDeath__Weapon,
								GPersonDeath__Motive, GPersonDeath__CauseOfDeath, GPersonDeath__IdentEstablished,
							GPersonMissing__Id, GPersonMissing__Id AS BlobData_DocData_GPersonMissing_Id, GPersonMissing__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonMissing__EntityDisplayName,
								GPersonMissing__GPPEventGOccRId_L, GPersonMissing__OccurrenceFileNoG, GPersonMissing__GPersonPolTREventTRRId_L, GPersonMissing__GPersonPolReportAuthRId_L,
								GPersonMissing__ReportTimeTZV2G, GPersonMissing__GPersonPolReportEnterRId_L, GPersonMissing__EnteredTimeTZV2G,
								GPersonMissing__Type1G, GPersonMissing__StartTimeTZV2G, GPersonMissing__StartTime2TZV2G,
								GPersonMissing__MissProbableReasonG, GPersonMissing__MissFromG, GPersonMissing__MissHistoryG,
								GPersonMissing__MissDentalAvailableG, GPersonMissing__MissPhotoAvailableG, GPersonMissing__MissXRayAvailableG,
								GPersonMissing__MissDisabilityDependG, GPersonMissing__MissProbableDest, GPersonMissing__GPMElopeInstitutionRId_L,
								GPersonMissing__ElopeInstitutionOrderExpG, GPersonMissing__GPMLastSeenByRId_L, GPersonMissing__GPMLastSeenAtRId_L,
								GPersonMissing__EndTimeDG,
								GPersonMissing__LifeStyleG, GPersonMissing__UsualTransportG, GPersonMissing__LivesWithG, GPersonMissing__LivesWithDetailG,
							GPersonSC__Id, GPersonSC__Id AS BlobData_DocData_GPersonSC_Id, GPersonSC__DocData, GPersonSC__LabelPersonName, GPersonSC__OccurrenceFileNoG,
								GPersonSC__LabelOccurrence, GPersonSC__GPersonPolReportAuthRId_L, GPersonSC__GPersonPolReportEnterRId_L, GPersonSC__ReportTimeTZV2G, GPersonSC__EnteredTimeTZV2G,
								GPersonSC__Remarks, GPersonSC__IdentifiedByG, GPersonSC__ClothingAppearanceG, GPersonSC__ClothingDescriptionG, GPersonSC__BalanceG, GPersonSC__WalkingG,
								GPersonSC__SpeechG, GPersonSC__EyeDescriptionG, GPersonSC__GPSCTravelStartLocationRId_L, GPersonSC__StartLocationAlcoholAvailableG, GPersonSC__GPSCTravelEndLocationRId_L,
								GPersonSC__OfficerInteractionG, GPersonSC__MiscObservationsG, GPersonSC__InitialStatementG, GPersonSC__InitialStatement2G,
							GPersonIntox__Id, GPersonIntox__Id AS BlobData_DocData_GPersonIntox_Id, GPersonIntox__DocData, GPersonPolReportFieldSobrietyTest__Id, GPersonIntox__OccurrenceFileNoG, GPersonIntox__LabelEntity,
								GPersonIntox__GPersonPolReportAuthRId_L, GPersonIntox__GPersonPolReportEnterRId_L, GPersonIntox__ReportTimeTZV2G, GPersonIntox__Remarks, GPersonPolReportFieldSobrietyTest__TestsGivenG,
								GPersonPolReportFieldSobrietyTest__TestsNotGivenReasonG, GPersonPolReportFieldSobrietyTest__HGNTestGivenG, GPersonPolReportFieldSobrietyTest__HGNHeadInjuryG, GPersonPolReportFieldSobrietyTest__HGNEyeLensesG,
								GPersonPolReportFieldSobrietyTest__HGNPupilG, GPersonPolReportFieldSobrietyTest__HGNRestingNystagmusG, GPersonPolReportFieldSobrietyTest__HGNEqualTrackingG, GPersonPolReportFieldSobrietyTest__HGNStimulusG,
								GPersonPolReportFieldSobrietyTest__HGNStimulusOfficerConfirmationG, GPersonPolReportFieldSobrietyTest__HGNLightsG, GPersonPolReportFieldSobrietyTest__HGNSubjectFacingG,
								GPersonPolReportFieldSobrietyTest__HGNUnderstandsG, GPersonPolReportFieldSobrietyTest__HGNLackSmoothPursuitG, GPersonPolReportFieldSobrietyTest__HGNNystagmusSustainedG,
								GPersonPolReportFieldSobrietyTest__HGNNystagmusOnsetG, GPersonPolReportFieldSobrietyTest__HGNVerticalNystagmusG, GPersonPolReportFieldSobrietyTest__HGNScoreG,
								GPersonPolReportFieldSobrietyTest__HGNContinueEvaluationG, GPersonPolReportFieldSobrietyTest__WATTestGivenG, GPersonPolReportFieldSobrietyTest__WATScoreG,
								GPersonPolReportFieldSobrietyTest__WATContinueEvaluationG, GPersonPolReportFieldSobrietyTest__WATUnableToPerformG, GPersonPolReportFieldSobrietyTest__WATUnderstandsG,
								GPersonPolReportFieldSobrietyTest__WATBalanceG, GPersonPolReportFieldSobrietyTest__WATStartG, GPersonPolReportFieldSobrietyTest__WATStopsG, GPersonPolReportFieldSobrietyTest__WATStepsHeelToeG,
								GPersonPolReportFieldSobrietyTest__WATStepsOffLineG, GPersonPolReportFieldSobrietyTest__WATArmsBalanceG, GPersonPolReportFieldSobrietyTest__WATTurnG, GPersonPolReportFieldSobrietyTest__WATStepCountOutG,
								GPersonPolReportFieldSobrietyTest__WATStepCountInG, GPersonPolReportFieldSobrietyTest__OLSTestGivenG, GPersonPolReportFieldSobrietyTest__OLSScoreG, GPersonPolReportFieldSobrietyTest__OLSContinueEvaluationG,
								GPersonPolReportFieldSobrietyTest__OLSUnableToPerformG, GPersonPolReportFieldSobrietyTest__OLSUnderstandsG, GPersonPolReportFieldSobrietyTest__OLSFootStoodOnG, GPersonPolReportFieldSobrietyTest__OLSFootRaisedG,
								GPersonPolReportFieldSobrietyTest__OLSFootwearG, GPersonPolReportFieldSobrietyTest__OLSSwayG, GPersonPolReportFieldSobrietyTest__OLSArmsBalanceG, GPersonPolReportFieldSobrietyTest__OLSHopsG,
								GPersonPolReportFieldSobrietyTest__OLSFootDownG, GPersonPolReportFieldSobrietyTest__IntoxicantOdorG, GPersonPolReportFieldSobrietyTest__IntoxicantOdorStrengthG, GPersonPolReportFieldSobrietyTest__AttitudeG,
								GPersonPolReportFieldSobrietyTest__ImpairmentCauseG, GPersonPolReportFieldSobrietyTest__OfficerCertifiedG, GPersonPolReportFieldSobrietyTest__DrugGroupG, GPersonPolReportFieldSobrietyTest__DrugSymptomsG,
								GPersonPolReportFieldSobrietyTest__DrugEvaluatorPresentG, GPersonPolReportFieldSobrietyTest__DrugEvaluationG, GPersonPolReportFieldSobrietyTest__InterviewQuestionsG,
								GPersonPolReportFieldSobrietyTest__ProbableCauseG, GPersonIntox__BreathTestWaitingPeriodStartTimeTZV2G, GPersonIntox__BreathTestSubjectFastingG, GPersonIntox__BreathTestIdNumberG,
								GPersonIntox__BreathTestIdNumber2G, GPersonIntox__GPPLDAssocOfficerRId_L, GPersonIntox__RightsReadLanguageG, GPersonIntox__RightsReadOnVideoG, GPersonIntox__RightsReadTimeTZV2G,
								GPersonIntox__RightsUnderstoodG, GPersonIntox__BreathTestRefusedG, GPersonIntox__GPPLDAssocGPerson1RId_L, GPersonIntox__BreathTestEquipmentVerifiedG, GPersonIntox__BreathTestAppearanceG,
								GPersonIntox__BreathTestsG, GPersonIntox__BreathTestTimeDG, GPersonIntox__BreathTestResult1TimeTZV2G, GPersonIntox__BreathTestResult1G, GPersonIntox__BreathTestResult2TimeTZV2G, GPersonIntox__BreathTestResult2G,
								GPersonIntox__LicenseConfiscatedG, GPersonIntox__LicenseSuspensionNoticeTimeDG, GPersonIntox__GPPLDIssuingGPersonRId_L, GPersonIntox__GPPLDAssocGPerson2RId_L, GPersonIntox__GPPLDAssocGPerson3RId_L,
								GPersonIntox__BloodTakenByOccupationG, GPersonIntox__GPPLDAssocGPerson4RId_L, GPersonIntox__BloodDrawTimeTZV2G, GPersonIntox__BloodDrawLocationSanitaryG, GPersonIntox__GPPLDAssocOfficer2RId_L,
								GPersonIntox__BloodDrawOfficerVerifiedSampleG, GPersonIntox__BloodDrawOfficerVerifiedCleaningG, GPersonIntox__BloodDrawOfficerVerifiedProcedureG, GPersonIntox__GPPLDAssocOfficer3RId_L,
							GVehicleSC__Id, GVehicleSC__Id AS BlobData_DocData_GVehicleSC_Id, GVehicleSC__DocData, GVehicleSC__LabelProperty, GVehicleSC__LabelOccurrence, GVehicleSC__OccurrenceFileNo, GVehicleSC__GPropertyPolReportAuthRId_L,
								GVehicleSC__GPropertyPolReportEnterRId_L, GVehicleSC__ReportTimeTZV2G, GVehicleSC__EnteredTimeTZV2G, GVehicleSC__Remarks, GVehicleSC__OfficerUniformG, GVehicleSC__OfficerVehicleTypeG,
								GVehicleSC__OfficerVehicleUnitNumberG, GVehicleSC__AccidentLocationTypeG, GVehicleSC__RoadConditionG, GVehicleSC__RoadFeature3G, GVehicleSC__RoadMaterialG, GVehicleSC__LightConditionG,
								GVehicleSC__RoadFeature2G, GVehicleSC__WeatherConditionG, GVehicleSC__DriverRaceKnownG, GVehicleSC__GVSCObservationLocationRId_L, GVehicleSC__StopReasonG, GVehicleSC__InitialObservationG,
								GVehicleSC__OthersInDangerG, GVehicleSC__SpeedFactorG, GVehicleSC__SpeedLimit, GVehicleSC__MVEstimatedSpeed, GVehicleSC__MVActualSpeed, GVehicleSC__SpeedMeasurementDeviceG,
								GVehicleSC__SpeedMeasurementDeviceTrainedG, GVehicleSC__SpeedMeasurementDeviceDetailsG, GVehicleSC__SpeedMeasurementDeviceCheckedG, GVehicleSC__WelfareConcernG, GVehicleSC__StopFactors1G,
								GVehicleSC__StopFactors2G, GVehicleSC__StopFactors3G, GVehicleSC__StopFactors4G, GVehicleSC__SearchPerformedG, GVehicleSC__SearchReasonG, GVehicleSC__SearchObjectsFoundDuringSearchG,
								GVehicleSC__SearchObjectsFoundG, GVehicleSC__DriverReactionG, GVehicleSC__DetentionLengthG, GVehicleSC__StopLocationTypeG, GVehicleSC__SearchOutcomeG, GVehicleSC__SearchOutcome2G,
							GPersonStatement__Id, GPersonStatement__Id AS BlobData_DocData_GPersonStatement_Id, GPersonStatement__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonStatement__EntityDisplayName,
								GPersonStatement__GPPEventGOccRId_L, GPersonStatement__OccurrenceFileNoG, GPersonStatement__GPersonPolTREventTRRId_L, GPersonStatement__GPSStateTakerRId_L,
								GPersonStatement__StartTimeTZV2G, GPersonStatement__GPersonStatementEnterRId_L, GPersonStatement__EnteredTimeTZV2G,
							GPersonPolExtDoc__Id, GPersonPolExtDoc__LabelTab(EXPAND('Delimiter = '' / ''')), GPersonPolExtDoc__EntityDisplayName, GPersonPolExtDoc__OccurrenceFileNoG,
								GPersonPolExtDoc__TitleG, GPersonPolExtDoc__LabelOccurrence, GPersonPolExtDoc__GPersonPolTREventTRRId_L,
								GPersonPolExtDoc__GPersonPolReportAuthLabel, GPersonPolExtDoc__ReportTimeTZV2G,
								GPersonPolExtDoc__GPersonPolReportEnterRId_L, GPersonPolExtDoc__EnteredTimeTZV2G,
								GPersonPolExtDoc__GPPEDAssocGVehicleRId_L, GPersonPolExtDoc__GPPEDAssocOfficerRId_L,
								GPersonPolExtDoc__GPersonPolReportCourtFolderRId_L,
							GPIDUSSSN__IdNumberG,

						InvolvedPA__LabelRightTab(EXPAND('Delimiter = '' / ''')),
							InvolvedPA__IsLabelCacheSource,
						InvolvedCommAddress__LabelRightTab(EXPAND('Delimiter = '' / ''')),
						InvolvedVehicle__LabelRightTab(EXPAND('Delimiter = '' / ''')),
						Vehicle__OriginalColor_1G,
						InvolvedInvGPerson__LabelRightTab(EXPAND('Delimiter = '' / ''')),
						InvolvedInvGPerson__ClassificationHasPropertyValue(property='clvIsReportingOfficer', value='1') AS InvolvedInvGPerson_ClassificationIsReportOfficer,
						InvolvedProperty__LabelRightTab(EXPAND('Delimiter = '' / ''')),
						Firearm__Caliber,
						InvolvedCAKeyword__ReportText, InvolvedCAKeyword__CAKeywordAuthRId_L, InvolvedCAKeyword__CAKeywordEnterRId_L, InvolvedCAKeyword__ReportTimeTZV2G,
								InvolvedCAKeyword__EnteredTimeTZV2G,
						GenOccReport__Id, GenOccReport__Id AS BlobData_DocData_GenOccReport_Id, GenOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), GenOccReport__EntityDisplayName,
							GenOccReport__LabelGOccurrence, GenOccReport__OccurrenceFileNoWhole, GenOccReport__GOccurrenceTREventTRRId_L, GenOccReport__GOccReportAuthRId_L,
							GenOccReport__ReportTimeTZV2G, GenOccReport__GOccReportEnterRId_L, GenOccReport__EnteredTimeTZV2G,
						SupOccReport__Id, SupOccReport__Id AS BlobData_DocData_SupOccReport_Id, SupOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), SupOccReport__EntityDisplayName,
							SupOccReport__OccurrenceFileNoWhole, SupOccReport__OccLabelShort, SupOccReport__GOccurrenceTREventTRRId_L, SupOccReport__GOccReportAuthRId_L,
							SupOccReport__ReportTimeTZV2G, SupOccReport__GOccReportEnterRId_L, SupOccReport__EnteredTimeTZV2G,
						FraudDocOccReport__Id, FraudDocOccReport__Id AS BlobData_DocData_FraudDocOccReport_Id, FraudDocOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), FraudDocOccReport__EntityDisplayName,
							FraudDocOccReport__OccurrenceFileNoWhole,
						NotesOccReport__Id, NotesOccReport__Id AS BlobData_DocData_NotesOccReport_Id, NotesOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), NotesOccReport__EntityDisplayName,
							NotesOccReport__LabelGOccurrence, NotesOccReport__OccurrenceFileNoWhole, NotesOccReport__GOccurrenceTREventTRRId_L, NotesOccReport__GOccReportAuthRId_L,
							NotesOccReport__ReportTimeTZV2G, NotesOccReport__GOccReportEnterRId_L, NotesOccReport__EnteredTimeTZV2G,
						MVCOccReport__Id, MVCOccReport__Id AS BlobData_DocData_MVCOccReport_Id, MVCOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), MVCOccReport__EntityDisplayName,
							MVCOccReport__LabelGOccurrence, MVCOccReport__GOccurrenceTREventTRRId_L, MVCOccReport__GOccReportAuthRId_L,
							MVCOccReport__ReportTimeTZV2G, MVCOccReport__GOccReportEnterRId_L, MVCOccReport__EnteredTimeTZV2G,
							MVCOccReport__OfficerAttendG, MVCOccReport__MVCUnitInvestigationG, MVCOccReport__MVCUnitOfficerRId_L,
							MVCOccReport__AccidentSeverity1G, MVCOccReport__AccidentSeverity2G, MVCOccReport__PoliceVehicleG, MVCOccReport__NumberUnits,
							MVCOccReport__SpeedLimitG, MVCOccReport__WeatherConditionG, MVCOccReport__LightConditionG, MVCOccReport__IntersectionControlG,
							MVCOccReport__IntersectionControlDetailsG, MVCOccReport__RoadConditionG, MVCOccReport__RoadFeature1G,
							MVCOccReport__RoadFeature1DetailsG, MVCOccReport__RoadFeature2G, MVCOccReport__RoadFeature3G, MVCOccReport__RoadDividedG,
							MVCOccReport__RoadLanesG, MVCOccReport__AccidentTypeG, MVCOccReport__AccidentTypeDetailsG, MVCOccReport__AccidentLocationTypeG,
						ExtDocOccReport__Id, ExtDocOccReport__LabelTab(EXPAND('Delimiter = '' / ''')), ExtDocOccReport__EntityDisplayName
							ExtDocOccReport__Title, ExtDocOccReport__TitleG, ExtDocOccReport__OccurrenceFileNoWhole,
							ExtDocOccReport__GOccurrenceTREventTRRId_L, ExtDocOccReport__GOccReportAuthLabel, ExtDocOccReport__ReportTimeTZV2G,
							ExtDocOccReport__GOccReportEnterRId_L, ExtDocOccReport__EnteredTimeTZV2G,
							ExtDocOccReport__EDORAssocGPersonRId_L, ExtDocOccReport__EDORAssocPARId_L, ExtDocOccReport__EDORAssocGVehicleRId_L,
							ExtDocOccReport__EDORAssocOfficerRId_L,

						EnquiryLog__EntityDisplayName,

						LogEntry__GCField1G as LogEntry_Type,
						LogEntry__CreTimeTZV2GL,
						LogEntry__CreTimeTZV2CL,
						LogEntry__StartTimeTZV2G,
						LogEntry__GOccurrenceTREventActivityLogAuthRId_L,
						LogEntry__HasExternalSystemURI,
						LogEntry__DetailsAsHTML

					FROM Occurrence MainOccurrence

					LEFT JOIN (GOccIdCADEventNumber)
					LEFT JOIN (GOccIDOccurrenceReportFileNumber)
					LEFT JOIN (GOccIdExternalFileNumber)
					LEFT JOIN (GOccIdGId1)
					LEFT JOIN (GOccIdGId4)
					LEFT JOIN (GOccIdServedDocumentFileNumber)
					LEFT JOIN (GOccIdOtherAgencyId)
					LEFT JOIN (GOccIdOperationName)
					LEFT JOIN (GOccIdGId3)

					LEFT JOIN GOccAssocGOcc InvolvedOccurrencesLeft ON InvolvedOccurrencesLeft.LId = MainOccurrence.Id
						<xsl:if test = "$ShowACL != '1'"> AND InvolvedOccurrencesLeft.AccessControlList IS NULL </xsl:if>
					LEFT JOIN GOccAssocGOcc InvolvedOccurrencesRight ON InvolvedOccurrencesRight.RId = MainOccurrence.Id
						<xsl:if test = "$ShowACL != '1'"> AND InvolvedOccurrencesRight.AccessControlList IS NULL </xsl:if>
					LEFT JOIN (GOccIvGPerson InvolvedGPersons
						LEFT JOIN (GPerson
                            <!--Added alternate name parameter FJ-->
                            LEFT JOIN (GPersonName GPName) ON ChoiceHasProperty(GPName.Type1,"cl_GPersonNameType","clvIsAlias","1") = 1
							LEFT JOIN (GPersonAssocGAddress TelephoneLink
								LEFT JOIN Telephone PersonTelephone
									<xsl:if test = "$ShowACL != '1'"> ON PersonTelephone.AccessControlList IS NULL </xsl:if>
							) ON TelephoneLink.EffectiveToTimeTZV2I IS NULL
								AND IsSpecialization(TelephoneLink.RId, 'Telephone') = 1
								AND AnyOfSetHasProperty(TelephoneLink.Classification, 'cl_GPersonAssocGAddressClassification', 'isRestricted', '1') = 0
								<xsl:if test = "$ShowACL != '1'"> AND TelephoneLink.AccessControlList IS NULL </xsl:if>
							LEFT JOIN (GPersonAssocGAddress EmailLink
								LEFT JOIN Email PersonEmail
									<xsl:if test = "$ShowACL != '1'"> ON PersonEmail.AccessControlList IS NULL </xsl:if>
							) ON EmailLink.EffectiveToTimeTZV2I IS NULL
								AND IsSpecialization(EmailLink.RId, 'Email') = 1
								AND AnyOfSetHasProperty(EmailLink.Classification, 'cl_GPersonAssocGAddressClassification', 'isRestricted', '1') = 0
								<xsl:if test = "$ShowACL != '1'"> AND EmailLink.AccessControlList IS NULL </xsl:if>
							LEFT JOIN (GPersonAssocGAddress AddressLink
								LEFT JOIN PhysicalAddress PersonAddress
									<xsl:if test = "$ShowACL != '1'"> ON PersonAddress.AccessControlList IS NULL </xsl:if>
							) ON AddressLink.IsPACacheSource = 1
								AND AnyOfSetHasProperty(AddressLink.Classification, 'cl_GPersonAssocGAddressClassification', 'isRestricted', '1') = 0
								<xsl:if test = "$ShowACL != '1'"> AND AddressLink.AccessControlList IS NULL </xsl:if>
							LEFT JOIN (GPersonArrest
								LEFT JOIN (GPChargeGPArrest
									LEFT JOIN GPersonCharge
								) <xsl:if test = "$ShowACL != '1'"> ON GPersonCharge.AccessControlList IS NULL </xsl:if>
							) ON GPersonArrest.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonArrest.AccessControlList IS NULL </xsl:if>

							<xsl:if test = "$ShowDescriptors = '1'">
								LEFT JOIN (Person
									LEFT JOIN PersonDesc
									<xsl:if test = "$ShowACL != '1'"> ON PersonDesc.AccessControlList IS NULL </xsl:if>
								)
							</xsl:if>

							LEFT JOIN GPIDUSSSN
								<xsl:if test = "$ShowACL != '1'"> ON GPIDUSSSN.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonVictim ON GPersonVictim.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonVictim.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonDeath ON GPersonDeath.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonDeath.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonMissing ON GPersonMissing.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonMissing.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonStatement ON GPersonStatement.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonStatement.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonPolExtDoc ON GPersonPolExtDoc.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonPolExtDoc.AccessControlList IS NULL </xsl:if>
							LEFT JOIN GPersonSC ON GPersonSC.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonSC.AccessControlList IS NULL </xsl:if>
							LEFT JOIN (GPersonIntox
								LEFT JOIN GPersonPolReportFieldSobrietyTest) ON GPersonIntox.GPPEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
								<xsl:if test = "$ShowACL != '1'"> AND GPersonIntox.AccessControlList IS NULL </xsl:if>
						) <xsl:if test = "$ShowACL != '1'"> ON GPerson.AccessControlList IS NULL </xsl:if>
					) <xsl:if test = "$ShowACL != '1'"> ON GOccIvGPerson.AccessControlList IS NULL </xsl:if>

					LEFT JOIN (GOccIvPA InvolvedPA
						LEFT JOIN PhysicalAddress OccurrenceAddress
							<xsl:if test = "$ShowACL != '1'"> ON OccurrenceAddress.AccessControlList IS NULL </xsl:if>
					) <xsl:if test = "$ShowACL != '1'"> ON InvolvedPA.AccessControlList IS NULL </xsl:if>

					LEFT JOIN GOccIvCommAddress InvolvedCommAddress
						<xsl:if test = "$ShowACL != '1'"> ON GOccIvCommAddress.AccessControlList IS NULL </xsl:if>

					LEFT JOIN (GOccIvGVehicle InvolvedVehicle
    						LEFT JOIN (Vehicle
              						LEFT JOIN GVehicleSC ON GVehicleSC.GPropPolEventGOccRId IN (<xsl:value-of select = "$PARAM_ID"/>)
           								 <xsl:if test = "$ShowACL != '1'"> AND GVehicleSC.AccessControlList IS NULL </xsl:if>
       							) <xsl:if test = "$ShowACL != '1'"> ON Vehicle.AccessControlList IS NULL </xsl:if>
							) <xsl:if test = "$ShowACL != '1'"> ON InvolvedVehicle.AccessControlList IS NULL </xsl:if>
					LEFT JOIN GOccInvGPerson InvolvedInvGPerson
						<xsl:if test = "$ShowACL != '1'"> ON GOccInvGPerson.AccessControlList IS NULL </xsl:if>
					LEFT JOIN (GOccIvGNVProperty InvolvedProperty
						LEFT JOIN GNVProperty
							<xsl:if test = "$ShowACL != '1'"> ON GNVProperty.AccessControlList IS NULL </xsl:if>
						LEFT JOIN Firearm
							<xsl:if test = "$ShowACL != '1'"> ON Firearm.AccessControlList IS NULL </xsl:if>
					) <xsl:if test = "$ShowACL != '1'"> ON GOccIvGNVProperty.AccessControlList IS NULL </xsl:if>
					LEFT JOIN CAKeyword InvolvedCAKeyword
						<xsl:if test = "$ShowACL != '1'"> ON CAKeyword.AccessControlList IS NULL </xsl:if>
					LEFT JOIN GenOccReport
						<xsl:if test = "$ShowACL != '1'"> ON GenOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN SupOccReport
						<xsl:if test = "$ShowACL != '1'"> ON SupOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN FraudDocOccReport
						<xsl:if test = "$ShowACL != '1'"> ON FraudDocOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN NotesOccReport
						<xsl:if test = "$ShowACL != '1'"> ON NotesOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN MVCOccReport
						<xsl:if test = "$ShowACL != '1'"> ON MVCOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN ExtDocOccReport
						<xsl:if test = "$ShowACL != '1'"> ON ExtDocOccReport.AccessControlList IS NULL </xsl:if>
					LEFT JOIN (GOccLogReport EnquiryLog
						LEFT JOIN GOccurrenceTREventActivityLog LogEntry
							<xsl:if test = "$ShowACL != '1'"> ON GOccurrenceTREventActivityLog.AccessControlList IS NULL </xsl:if>
					) <xsl:if test = "$ShowACL != '1'"> ON GOccLogReport.AccessControlList IS NULL </xsl:if>

					WHERE MainOccurrence.Id IN (<xsl:value-of select = "$PARAM_ID"/>)
					<xsl:if test = "ShowNames">
					  AND EXISTS (
					    SELECT Id FROM GPersonName WHERE
					      ChoiceHasProperty(GPersonName.Type1, 'cl_GPersonNameType', 'clvIsAlias', '1' ) = 1
					  )
					</xsl:if>
					AND HierarchicalResult = 1
						<xsl:if test = "$ShowACL != '1'"> AND MainOccurrence.AccessControlList IS NULL </xsl:if>

					ORDER BY InvolvedOccurrencesLeft.CreTimeTZV2I DESC, InvolvedOccurrencesRight.CreTimeTZV2I DESC,
								InvolvedGPersons.CreTimeTZV2I DESC,
								<xsl:if test = "$ShowDescriptors = '1'">PersonDesc.CreTimeTZV2I DESC,</xsl:if>
								PersonTelephone.CreTimeTZV2I DESC, GPersonArrest.CreTimeTZV2I ASC, GPersonCharge.CreTimeTZV2I ASC, GPersonVictim.CreTimeTZV2I ASC,
								GPersonDeath.CreTimeTZV2I ASC, GPersonMissing.CreTimeTZV2I ASC, GPersonSC.CreTimeTZV2I ASC, GPersonStatement.CreTimeTZV2I ASC, GPersonPolExtDoc.CreTimeTZV2I ASC,
								InvolvedPA.CreTimeTZV2I DESC, InvolvedCommAddress.CreTimeTZV2I DESC, InvolvedVehicle.CreTimeTZV2I DESC,
								InvolvedInvGPerson.CreTimeTZV2I DESC, GNVProperty.GPSLTagNumber_cacheG ASC, InvolvedProperty.CreTimeTZV2I DESC, InvolvedCAKeyword.CreTimeTZV2I DESC,
								GenOccReport.CreTimeTZV2I ASC, SupOccReport.CreTimeTZV2I ASC, FraudDocOccReport.CreTimeTZV2I ASC,
								NotesOccReport.CreTimeTZV2I ASC, MVCOccReport.CreTimeTZV2I ASC, ExtDocOccReport.CreTimeTZV2I ASC

					select SPKey, SPValue from SystemParameterSettingForACC where SPKey = 'Label.AgencyName'
					select SPKey, SPValue from SystemParameterSettingForACC where SPKey = 'Label.DivisionName'
					select Label, LabelName, EmployeeNumber_Cache from GPerson where id = @currentUserId

					-- Only applies if the report is part of a court folder document set
					select CFDSComponent__SectionAndSequenceNumber, CourtFolder__IdNumberG, CourtFolder__OccurrenceSummary from
					CFDSComponent left join (
						CFDSComponentGroup left join (
							CourtFolderDocumentSet left join CourtFolder
						)
					) where CFDSComponent.id = @XSLTReport_AssociatedCFDSComponentId

				</xsl:template>

			</xsl:stylesheet>


	]]></SQLSelectXSLT>
    <ReportXSL><![CDATA[

        <?xml version="1.0" encoding="Windows-1252"?>
	    <xsl:stylesheet version = "1.0"
	                    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
	                    xmlns:nicheFunctions = "urn:nicheFunctions"
	                    xmlns:msxsl = "urn:schemas-microsoft-com:xslt"
	                    xmlns:pp = "urn:nichePreprocessor">
				<xsl:param name = "CreTimeG"/>
				<xsl:param name = "ShowClassification"
				           select = "'1'"/>
				<xsl:param name = "ShowDOB"
				           select = "'1'"/>
		    <!-- SSN defaults to "show", so that it will appear in the Case File Assembly if this report is a part of it,
					but it is set to "hide" in the parameter window, so if the report is run from an Occurrence, the SSN won't show.  -->
		    <xsl:param name = "ShowSSN"
		               select = "'1'"/>
				<xsl:param name = "ShowDL"
				           select = "'1'"/>
				<xsl:param name = "ShowAddress"
				           select = "'1'"/>
				<xsl:param name = "ShowPhone"
				           select = "'1'"/>
				<xsl:param name = "ShowEmail"
				           select = "'1'"/>
				<xsl:param name = "ShowDescriptors"
				           select = "'1'"/>
				<xsl:param name = "ShowOccurrences"
				           select = "'1'"/>
               	<xsl:param name = "ShowPersons"
                           select = "'1'"/>
                <xsl:param name = "ShowGPersonArrest"
                           select = "'1'"/>
				<xsl:param name = "ShowGPersonVictim"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonDeath"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonMissing"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonSC"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonIntox"
				           select = "'1'"/>
				<xsl:param name = "ShowGVehicleSC"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonStatement"
				           select = "'1'"/>
				<xsl:param name = "ShowGPersonPolExtDoc"
				           select = "'1'"/>
				<xsl:param name = "ShowAddresses"
				           select = "'1'"/>
				<xsl:param name = "ShowCommAddresses"
				           select = "'1'"/>
				<xsl:param name = "ShowVehicles"
				           select = "'1'"/>
				<xsl:param name = "ShowOfficers"
				           select = "'1'"/>
				<xsl:param name = "ShowProperty"
				           select = "'1'"/>
				<xsl:param name = "ShowMO"
				           select = "'1'"/>
				<xsl:param name = "ShowGenOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowSupOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowFraudDocOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowNotesOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowMVCOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowExtDocOccReport"
				           select = "'1'"/>
				<xsl:param name = "ShowEnquiryLog"
				           select = "'1'"/>
                <xsl:param name="ShowNames" select = "'1'"/>
				<xsl:output method = "xml"
				            indent = "yes"
				            omit-xml-declaration = "yes"/>

				<xsl:template match = "/DATASETLIST">
					<html>
						<head>
						</head>
							<style type = "text/css">
								body {
									font-family: Helvetica, Arial, sans-serif;
									font-size: 10pt;
									font-weight: normal;
								}

								h1 {
									text-align: center;
									font-size: 16pt;
								}

								h2 {
									text-align: center;
								}

								h3 {
									text-align: left;
									font-size: 14pt;
									font-weight: bold;
									border-bottom: 1px solid #111;
								}

								h4 {
									text-align: left;
									font-size: 12pt;
									font-weight: bold;
									border-bottom: 1px solid #555;
								}

								h5 {
									text-align: left;
									font-size: 10pt;
									font-weight:bold;
								}
								h6 {
									text-align: left;
									font-size: 9pt;
									font-weight: italic;
									font-weight:bold;
								}

								table {
									border-collapse: collapse;
								}

								td {
									padding: 5px;
								}

								hr {
									size: 2;
									noshade: true;
								}

								tr {
									height: 14;
								}

								col {
									font-family: arial;
									font-size: 9pt;
									vertical-align: top;
									text-align: left;
								}

								col.indent {
									width: 15;
									text-align: right;
								}

								col.label {
									/*font-style: italic;*/
									font-weight: bold;
								}

								table.narr {
									padding-left: 25;
								}

								/* @group Class-Based Declarations */
								.ReportHeader {
									font-family: Arial;
									font-weight: bold;
									font-size: 16pt;
								}
								.Label {
									font-size: 10pt;
									font-family: Arial;
								}
								.NameLabel {
									font-size: 10pt;
									font-family: Arial;
									font-weight:bold;
									margin-right: 0.15in;
								}
								.NameLabelIndented {
									font-size: 10pt;
									font-family: Arial;
									font-weight:bold;
									margin-left: 0.15in;
								}
								.LabelSmall {
									font-size: 8pt;
									font-family: Arial;
								}
								.NameLabelSmall {
									font-size: 8pt;
									font-family: Arial;
									font-weight:bold;
								}
								.IndentedLine {
									border-top:solid;
									border-top-width:2px;
									border-color: #111;
									margin-left: 0.15in;
								}
								.TableData
								{
									font-size: 8pt;
									padding: 0px 2px 0px 2px;
									vertical-align: top;
								}
								.TableHeader
								{
									border-color: silver;
									border-style: none none solid none;
									border-width:2px;
									font-size: 10pt;
									font-style: italic;
									vertical-align: bottom;
								}

								.incidents {
									margin-top: 20px;
								}

								.incidents thead {
									text-align: left;
								}

								.incidents .stats td{
									border-top: 1px solid #ccc;
									background-color: #eee;
								}

								.incidents .summary p {
									margin-bottom: 20px;
								}

								.chart {
									margin-top: 20px;
									background: transparent url('../images/loader.gif') center center no-repeat;
									border: 1px solid #AAA;
								}

								.chart.loaded {
									background: none;
									border: none;
								}

								.clear {
									clear: both;
								}

								.indented {
									margin-left: 0.15in;
								}

								@media print {
									.chart {
										display: none;
									}
									.separatePage {
										page-break-before:always;
									}
								}

								/* @end */

								/* @group ID-Based Declarations */

								#header {
									margin-bottom: 2em;
								}

								#header .logo{
									float: left;
									height: 100px;
								}

								#reportHeader, #reportSummary {
									background-color: #FAFAFA;
									padding: 10px;
									border: 1px solid #AAA;
									border-radius: 5px;
								}

								#reportHeader {
									height: 151px;
									float: left;
								}

								#reportHeader .logo {
									position: absolute;
									display: block;
									width: 100px;
									height: 131px;
								}

								#reportHeader .summary {
									margin-left: 110px;
								}


								#reportSummary {
									float: right;
								}

								#reportBody {
									clear: both;
								}

								/* @end */

							</style>

						<body style = "word-wrap:break-word;">
							<xsl:for-each select = "DATASET[@entity = 'MAINOCCURRENCE']/ROW">
							<xsl:if test = "position() != 1">
								<p style = "page-break-after:always"/>
							</xsl:if>

							<table width = "100%">
								<tr>
									<td width = "85%"
									    align = "center">
										<h1><xsl:value-of select = "/DATASETLIST/DATASET[2]/ROW/SPValue/text()"/></h1>
										<h1>SPEARS <xsl:value-of select = "MainOccurrence__EntityDisplayName"/> Summary: <xsl:value-of select = "MainOccurrence__OccurrenceFileNoG"/></h1>
									</td>
								</tr>
							</table>

								<!-- CAD Master Incident and Case Numbers(s) -->
								<table border = "0"
								       cellpadding = "0"
								       cellspacing = "0"
								       width = "100%">
								<colgroup>
										<col width = "150"
										     class = "first label"/>
										<col width = ""
										     class = "value"/>
									</colgroup>
								<tr>
										<td>CAD Master Incident:</td>
										<td><xsl:value-of select = "DATASET/ROW/GOccIdCADEventNumber__IdNumberG"/></td>
									</tr>
									<tr>
										<td>Case Number(s):</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIDOccurrenceReportFileNumber__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
									</tr>
								</table>

							<h3>Incident Details:</h3>

								<table border = "0"
								       cellpadding = "0"
								       cellspacing = "0"
								       width = "100%">
										<colgroup>
											<col width = "150"
											     class = "first label"/>
											<col width = ""
											     class = "value"/>
										</colgroup>
									<tr>
										<td>CAD Problem Nature:</td>
										<td><xsl:value-of select = "MainOccurrence__DispatchOccTypeG"/></td>
									</tr>
									<tr>
										<td>Source:</td>
										<td><xsl:value-of select = "MainOccurrence__CallSourceG"/></td>
									</tr>
									<tr>
										<td>Reported time:</td>
										<td><xsl:value-of select = "MainOccurrence__ReportedTimeTZV2G"/></td>
									</tr>
									<tr>
										<td>Incident Type:</td>
										<td><xsl:value-of select = "MainOccurrence__OccurrenceStdOccTypeRId_L"/></td>
									</tr>
									<!--FJ Modified 11/07/2019 -->
									<tr>
										<td>Incident Class:</td>
										<td><xsl:value-of select = "MainOccurrence__ClassificationG"/></td>
									</tr>
									<tr>
										<td>Priority:</td>
										<td><xsl:value-of select = "MainOccurrence__CallPriorityG"/></td>
									</tr>
									<tr>
										<td>Incident time:</td>
										<td>
											<xsl:value-of select = "MainOccurrence__StartTimeTZV2G"/>
											<xsl:text> - </xsl:text>
											<xsl:value-of select = "MainOccurrence__EndTimeTZV2G"/>
										</td>
									</tr>
									<tr>
										<td>Incident location:</td>
										<td>
											<xsl:value-of select = "MainOccurrence__GOccIvPA_cache"/>
											<xsl:for-each select = "DATASET/ROW[InvolvedPA__IsLabelCacheSource = 'True']"> <!-- should only ever be one -->
												<xsl:text> </xsl:text>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td>Incident status:</td>
										<td><xsl:value-of select = "MainOccurrence__UCRClearanceStatusG"/></td>
									</tr>
									<tr>
										<td>Incident status date:</td>
										<td><xsl:value-of select = "MainOccurrence__UCRClearanceStatusDateG"/></td>
									</tr>
									<tr>
										<td>Summary:</td>
										<td><xsl:value-of select = "MainOccurrence__Summary"/></td>
									</tr>
								</table>

							<h3>External incident numbers:</h3>
								<table border = "0"
								       cellpadding = "0"
								       cellspacing = "0"
								       width = "100%">
									<colgroup>
										 <col width = "20%"
										      class = "label"/>
										<col width = "30%"/>
										<col width = "20%"
										     class = "label"/>
										<col width = "30%"/>
									</colgroup>
									<tr>
										<td>External file:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdExternalFileNumber__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
										<td>Judicial #:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdGId1__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td>Misc. number:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdGId4__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
										<td>Civil number:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdServedDocumentFileNumber__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td>Other agency:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdOtherAgencyId__IdNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
										<td>Citation:</td>
										<td><xsl:for-each select = "DATASET/ROW/GOccIdGId3__IDNumberG">
               										 <xsl:value-of select = "."/><BR/>
												</xsl:for-each>
										</td>
									</tr>

								</table>

								<xsl:if test = "$ShowPersons = '1'">
									<h3>Involved Persons:</h3>
									<xsl:call-template name = "ShowPersonDetails"><xsl:with-param name = "DataSet"
									                                                              select = "DATASET/ROW[InvolvedGPersons_ClassificationIsArrested = 'True']"/></xsl:call-template>
									<xsl:call-template name = "ShowPersonDetails"><xsl:with-param name = "DataSet"
									                                                              select = "DATASET/ROW[InvolvedGPersons_ClassificationIsSuspect = 'True' and InvolvedGPersons_ClassificationIsArrested != 'True']"/></xsl:call-template>
									<xsl:call-template name = "ShowPersonDetails"><xsl:with-param name = "DataSet"
									                                                              select = "DATASET/ROW[InvolvedGPersons_ClassificationIsVictim = 'True' and InvolvedGPersons_ClassificationIsArrested != 'True' and InvolvedGPersons_ClassificationIsSuspect != 'True']"/></xsl:call-template>
									<xsl:call-template name = "ShowPersonDetails"><xsl:with-param name = "DataSet"
									                                                              select = "DATASET/ROW[InvolvedGPersons_ClassificationIsWitness = 'True' and InvolvedGPersons_ClassificationIsArrested != 'True' and InvolvedGPersons_ClassificationIsSuspect != 'True' and InvolvedGPersons_ClassificationIsVictim != 'True']"/></xsl:call-template>
									<xsl:call-template name = "ShowPersonDetails">
										<xsl:with-param name = "DataSet"
										                select = "DATASET/ROW[&#xD;&#xA;													InvolvedGPersons_ClassificationIsArrested != 'True'&#xD;&#xA;												and InvolvedGPersons_ClassificationIsSuspect != 'True'&#xD;&#xA;												and InvolvedGPersons_ClassificationIsVictim != 'True'&#xD;&#xA;												and InvolvedGPersons_ClassificationIsWitness != 'True']"/>
									</xsl:call-template>


								</xsl:if>

								<xsl:if test = "$ShowProperty = '1' and count(DATASET/ROW[InvolvedProperty__LabelRightTab]) &gt; 0">
									<h3>Involved Property:</h3>
									<UL>
										<xsl:for-each select = "DATASET/ROW[InvolvedProperty__LabelRightTab]">
											<LI>
												<xsl:value-of select = "nicheFunctions:normalizeLabel(nicheFunctions:prependLabel(string(InvolvedProperty__LabelRightTab), ' / ', 7), ' / ',';')"/>
														<xsl:if test = "Firearm__Caliber != ''">
															<xsl:text> / </xsl:text>
															<xsl:value-of select = "Firearm__Caliber"/>
															<xsl:text> caliber</xsl:text>
														</xsl:if>
											</LI>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowVehicles = '1' and count(DATASET/ROW[InvolvedVehicle__LabelRightTab]) &gt; 0">
									<h3>Involved Vehicles:</h3>
									<UL>
										<xsl:for-each select = "DATASET/ROW[InvolvedVehicle__LabelRightTab]">
											<LI>
												<xsl:value-of select = "nicheFunctions:normalizeLabel(nicheFunctions:prependLabel(string(InvolvedVehicle__LabelRightTab), ' / ', 3), ' / ', ';2;3;')"/>
														<xsl:if test = "Vehicle__OriginalColor_1G != ''">
															<xsl:text> / </xsl:text>
															<xsl:value-of select = "Vehicle__OriginalColor_1G"/>
														</xsl:if>
											</LI>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowAddresses = '1' and count(DATASET[@entity = 'INVOLVEDPA']/ROW) &gt; 0">
									<h3>Involved Addresses:</h3>
									<UL>
										<xsl:for-each select = "DATASET[@entity = 'INVOLVEDPA']/ROW">
											<LI><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedPA__LabelRightTab), ' / ', ';1;2;')"/></LI>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowCommAddresses = '1' and count(DATASET[@entity = 'INVOLVEDCOMMADDRESS']/ROW) &gt; 0">
									<h3>Involved Comm Addresses:</h3>
									<UL>
										<xsl:for-each select = "DATASET[@entity = 'INVOLVEDCOMMADDRESS']/ROW">
											<LI><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedCommAddress__LabelRightTab), ' / ', ';1;2;')"/></LI>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowMO = '1' and count(DATASET[@entity = 'INVOLVEDCAKEYWORD']/ROW) &gt; 0">
									<h3>Modus Operandi:</h3>
									<UL>
										<xsl:for-each select = "DATASET[@entity = 'INVOLVEDCAKEYWORD']/ROW">
											<LI width = "670"
											    style = "word-wrap:break-word"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedCAKeyword__ReportText), ' / ', ';;')"/></LI>
											<br/><br/>
											<DIV width = "670">
												<table width = "100%">
													<colgroup>
														<col width = "20%"
														     class = "label"/>
														<col width = "30%"/>
														<col width = "20%"
														     class = "label"/>
														<col width = "30%"/>
													</colgroup>
													<tr>
														<td>Author:</td>
														<td><xsl:value-of select = "InvolvedCAKeyword__CAKeywordAuthRId_L"/></td>
														<td>Report time:</td>
														<td><xsl:value-of select = "InvolvedCAKeyword__ReportTimeTZV2G"/></td>
													</tr>
													<tr>
														<td>Entered by:</td>
														<td><xsl:value-of select = "InvolvedCAKeyword__CAKeywordEnterRId_L"/></td>
														<td>Entered time:</td>
														<td><xsl:value-of select = "InvolvedCAKeyword__EnteredTimeTZV2G"/></td>
													</tr>
												</table>
											</DIV>
											<br/>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowOccurrences = '1' and (count(DATASET[@entity = 'INVOLVEDOCCURRENCESLEFT']/ROW) &gt; 0 or DATASET[@entity = 'INVOLVEDOCCURRENCESRIGHT']/ROW &gt; 0)">
									<h3>Associated <xsl:value-of select = "MainOccurrence__EntityDisplayName"/>s:</h3>
									<UL>
										<xsl:for-each select = "DATASET[@entity = 'INVOLVEDOCCURRENCESLEFT']/ROW">
											<LI><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedOccurrencesLeft__LabelRightTab), ' / ', ';6;')"/></LI>
										</xsl:for-each>
										<xsl:for-each select = "DATASET[@entity = 'INVOLVEDOCCURRENCESRIGHT']/ROW">
											<LI><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedOccurrencesRight__LabelLeftTab), ' / ', ';6;')"/></LI>
										</xsl:for-each>
									</UL>
								</xsl:if>

								<xsl:if test = "$ShowOfficers = '1'">
											<h3>Involved Officers:</h3>
									<UL>
											<xsl:for-each select = "DATASET[@entity = 'INVOLVEDINVGPERSON']/ROW">
												<LI><xsl:value-of select = "nicheFunctions:normalizeLabel(string(InvolvedInvGPerson__LabelRightTab), ' / ', ';2;9;10;')"/></LI>
											</xsl:for-each>
									</UL>
								</xsl:if>

								<DIV class = "separatePage">
									<xsl:if test = "$ShowGenOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'GENOCCREPORT')]/ROW">
											<xsl:call-template name = "GenOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonArrest = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONARREST')]/ROW">
											<xsl:call-template name = "ArrestReport"/>
											<br/>

										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonVictim = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONVICTIM')]/ROW">
											<xsl:call-template name = "VictimReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonDeath = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONDEATH')]/ROW">
											<xsl:call-template name = "DeathReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonMissing = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONMISSING')]/ROW">
											<xsl:call-template name = "MissingPersonReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGVehicleSC = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDVEHICLE;VEHICLE')]/ROW/DATASET[contains(@entity, 'GVEHICLESC')]/ROW">
											<xsl:call-template name = "VehicleInMotionReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonSC = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONSC')]/ROW">
											<xsl:call-template name = "DriverContactReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonIntox = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONINTOX')]/ROW">
											<xsl:call-template name = "IntoxReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonStatement = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONSTATEMENT')]/ROW">
											<xsl:call-template name = "WitnessReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowSupOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'SUPOCCREPORT')]/ROW">
											<xsl:call-template name = "SupOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowFraudDocOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'FRAUDDOCOCCREPORT')]/ROW">
											<xsl:call-template name = "FraudDocOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowNotesOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'NOTESOCCREPORT')]/ROW">
											<xsl:call-template name = "NotesOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowMVCOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'MVCOCCREPORT')]/ROW">
											<xsl:call-template name = "MVCOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
								</DIV>
									<xsl:if test = "$ShowEnquiryLog = '1'">
										<xsl:for-each select = "DATASET/ROW[EnquiryLog__EntityDisplayName]">
											<xsl:call-template name = "EnquiryLog"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowExtDocOccReport = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'EXTDOCOCCREPORT')]/ROW">
											<xsl:call-template name = "ExtDocOccReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test = "$ShowGPersonPolExtDoc = '1'">
										<xsl:for-each select = "DATASET[contains(@entity, 'INVOLVEDGPERSONS')]/ROW/DATASET[contains(@entity, 'GPERSONPOLEXTDOC')]/ROW">
											<xsl:call-template name = "ExternalPersonReport"/>
											<br/>
										</xsl:for-each>
									</xsl:if>
							</xsl:for-each>
						</body>
					</html>
				</xsl:template>

				<xsl:template name = "ShowPersonDetails">
					<xsl:param name = "DataSet"/>
					<xsl:for-each select = "$DataSet">
						<div style = "border-bottom: 1px solid #AAA;">
						<table>
							<colgroup>
								<col class = "first label"
								     width = "100"/>
								<col class = "value"
								     width = "330"/>
								<col class = "label"
								     width = "70"/>
								<col class = "value"
								     width = "170"/>
							</colgroup>
							<tr>
								<td>Name:</td>
								<td><xsl:value-of select = "GPerson__LabelName"/></td>
								<td>Gender:</td>
								<td><xsl:value-of select = "GPerson__GenderG"/></td>
							</tr>
                            	<xsl:if test = "$ShowNames = '1'">
							  <tr>
							    <td>Alias:</td>
							    <td colspan = "3">
							    <xsl:for-each select = "DATASET/ROW[GPersonName__Id != '']">
                                  <xsl:value-of select = "GPersonName__SurNameG"/>,
                                  <xsl:value-of select = "GPersonName__Given1G"/>
                                  <BR/>
                                  </xsl:for-each>
                                  </td>
                              </tr>
                              </xsl:if>

							<xsl:if test = "$ShowClassification = '1' or $ShowDOB = '1'">
							<tr>
									<xsl:if test = "$ShowClassification = '1'"><td>Classification:</td></xsl:if>
									<xsl:if test = "$ShowClassification = '1'"><td><xsl:value-of select = "InvolvedGPersons__ClassificationG"/></td></xsl:if>
									<xsl:if test = "$ShowDOB = '1'"><td>DOB:</td></xsl:if>
									<xsl:if test = "$ShowDOB = '1'"><td><xsl:value-of select = "GPerson__DateOfBirthG"/></td></xsl:if>
							</tr>
							</xsl:if>
							<xsl:if test = "$ShowDL = '1' or $ShowSSN = '1'">
							<tr>
									<xsl:if test = "$ShowDL = '1'"><td>DL:</td></xsl:if>
									<xsl:if test = "$ShowDL = '1'"><td><xsl:value-of select = "GPerson__GPIDDLDisplay"/></td></xsl:if>
								<td><xsl:if test = "$ShowSSN = '1' and DATASET/ROW/GPIDUSSSN__IdNumberG != ''">SSN:</xsl:if></td>
								<td><xsl:if test = "$ShowSSN = '1' and DATASET/ROW/GPIDUSSSN__IdNumberG != ''"><xsl:value-of select = "GPerson__GPIDUSSSNIdNumber"/></xsl:if></td>
							</tr>
							</xsl:if>
							<xsl:if test = "$ShowAddress = '1'">
								<tr>
									<td>Address:</td>
									<td colspan = "3">
										<xsl:value-of select = "GPerson__PhysicalAddress_cacheG"/>
									</td>

								</tr>
							</xsl:if>
							<xsl:if test = "$ShowPhone = '1'">
								<tr>
									<td>Telephone:</td>
									<td colspan = "3">
										<xsl:for-each select = "DATASET/ROW[PersonTelephone__Label != '']">
											<xsl:value-of select = "PersonTelephone__Label"/>
											<xsl:text> [</xsl:text>
											<xsl:value-of select = "TelephoneLink__Type1G"/>
											<xsl:text>]</xsl:text>
											<BR/>
										</xsl:for-each>
									</td>
								</tr>
							</xsl:if>

							<xsl:if test = "$ShowEmail = '1'">
								<tr>
									<td>Email:</td>
									<td colspan = "3">
										<xsl:for-each select = "DATASET/ROW[PersonEmail__Label != '']">
											<xsl:value-of select = "PersonEmail__Label"/>
											<xsl:text> [</xsl:text>
											<xsl:value-of select = "EmailLink__Type1G"/>
											<xsl:text>]</xsl:text>
											<BR/>
										</xsl:for-each>
									</td>
								</tr>
							</xsl:if>
						</table>

						<xsl:if test = "count(DATASET[@entity = 'PERSONDESC']/ROW) &gt; 0">
							<table>
								<colgroup>
									<col class = "first label"
									     width = "70"/>
									<col class = "value"
									     width = "153"/>
									<col class = "label"
									     width = "80"/>
									<col class = "value"
									     width = "143"/>
									<col class = "label"
									     width = "80"/>
									<col class = "value"
									     width = "143"/>
								</colgroup>
								<xsl:for-each select = "DATASET[@entity = 'PERSONDESC']/ROW[1]">
									<tr>
										<td>Height:</td>
										<td><xsl:value-of select = "PersonDesc__HeightG"/></td>
										<td>Weight:</td>
										<td><xsl:value-of select = "PersonDesc__MassG"/></td>
										<td>Build:</td>
										<td><xsl:value-of select = "PersonDesc__BuildG"/></td>
									</tr>
									<tr>
										<td>Race:</td>
										<td><xsl:value-of select = "PersonDesc__RaceG"/></td>
										<td>Hair Color:</td>
										<td><xsl:value-of select = "PersonDesc__HairColorG"/></td>
										<td>Eye Color:</td>
										<td><xsl:value-of select = "PersonDesc__EyeColorG"/></td>
										<td colspan = "4"></td>
									</tr>
								</xsl:for-each>
							</table>
						</xsl:if>
						</div>
					</xsl:for-each>
				</xsl:template>

				<xsl:template name = "ArrestReport">
					<DIV class = "separatePage">
					<h3><xsl:value-of select = "GPersonArrest__EntityDisplayName"/>, Incident: <xsl:value-of select = "GPersonArrest__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "25%"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GPersonArrest__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GPersonArrest__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonArrest__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonArrest__EnteredTimeTZV2G"/></td>
						</tr>

						<tr>
							<td>Charges:</td>
							<td colspan = "3">
								<table border = "0"
								       cellpadding = "0"
								       cellspacing = "0">
									<colgroup>
										<col CLASS = "VALUE"/>
									</colgroup>
								<xsl:for-each select = "DATASET[@entity = 'GPERSONCHARGE']/ROW">
									<tr>
										<td><xsl:value-of select = "GPersonCharge__Label"/></td>
									</tr>
								</xsl:for-each>
								</table>
							</td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonArrest__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "VictimReport">
					<DIV class = "separatePage">
					<h3><xsl:value-of select = "GPersonVictim__EntityDisplayName"/>, Incident: <xsl:value-of select = "GPersonVictim__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GPersonVictim__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GPersonVictim__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonVictim__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonVictim__EnteredTimeTZV2G"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "150"
							     class = "first label"/>
							<col width = "150"
							     class = "value"/>
							<col width = "125"
							     class = "label"/>
							<col width = "75"
							     class = "value"/>
							<col width = "50"
							     class = "label"/>
							<col width = "120"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Event time:</td>
							<td><xsl:value-of select = "GPersonVictim__StartTimeTZV2G"/></td>
							<td>Sexual assault kit:</td>
							<td>
								<xsl:choose>
									<xsl:when test = "GPersonVictim__SexAssaultKit = 'True'">Yes</xsl:when>
									<xsl:otherwise>No</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>Time:</td>
							<td><xsl:value-of select = "GPersonVictim__SexAssaultKitTimeTZV2G"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "150"
							     class = "first label"/>
							<col width = "200"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "220"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Violation against victim:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonVictim__UCRMostSeriousViolationG"/></td>
						</tr>
						<tr>
							<td>Attempted/completed:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonVictim__UCRAttemptedCompletedG"/></td>
						</tr>
						<tr>
							<td>Weapon causing injury:</td>
							<td><xsl:value-of select = "GPersonVictim__UCRWeaponCausingInjuryG"/></td>
							<td>Level of injury:</td>
							<td><xsl:value-of select = "GPersonVictim__UCRLevelOfInjuryG"/></td>
						</tr>
						<tr>
							<td>Accused is:</td>
							<td><xsl:value-of select = "GPersonVictim__UCRRelationshipToVictimG"/></td>
						</tr>
						<tr>
							<td>Occupancy:</td>
							<td><xsl:value-of select = "GPersonVictim__UCROccupancyG"/></td>
							<td>Living together:</td>
							<td><xsl:value-of select = "GPersonVictim__UCRLivingTogetherG"/></td>
						</tr>
						<tr>
							<td>Officer status:</td>
							<td><xsl:value-of select = "GPersonVictim__UCRPeaceOfficerStatusG"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "175"
							     class = "first label"/>
							<col width = "245"
							     class = "value"/>
							<col width = "200"
							     class = "label"/>
							<col width = "50"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Victim services notified:</td>
							<td><xsl:value-of select = "GPersonVictim__VictimServicesNotifiedG"/></td>
							<td>Victim services accepted:</td>
							<td><xsl:value-of select = "GPersonVictim__VictimServicesAcceptedG"/></td>
						</tr>
						<tr>
							<td>Victim services notified by:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonVictim__GPersonPolReportVictimServicesNotifiedByForReports"/></td>
						</tr>
						<tr>
							<td>Victim notified:</td>
							<td><xsl:value-of select = "GPersonVictim__VictimImpactStatementNotificationG"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonVictim__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "DeathReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "GPersonDeath__EntityDisplayName"/>, Incident: <xsl:value-of select = "GPersonDeath__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GPersonDeath__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GPersonDeath__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonDeath__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonDeath__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Type:</td>
							<td><xsl:value-of select = "GPersonDeath__Type1G"/></td>
						</tr>
						<tr>
							<td>Time of death:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__StartTimeTZV2G"/>
								<xsl:if test = "GPersonDeath__StartTime2TZV2G != ''">
									<xsl:text> to </xsl:text>
									<xsl:value-of select = "GPersonDeath__StartTime2TZV2G"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td>Disc. loc:</td>
							<td><xsl:value-of select = "GPersonDeath__DiscoveryLocationTypeG"/></td>
							<td>Disc. time:</td>
							<td><xsl:value-of select = "GPersonDeath__DiscoveryTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Pron. dead by:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__GPDPronDeadRId_L"/></td>
						</tr>
						<tr>
							<td>Tel:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDPronDeadCommAddressG"/></td>
							<td>Time:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDPronDeadTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Location:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__GPDPronDeadAddrRId_L"/></td>
						</tr>
						<tr>
							<td>Coroner:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__GPDCoronerRId_L"/></td>
						</tr>
						<tr>
							<td>Tel:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDCoronerCommAddressG"/></td>
							<td>Time:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDCoronerTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Pathologist:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__GPDPathologistRId_L"/></td>
						</tr>
						<tr>
							<td>Tel:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDPathologistCommAddressG"/></td>
							<td>Time:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDPathologistTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Post-mort tm:</td>
							<td><xsl:value-of select = "GPersonDeath__PostMortemTimeTZV2G"/></td>
							<td>Apsy. type:</td>
							<td><xsl:value-of select = "GPersonDeath__PostMortemTypeG"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "125"
							     class = "first label"/>
							<col width = "545"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Apsy. conducted at:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDPostMortemAddrRId_L"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "150"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "120"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Next of kin:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDNOKRId_L"/></td>
							<td>Tel:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDNOKCommAddressG"/></td>
						</tr>
						<tr>
							<td>Notified by:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDNOKNotifByRId_L"/></td>
							<td>Notified time:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDNOKTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Released by:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDBodyRelByRId_L"/></td>
							<td>Released time:</td>
							<td><xsl:value-of select = "GPersonDeath__BodyRelTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Taken by:</td>
							<td><xsl:value-of select = "GPersonDeath__GPDBodyTakenByRId_L"/></td>
							<td>Taken time:</td>
							<td><xsl:value-of select = "GPersonDeath__BodyTakenTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Taken to:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__GPDBodyTakenToRId_L"/></td>
						</tr>
						<tr>
							<td>Weapon:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__Weapon"/></td>
						</tr>
						<tr>
							<td>Motive:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__Motive"/></td>
						</tr>
						<tr>
							<td>Cause of death:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__CauseOfDeath"/></td>
						</tr>
						<tr>
							<td>Identity established:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonDeath__IdentEstablished"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonDeath__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "MissingPersonReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "GPersonMissing__EntityDisplayName"/>, Incident: <xsl:value-of select = "GPersonMissing__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GPersonMissing__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GPersonMissing__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonMissing__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonMissing__EnteredTimeTZV2G"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "220"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "250"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Missing type:</td>
							<td><xsl:value-of select = "GPersonMissing__Type1G"/></td>
							<td>Miss. between:</td>
							<td><xsl:value-of select = "GPersonMissing__StartTimeTZV2G"/>
								<xsl:if test = "GPersonMissing__StartTime2TZV2G != ''">
									<xsl:text> and </xsl:text><xsl:value-of select = "GPersonMissing__StartTime2TZV2G"/>
								</xsl:if>
							</td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "120"
							     class = "first label"/>
							<col width = "250"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "200"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Prob reason:</td>
							<td><xsl:value-of select = "GPersonMissing__MissProbableReasonG"/></td>
							<td>From:</td>
							<td><xsl:value-of select = "GPersonMissing__MissFromG"/></td>
						</tr>
						<tr>
							<td>History:</td>
							<td><xsl:value-of select = "GPersonMissing__MissHistoryG"/></td>
							<td>Dental:</td>
							<td><xsl:value-of select = "GPersonMissing__MissDentalAvailableG"/></td>
						</tr>
						<tr>
							<td>Photo:</td>
							<td><xsl:value-of select = "GPersonMissing__MissPhotoAvailableG"/></td>
							<td>X-Ray:</td>
							<td><xsl:value-of select = "GPersonMissing__MissXRayAvailableG"/></td>
						</tr>
						<tr>
							<td>Disab/dep:</td>
							<td><xsl:value-of select = "GPersonMissing__MissDisabilityDependG"/></td>
							<td>Prob dest:</td>
							<td><xsl:value-of select = "GPersonMissing__MissProbableDest"/></td>
						</tr>
						<tr>
							<td>Institution:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonMissing__GPMElopeInstitutionRId_L"/></td>
						</tr>
						<tr>
							<td>Order exp. date:</td>
							<td><xsl:value-of select = "GPersonMissing__ElopeInstitutionOrderExpG"/></td>
						</tr>
						<tr>
							<td>Last seen by:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonMissing__GPMLastSeenByRId_L"/></td>
						</tr>
						<tr>
							<td>Last seen at:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonMissing__GPMLastSeenAtRId_L"/></td>
						</tr>
						<tr>
							<td>Date located:</td>
							<td colspan = "1"><xsl:value-of select = "GPersonMissing__EndTimeDG"/></td>
						</tr>
						<tr>
							<td>Life style:</td>
							<td><xsl:value-of select = "GPersonMissing__LifeStyleG"/></td>
							<td>Transport:</td>
							<td><xsl:value-of select = "GPersonMissing__UsualTransportG"/></td>
						</tr>
						<tr>
							<td>Lives with:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonMissing__LivesWithG"/></td>
						</tr>
						<xsl:if test = "GPersonMissing__LivesWithDetailG/text()">
							<tr>
								<td>Specify:</td>
								<td colspan = "3"><xsl:value-of select = "GPersonMissing__LivesWithDetailG"/></td>
							</tr>
						</xsl:if>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonMissing__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

		    <!--VIM Report-->
		    <xsl:template name = "VehicleInMotionReport">
				<DIV class = "separatePage">
					<h3>Vehicle In Motion Report, Incident: <xsl:value-of select = "GVehicleSC__OccurrenceFileNo"/></h3>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "570"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "GVehicleSC__LabelProperty"/></td>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "0"
						       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td><td><xsl:value-of select = "GVehicleSC__GPropertyPolReportAuthRId_L"/></td>
							<td>Report time:</td><td><xsl:value-of select = "GVehicleSC__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td><td><xsl:value-of select = "GVehicleSC__GPropertyPolReportEnterRId_L"/></td>
							<td>Entered time:</td><td><xsl:value-of select = "GVehicleSC__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Remarks:</td>
							<td colspan = "3"><xsl:value-of select = "GVehicleSC__Remarks"/></td>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "145"
							     class = "first label"/>
							<col width = "180"
							     class = "value"/>
							<col width = "155"
							     class = "label"/>
							<col width = "190"
							     class = "value"/>
						</colgroup>
							<tr>
								<xsl:if test = "GVehicleSC__OfficerUniformG/text()">
								<td>Uniform officer wore:</td><td><xsl:value-of select = "GVehicleSC__OfficerUniformG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__OfficerVehicleTypeG/text()">
								<td>Type of police vehicle:</td><td><xsl:value-of select = "GVehicleSC__OfficerVehicleTypeG"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__OfficerVehicleUnitNumberG/text()">
								<td>Vehicle unit number:</td><td><xsl:value-of select = "GVehicleSC__OfficerVehicleUnitNumberG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__AccidentLocationTypeG/text()">
								<td>Road description:</td><td><xsl:value-of select = "GVehicleSC__AccidentLocationTypeG"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__RoadConditionG/text()">
								<td>Road condition:</td><td><xsl:value-of select = "GVehicleSC__RoadConditionG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__RoadFeature3G/text()">
								<td>Road contour:</td><td><xsl:value-of select = "GVehicleSC__RoadFeature3G"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__RoadMaterialG/text()">
								<td>Road surface:</td><td><xsl:value-of select = "GVehicleSC__RoadMaterialG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__LightConditionG/text()">
								<td>Lighting condition:</td><td><xsl:value-of select = "GVehicleSC__LightConditionG"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__RoadFeature2G/text()">
								<td>Approach/overtaking turn:</td><td><xsl:value-of select = "GVehicleSC__RoadFeature2G"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__WeatherConditionG/text()">
								<td>Adverse weather condition:</td><td><xsl:value-of select = "GVehicleSC__WeatherConditionG"/></td></xsl:if>
							</tr>
						</table>
						<table border = "0"
						       cellpadding = "0"
						       cellspacing = "0">
						<colgroup>
							<col width = "300"
							     class = "first label"/>
							<col width = "370"
							     class = "value"/>
						</colgroup>
							<tr><xsl:if test = "GVehicleSC__DriverRaceKnownG/text()">
								<td>Did officer know driver's race before stop?</td><td><xsl:value-of select = "GVehicleSC__DriverRaceKnownG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__GVSCObservationLocationRId_L/text()">
								<td>Where did the initial observation occur?</td><td><xsl:value-of select = "GVehicleSC__GVSCObservationLocationRId_L"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopReasonG/text()">
								<td>Reason for stop:</td><td><xsl:value-of select = "GVehicleSC__StopReasonG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__InitialObservationG/text()">
								<td>What initially caused officer to notice vehicle?</td><td><xsl:value-of select = "GVehicleSC__InitialObservationG"/></td></xsl:if>
							</tr>
							</table>
							<table border = "0"
							       cellpadding = "1"
							       cellspacing = "0">
							<colgroup>
								<col width = "570"
								     class = "first label"/>
								<col width = "100"
								     class = "value"/>
							</colgroup>
							<tr><xsl:if test = "GVehicleSC__OthersInDangerG/text()">
								<td>Was there any other motorist on the roadway that could have been placed in jeopardy or apprehension of collision?</td><td><xsl:value-of select = "GVehicleSC__OthersInDangerG"/></td></xsl:if>
							</tr>
							</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "220"
							     class = "first label"/>
							<col width = "120"
							     class = "value"/>
							<col width = "200"
							     class = "label"/>
							<col width = "130"
							     class = "value"/>
						</colgroup>
							<tr>
								<xsl:if test = "GVehicleSC__SpeedFactorG/text()">
								<td>Was speed a factor for the stop?</td><td><xsl:value-of select = "GVehicleSC__SpeedFactorG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__SpeedLimit/text()">
								<td>Posted speed limit:</td><td><xsl:value-of select = "GVehicleSC__SpeedLimit"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__MVEstimatedSpeed/text()">
								<td>Estimated speed:</td><td><xsl:value-of select = "GVehicleSC__MVEstimatedSpeed"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__MVActualSpeed/text()">
								<td>Confirmed speed:</td><td><xsl:value-of select = "GVehicleSC__MVActualSpeed"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__SpeedMeasurementDeviceG/text()">
								<td>Speed measuring device:</td><td><xsl:value-of select = "GVehicleSC__SpeedMeasurementDeviceG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__SpeedMeasurementDeviceTrainedG/text()">
								<td>Is the officer trained?</td><td><xsl:value-of select = "GVehicleSC__SpeedMeasurementDeviceTrainedG"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__SpeedMeasurementDeviceDetailsG/text()">
								<td>Radar type/serial #</td><td><xsl:value-of select = "GVehicleSC__SpeedMeasurementDeviceDetailsG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__SpeedMeasurementDeviceCheckedG/text()">
								<td>Was the device checked for property function?</td><td><xsl:value-of select = "GVehicleSC__SpeedMeasurementDeviceCheckedG"/></td></xsl:if>
							</tr>
						</table>
						<table border = "0"
						       cellpadding = "0"
						       cellspacing = "0">
						<colgroup>
							<col width = "300"
							     class = "first label"/>
							<col width = "370"
							     class = "value"/>
						</colgroup>
							<tr><xsl:if test = "GVehicleSC__WelfareConcernG/text()">
								<td>Was the vehicle stopped for welfare concern?</td><td><xsl:value-of select = "GVehicleSC__WelfareConcernG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopFactors1G/text()">
								<td>Lane position maintenance problems:</td><td><xsl:value-of select = "GVehicleSC__StopFactors1G"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopFactors2G/text()">
								<td>Speed and braking problems:</td><td><xsl:value-of select = "GVehicleSC__StopFactors2G"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopFactors3G/text()">
								<td>Vigilance problems:</td><td><xsl:value-of select = "GVehicleSC__StopFactors3G"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopFactors4G/text()">
								<td>Judgement problems:</td><td><xsl:value-of select = "GVehicleSC__StopFactors4G"/></td></xsl:if>
							</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "195"
							     class = "first label"/>
							<col width = "140"
							     class = "value"/>
							<col width = "195"
							     class = "label"/>
							<col width = "150"
							     class = "value"/>
						</colgroup>
							<tr>
								<xsl:if test = "GVehicleSC__SearchPerformedG/text()">
								<td>Search conducted?</td><td><xsl:value-of select = "GVehicleSC__SearchPerformedG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__SearchReasonG/text()">
								<td>Reason:</td><td><xsl:value-of select = "GVehicleSC__SearchReasonG"/></td></xsl:if>
							</tr>
							<tr>
								<xsl:if test = "GVehicleSC__SearchObjectsFoundDuringSearchG/text()">
								<td>Contraband discovered?</td><td><xsl:value-of select = "GVehicleSC__SearchObjectsFoundDuringSearchG"/></td></xsl:if>
								<xsl:if test = "GVehicleSC__SearchObjectsFoundG/text()">
								<td>Description of contraband:</td><td><xsl:value-of select = "GVehicleSC__SearchObjectsFoundG"/></td></xsl:if>
							</tr>
						</table>
						<table border = "0"
						       cellpadding = "0"
						       cellspacing = "0">
						<colgroup>
							<col width = "350"
							     class = "first label"/>
							<col width = "320"
							     class = "value"/>
						</colgroup>
							<tr><xsl:if test = "GVehicleSC__DriverReactionG/text()">
								<td>How did the driver react to initiation of traffic stop?</td><td><xsl:value-of select = "GVehicleSC__DriverReactionG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__DetentionLengthG/text()">
								<td>Length of detention:</td><td><xsl:value-of select = "GVehicleSC__DetentionLengthG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__StopLocationTypeG/text()">
								<td>Location of stop:</td><td><xsl:value-of select = "GVehicleSC__StopLocationTypeG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__SearchOutcomeG/text()">
								<td>Result of stop:</td><td><xsl:value-of select = "GVehicleSC__SearchOutcomeG"/></td></xsl:if>
							</tr>
							<tr><xsl:if test = "GVehicleSC__SearchOutcome2G/text()">
								<td>Arrest based on:</td><td><xsl:value-of select = "GVehicleSC__SearchOutcome2G"/></td></xsl:if>
							</tr>
							<tr>
								<td>Narrative:</td>
							</tr>
							<tr>
								<td colspan = "4">
									<xsl:call-template name = "ShowNarrative">
										<xsl:with-param name = "Id"
										                select = "GVehicleSC__Id"/>
									</xsl:call-template>
								</td>
						</tr>
						</table>
						</DIV>
				</xsl:template>

		    <!--Drive Contact Report-->
		    <xsl:template name = "DriverContactReport">
				<DIV class = "separatePage">
					<h3>Driver Contact Report, Incident: <xsl:value-of select = "GPersonSC__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td><td><xsl:value-of select = "GPersonSC__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td><td><xsl:value-of select = "GPersonSC__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td><td><xsl:value-of select = "GPersonSC__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td><td><xsl:value-of select = "GPersonSC__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Remarks:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonSC__Remarks"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "300"
							     class = "first label"/>
							<col width = "370"
							     class = "value"/>
						</colgroup>
						<xsl:if test = "GPersonSC__IdentifiedByG/text()">
							<tr><td>How the suspect was identified as the driver:</td><td><xsl:value-of select = "GPersonSC__IdentifiedByG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__ClothingAppearanceG/text()">
						<tr><td>Clothing appearance:</td><td><xsl:value-of select = "GPersonSC__ClothingAppearanceG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__ClothingDescriptionG/text()">
						<tr><td>Clothing description:</td><td><xsl:value-of select = "GPersonSC__ClothingDescriptionG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__BalanceG/text()">
						<tr><td>Balance:</td><td><xsl:value-of select = "GPersonSC__BalanceG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__WalkingG/text()">
						<tr><td>Walking:</td><td><xsl:value-of select = "GPersonSC__WalkingG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__SpeechG/text()">
						<tr><td>Speech:</td><td><xsl:value-of select = "GPersonSC__SpeechG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__EyeDescriptionG/text()">
						<tr><td>Eyes:</td><td><xsl:value-of select = "GPersonSC__EyeDescriptionG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__GPSCTravelStartLocationRId_L/text()">
						<tr><td>Where is the driver coming from?</td><td><xsl:value-of select = "GPersonSC__GPSCTravelStartLocationRId_L"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__StartLocationAlcoholAvailableG/text()">
						<tr><td>Was it a business that serves alcohol?</td><td><xsl:value-of select = "GPersonSC__StartLocationAlcoholAvailableG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__GPSCTravelEndLocationRId_L/text()">
						<tr><td>Where is the driver going?</td><td><xsl:value-of select = "GPersonSC__GPSCTravelEndLocationRId_L"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__OfficerInteractionG/text()">
						<tr><td>Resistance to officer:</td><td><xsl:value-of select = "GPersonSC__OfficerInteractionG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__MiscObservationsG/text()">
						<tr><td>Post stop cues:</td><td><xsl:value-of select = "GPersonSC__MiscObservationsG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__InitialStatementG/text()">
						<tr><td>Statements before warning and statements without questioning after:</td><td><xsl:value-of select = "GPersonSC__InitialStatementG"/></td></tr>
						</xsl:if>
						<xsl:if test = "GPersonSC__InitialStatement2G/text()">
						<tr><td>Responsive statements after warning:</td><td><xsl:value-of select = "GPersonSC__InitialStatement2G"/></td></tr>
						</xsl:if>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonSC__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

		    <!--Intox Report-->
		    <xsl:template name = "IntoxReport">
				<DIV class = "separatePage">
					<h3>Intoxication Report, Incident: <xsl:value-of select = "GPersonIntox__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td><td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td><td><xsl:value-of select = "GPersonIntox__GPersonPolReportAuthRId_L"/></td>
							<td>Report time:</td><td><xsl:value-of select = "GPersonIntox__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td><td><xsl:value-of select = "GPersonIntox__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td><td><xsl:value-of select = "GPersonIntox__ReportTimeTZV2G"/></td>
						</tr>
						<xsl:if test = "GPersonIntox__Remarks/text()">
						<tr><td>Remarks:</td><td colspan = "3"><xsl:value-of select = "GPersonIntox__Remarks"/></td></tr>
						</xsl:if>
					</table>
					<table border = "0"
					       cellpadding = "1"
					       cellspacing = "0">
						<colgroup>
							<col width = "320"
							     class = "first label"/>
							<col width = "350"
							     class = "value"/>
						</colgroup>

						<tr><td colspan = "3"
						        align = 'center'><i>Pre-arrest screening</i></td></tr>
						<xsl:for-each select = "DATASET[@entity = 'GPERSONPOLREPORTFIELDSOBRIETYTEST']/ROW">
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__TestsGivenG/text()">
								<tr><td>Were field sobriety tests given?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__TestsGivenG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__TestsNotGivenReasonG/text()">
								<tr><td>If SFST not administered, why?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__TestsNotGivenReasonG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNTestGivenG/text()">
								<tr><td colspan = "3"
								        align = 'center'><i>Horizontal gaze nystagmus</i></td></tr>
								<tr><td>Was HGN given?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNTestGivenG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNHeadInjuryG/text()">
								<tr><td>Head injuries?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNHeadInjuryG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNEyeLensesG/text()">
								<tr><td>Subject wearing contacts/glasses?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNEyeLensesG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNPupilG/text()">
								<tr><td>Equal pupil size?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNPupilG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNRestingNystagmusG/text()">
								<tr><td>Resting Nystagmus?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNRestingNystagmusG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNEqualTrackingG/text()">
								<tr><td>Equal tracking?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNEqualTrackingG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNStimulusG/text()">
								<tr><td>Able to follow stimulus?  If no, detail in narrative.</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNStimulusG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNStimulusOfficerConfirmationG/text()">
								<tr><td>Officer held stimulus approx. 12"-15" in front of eyes, slightly above eye level?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNStimulusOfficerConfirmationG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNLightsG/text()">
								<tr><td>Forward emergency lights deactivated?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNLightsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNSubjectFacingG/text()">
								<tr><td>Where was the driver facing during HGN test?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNSubjectFacingG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNUnderstandsG/text()">
								<tr><td>Subject stated understanding of HGN instructions?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNUnderstandsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNLackSmoothPursuitG/text()">
								<tr><td>Lack of smooth pursuit?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNLackSmoothPursuitG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNNystagmusSustainedG/text()">
								<tr><td>Distinct and sustained Nystagmus at maximum deviation?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNNystagmusSustainedG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNNystagmusOnsetG/text()">
								<tr><td>Onset of Nystagmus prior to 45 degress?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNNystagmusOnsetG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNVerticalNystagmusG/text()">
								<tr><td>Vertical Nystagmus?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNVerticalNystagmusG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNScoreG/text()">
								<tr><td>Total HGN clues:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNScoreG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__HGNContinueEvaluationG/text()">
								<tr><td>Decision to continue evaluation after HGN:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__HGNContinueEvaluationG"/></td></tr>
							</xsl:if>
							<!--Walk and Turn-->
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATTestGivenG/text()">
								<tr><td colspan = "3"
								        align = 'center'><i>Walk and turn</i></td></tr>
								<tr><td>Was Walk and Turn (WAT) given?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATTestGivenG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATUnableToPerformG/text()">
								<tr><td>Was subject unable to perform WAT, or WAT stopped for subject safety?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATUnableToPerformG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATUnderstandsG/text()">
								<tr><td>Subject stated understanding of WAT instructions?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATUnderstandsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATBalanceG/text()">
								<tr><td>Cannot keep balance during instructions:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATBalanceG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStartG/text()">
								<tr><td>Starts too soon:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStartG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStopsG/text()">
								<tr><td>Stops while walking:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStopsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStepsHeelToeG/text()">
								<tr><td>Misses heel to toe:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStepsHeelToeG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStepsOffLineG/text()">
								<tr><td>Steps off line:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStepsOffLineG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATArmsBalanceG/text()">
								<tr><td>Uses arms to balance (over 6 inches):</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATArmsBalanceG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATTurnG/text()">
								<tr><td>Turned improperly:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATTurnG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStepCountOutG/text()">
								<tr><td>Wrong number of steps (outbound):</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStepCountOutG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATStepCountInG/text()">
								<tr><td>Wrong number of steps (inbound):</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATStepCountInG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATScoreG/text()">
								<tr><td>Total WAT clues:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATScoreG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__WATContinueEvaluationG/text()">
								<tr><td>Decision to continue evaluation after WAT:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__WATContinueEvaluationG"/></td></tr>
							</xsl:if>
							<!--One Leg Stand-->
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSTestGivenG/text()">
								<tr><td colspan = "3"
								        align = 'center'><i>One leg stand</i></td></tr>
								<tr><td>Was One Leg Stand (OLS) given?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSTestGivenG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSUnableToPerformG/text()">
								<tr><td>Was subject unable to perform OLS, or OLS stopped for subject safety?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSUnableToPerformG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSUnderstandsG/text()">
								<tr><td>Subject stated understanding of OLS instructions:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSUnderstandsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSFootStoodOnG/text()">
								<tr><td>Foot subject stood on:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSFootStoodOnG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSFootRaisedG/text()">
								<tr><td>Foot subject raised:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSFootRaisedG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSFootwearG/text()">
								<tr><td>Type of footwear worn:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSFootwearG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSSwayG/text()">
								<tr><td>Sways:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSSwayG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSArmsBalanceG/text()">
								<tr><td>Uses arms to balance:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSArmsBalanceG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSHopsG/text()">
								<tr><td>Hops:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSHopsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSFootDownG/text()">
								<tr><td>Puts food down:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSFootDownG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSScoreG/text()">
								<tr><td>Total OLS clues:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSScoreG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OLSContinueEvaluationG/text()">
								<tr><td>Decision to continue evaluation after OLS:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OLSContinueEvaluationG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__IntoxicantOdorG/text()">
								<tr><td>Odor of intoxicant on breath:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__IntoxicantOdorG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__IntoxicantOdorStrengthG/text()">
								<tr><td>Strength of intoxicant odor:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__IntoxicantOdorStrengthG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__AttitudeG/text()">
								<tr><td>Attitude:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__AttitudeG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__ImpairmentCauseG/text()">
								<tr><td>Suspected impairment caused by:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__ImpairmentCauseG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__OfficerCertifiedG/text()">
								<tr><td>Is officer ARIDE certified?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__OfficerCertifiedG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__DrugGroupG/text()">
								<tr><td>Drug group suspected:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__DrugGroupG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__DrugSymptomsG/text()">
								<tr><td>Drug suspicion due to:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__DrugSymptomsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__DrugEvaluatorPresentG/text()">
								<tr><td>DRE present:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__DrugEvaluatorPresentG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__DrugEvaluationG/text()">
								<tr><td>DRE evaluation performed?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__DrugEvaluationG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__InterviewQuestionsG/text()">
								<tr><td>Were interview questions asked?</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__InterviewQuestionsG"/></td></tr>
							</xsl:if>
							<xsl:if test = "GPersonPolReportFieldSobrietyTest__ProbableCauseG/text()">
								<tr><td>Intoxication probable cause determination:</td><td><xsl:value-of select = "GPersonPolReportFieldSobrietyTest__ProbableCauseG"/></td></tr>
							</xsl:if>
						</xsl:for-each>
						</table>

						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "185"
							     class = "first label"/>
							<col width = "140"
							     class = "value"/>
							<col width = "195"
							     class = "label"/>
							<col width = "150"
							     class = "value"/>
						</colgroup>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestWaitingPeriodStartTimeTZV2G/text()">
							<tr><td colspan = "3"
							        align = 'center'><i>Breath test/refusal</i></td></tr>
								<td>Time intoxilyzer operator began waiting period:</td><td><xsl:value-of select = "GPersonIntox__BreathTestWaitingPeriodStartTimeTZV2G"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestSubjectFastingG/text()">
								<td>No subject oral intake/vomit for 15 prior minutes:</td><td><xsl:value-of select = "GPersonIntox__BreathTestSubjectFastingG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestIdNumberG/text()">
								<td>Intoxilyzer record number:</td><td><xsl:value-of select = "GPersonIntox__BreathTestIdNumberG"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestIdNumber2G/text()">
								<td>Intoxilyzer serial number:</td><td><xsl:value-of select = "GPersonIntox__BreathTestIdNumber2G"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocOfficerRId_L/text()">
								<td>DIC 24 read by:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocOfficerRId_L"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__RightsReadLanguageG/text()">
								<td>Language DIC 24 read in:</td><td><xsl:value-of select = "GPersonIntox__RightsReadLanguageG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__RightsReadOnVideoG/text()">
								<td>DIC 24 read on video:</td><td><xsl:value-of select = "GPersonIntox__RightsReadOnVideoG"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__RightsReadTimeTZV2G/text()">
								<td>DIC 24 read time:</td><td><xsl:value-of select = "GPersonIntox__RightsReadTimeTZV2G"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__RightsUnderstoodG/text()">
								<td>Subject stated understood DIC 24:</td><td><xsl:value-of select = "GPersonIntox__RightsUnderstoodG"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestRefusedG/text()">
								<td>Subject refused test:</td><td><xsl:value-of select = "GPersonIntox__BreathTestRefusedG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocGPerson1RId_L/text()">
								<td>Intoxilyzer operator:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocGPerson1RId_L"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestEquipmentVerifiedG/text()">
								<td>Did intoxilyzer operator verify instrument in working order?</td><td><xsl:value-of select = "GPersonIntox__BreathTestEquipmentVerifiedG"/></td></xsl:if>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "520"
							     class = "first label"/>
							<col width = "150"
							     class = "value"/>
						</colgroup>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestAppearanceG/text()">
								<td>At time of test, did the subject appear more or less intoxicated than during roadside investigation?</td><td><xsl:value-of select = "GPersonIntox__BreathTestAppearanceG"/></td></xsl:if>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "185"
							     class = "first label"/>
							<col width = "140"
							     class = "value"/>
							<col width = "195"
							     class = "label"/>
							<col width = "150"
							     class = "value"/>
						</colgroup>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestsG/text()">
								<td>Chemical test:</td><td><xsl:value-of select = "GPersonIntox__BreathTestsG"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestTimeDG/text()">
								<td>Test given date:</td><td><xsl:value-of select = "GPersonIntox__BreathTestTimeDG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestResult1TimeTZV2G/text()">
								<td>Result 1 time (breath):</td><td><xsl:value-of select = "GPersonIntox__BreathTestResult1TimeTZV2G"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestResult1G/text()">
								<td>Result 1 BrAC (breath):</td><td><xsl:value-of select = "GPersonIntox__BreathTestResult1G"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BreathTestResult2TimeTZV2G/text()">
								<td>Result 2 time (breath):</td><td><xsl:value-of select = "GPersonIntox__BreathTestResult2TimeTZV2G"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__BreathTestResult2G/text()">
								<td>Result 2 BrAC (breath):</td><td><xsl:value-of select = "GPersonIntox__BreathTestResult2G"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__LicenseConfiscatedG/text()">
								<td>Driver's license confiscated:</td><td><xsl:value-of select = "GPersonIntox__LicenseConfiscatedG"/></td></xsl:if>
							<xsl:if test = "GPersonIntox__LicenseSuspensionNoticeTimeDG/text()">
								<td>Notice of suspension date:</td><td><xsl:value-of select = "GPersonIntox__LicenseSuspensionNoticeTimeDG"/></td></xsl:if>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "250"
							     class = "first label"/>
							<col width = "350"
							     class = "value"/>
						</colgroup>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDIssuingGPersonRId_L/text()">
								<td>Subject personally issued DIC 25 by:</td><td><xsl:value-of select = "GPersonIntox__GPPLDIssuingGPersonRId_L"/></td></xsl:if>
						</tr>
						</table>
						<table border = "0"
						       cellpadding = "1"
						       cellspacing = "0">
						<colgroup>
							<col width = "370"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
						</colgroup>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocGPerson2RId_L/text()">
							<tr><td colspan = "3"
							        align = 'center'><i>Blood draw</i></td></tr>
								<td>Person who withdrew blood sample:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocGPerson2RId_L"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocGPerson3RId_L/text()">
								<td>Employer of sample collector:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocGPerson3RId_L"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BloodTakenByOccupationG/text()">
								<td>Person who withdrew blood is employed as:</td><td><xsl:value-of select = "GPersonIntox__BloodTakenByOccupationG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocGPerson4RId_L/text()">
								<td>Facility where specimen collected:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocGPerson4RId_L"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BloodDrawTimeTZV2G/text()">
								<td>Specimen extraction time:</td><td><xsl:value-of select = "GPersonIntox__BloodDrawTimeTZV2G"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BloodDrawLocationSanitaryG/text()">
								<td>Was the location where blood was drawn sanitary?</td><td><xsl:value-of select = "GPersonIntox__BloodDrawLocationSanitaryG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__BloodTakenByOccupationG/text()">
								<td>Officer who observed blood draw:</td><td><xsl:value-of select = "GPersonIntox__BloodTakenByOccupationG"/></td></xsl:if>
						</tr>
						<tr>
							<xsl:if test = "GPersonIntox__GPPLDAssocOfficer3RId_L/text()">
								<td>Specimen submitted to the property room by:</td><td><xsl:value-of select = "GPersonIntox__GPPLDAssocOfficer3RId_L"/></td></xsl:if>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonIntox__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "WitnessReport">
					<DIV class = "separatePage">
					<h3><xsl:value-of select = "GPersonStatement__EntityDisplayName"/>, Incident: <xsl:value-of select = "GPersonStatement__OccurrenceFileNoG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Stmt taker:</td>
							<td><xsl:value-of select = "GPersonStatement__GPSStateTakerRId_L"/></td>
							<td>Stmt time:</td>
							<td><xsl:value-of select = "GPersonStatement__StartTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonStatement__GPersonStatementEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonStatement__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GPersonStatement__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "ExternalPersonReport">
					<h3>Subject document: <xsl:value-of select = "GPersonPolExtDoc__TitleG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Incident:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonPolExtDoc__OccurrenceFileNoG"/></td>
						</tr>
						<tr>
							<td>Subject:</td>
							<td colspan = "3"><xsl:value-of select = "nicheFunctions:normalizeLabel(string(../../InvolvedGPersons__LabelRightTab), ' / ', ';1;2;')"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GPersonPolExtDoc__GPersonPolReportAuthLabel"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GPersonPolExtDoc__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GPersonPolExtDoc__GPersonPolReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GPersonPolExtDoc__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Vehicle:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonPolExtDoc__GPPEDAssocGVehicleRId_L"/></td>
						</tr>
						<tr>
							<td>Officer:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonPolExtDoc__GPPEDAssocOfficerRId_L"/></td>
						</tr>
						<tr>
							<td>Case file:</td>
							<td colspan = "3"><xsl:value-of select = "GPersonPolExtDoc__GPersonPolReportCourtFolderRId_L"/></td>
						</tr>
					</table>
				</xsl:template>

				<xsl:template name = "GenOccReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "GenOccReport__EntityDisplayName"/>, Incident: <xsl:value-of select = "GenOccReport__OccurrenceFileNoWhole"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "GenOccReport__GOccReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "GenOccReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "GenOccReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "GenOccReport__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "GenOccReport__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "EnquiryLog">
					<h3><xsl:value-of select = "EnquiryLog__EntityDisplayName"/></h3>
					<table width = "98%"
					       align = "center">
						<colgroup>
							<col width = "15%"/>
							<col width = "15%"/>
							<col width = "15%"/>
							<col width = "15%"/>
							<col width = "3%"/>
							<col width = "37%"/>
						</colgroup>
						<tr>
							<td class = "TableHeader">Type</td>
							<td class = "TableHeader">Entry time</td>
							<td class = "TableHeader">Event time</td>
							<td class = "TableHeader">Author</td>
							<td class = "TableHeader">Link</td>
							<td class = "TableHeader">Log entry</td>
						</tr>
						<xsl:for-each select = "/DATASETLIST/DATASET/ROW/DATASET/ROW/DATASET/ROW[LogEntry_Type]">
							<tr>
								<td class = "TableData"><xsl:value-of select = "LogEntry_Type"/></td>
								<td class = "TableData"><xsl:value-of select = "LogEntry__CreTimeTZV2GL"/></td>
								<td class = "TableData"><xsl:value-of select = "LogEntry__StartTimeTZV2G"/></td>
								<td class = "TableData"><xsl:value-of select = "LogEntry__GOccurrenceTREventActivityLogAuthRId_L"/></td>
								<td class = "TableData">
									<xsl:choose>
										<xsl:when test = "LogEntry__HasExternalSystemURI = 'True'">Yes</xsl:when>
										<xsl:otherwise>No</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class = "TableData"><xsl:value-of disable-output-escaping = "yes"
								                                      select = "LogEntry__DetailsAsHTML"/></td>
							</tr>
						</xsl:for-each>
					</table>
				</xsl:template>

				<xsl:template name = "SupOccReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "SupOccReport__EntityDisplayName"/>, Incident: <xsl:value-of select = "SupOccReport__OccurrenceFileNoWhole"/> </h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "SupOccReport__GOccReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "SupOccReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "SupOccReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "SupOccReport__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "SupOccReport__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "FraudDocOccReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "FraudDocOccReport__EntityDisplayName"/>, Incident: <xsl:value-of select = "FraudDocOccReport__OccurrenceFileNoWhole"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "FraudDocReport__GOccReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "FraudDocReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "FraudDocReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "FraudDocReport__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "FraudDocOccReport__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "NotesOccReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "NotesOccReport__EntityDisplayName"/>, Incident: <xsl:value-of select = "NotesOccReport__OccurrenceFileNoWhole"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "NotesOccReport__GOccReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "NotesOccReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "NotesOccReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "NotesOccReport__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "4">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "NotesOccReport__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "MVCOccReport">
				<DIV class = "separatePage">
					<h3><xsl:value-of select = "MVCOccReport__EntityDisplayName"/>:</h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "MVCOccReport__GOccReportAuthRId_L"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "MVCOccReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "MVCOccReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "MVCOccReport__EnteredTimeTZV2G"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "200"
							     class = "first label"/>
							<col width = "100"
							     class = "value"/>
							<col width = "130"
							     class = "label"/>
							<col width = "100"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Reporting officer attended scene:</td>
							<td><xsl:value-of select = "MVCOccReport__OfficerAttendG"/></td>
							<td>AIS/AI investigating:</td>
							<td><xsl:value-of select = "MVCOccReport__MVCUnitInvestigationG"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "200"
							     class = "value"/>
							<col width = "130"
							     class = "label"/>
							<col width = "240"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>AIS/AI officer:</td>
							<td colspan = "3"><xsl:value-of select = "MVCOccReport__MVCUnitOfficerRId_L"/></td>
						</tr>
						<tr>
							<td>Accident type:</td>
							<td><xsl:value-of select = "MVCOccReport__AccidentSeverity1G"/></td>
							<td>Severity of accident:</td>
							<td><xsl:value-of select = "MVCOccReport__AccidentSeverity2G"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "170"
							     class = "first label"/>
							<col width = "50"
							     class = "value"/>
							<col width = "150"
							     class = "label"/>
							<col width = "100"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "100"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Police vehicle involved:</td>
							<td><xsl:value-of select = "MVCOccReport__PoliceVehicleG"/></td>
							<td>Number of units involved:</td>
							<td><xsl:value-of select = "MVCOccReport__NumberUnits"/></td>
							<td>Speed limit:</td>
							<td><xsl:value-of select = "MVCOccReport__SpeedLimitG"/></td>
						</tr>
					</table>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "170"
							     class = "first label"/>
							<col width = "500"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Atmospheric conditions:</td>
							<td><xsl:value-of select = "MVCOccReport__WeatherConditionG"/></td>
						</tr>
						<tr>
							<td>Lighting conditions:</td>
							<td><xsl:value-of select = "MVCOccReport__LightConditionG"/></td>
						</tr>
						<tr>
							<td>Traffic control:</td>
							<td><xsl:value-of select = "MVCOccReport__IntersectionControlG"/></td>
						</tr>
						<tr>
							<td>Traffic control text:</td>
							<td><xsl:value-of select = "MVCOccReport__IntersectionControlDetailsG"/></td>
						</tr>
						<tr>
							<td>Road surface:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadConditionG"/></td>
						</tr>
						<tr>
							<td>Roadway feature:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadFeature1G"/></td>
						</tr>
						<tr>
							<td>Roadway feature text:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadFeature1DetailsG"/></td>
						</tr>
						<tr>
							<td>Horizontal road alignment:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadFeature2G"/></td>
						</tr>
						<tr>
							<td>Vertical road alignment:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadFeature3G"/></td>
						</tr>
						<tr>
							<td>Divided road:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadDividedG"/></td>
						</tr>
						<tr>
							<td>Number of lanes:</td>
							<td><xsl:value-of select = "MVCOccReport__RoadLanesG"/></td>
						</tr>
						<tr>
							<td>Nature of crash:</td>
							<td><xsl:value-of select = "MVCOccReport__AccidentTypeG"/></td>
						</tr>
						<tr>
							<td>Nature of crash text:</td>
							<td><xsl:value-of select = "MVCOccReport__AccidentTypeDetailsG"/></td>
						</tr>
						<tr>
							<td>Off/on road:</td>
							<td><xsl:value-of select = "MVCOccReport__AccidentLocationTypeG"/></td>
						</tr>
						<tr>
							<td>Narrative:</td>
						</tr>
						<tr>
							<td colspan = "2">
								<xsl:call-template name = "ShowNarrative">
									<xsl:with-param name = "Id"
									                select = "MVCOccReport__Id"/>
								</xsl:call-template>
							</td>
						</tr>
					</table>
					</DIV>
				</xsl:template>

				<xsl:template name = "ExtDocOccReport">
					<h3>Incident Document: <xsl:value-of select = "ExtDocOccReport__TitleG"/></h3>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0">
						<colgroup>
							<col width = "100"
							     class = "first label"/>
							<col width = "300"
							     class = "value"/>
							<col width = "100"
							     class = "label"/>
							<col width = "170"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>Incident:</td>
							<td colspan = "3"><xsl:value-of select = "ExtDocOccReport__OccurrenceFileNoWhole"/></td>
						</tr>
						<tr>
							<td>Author:</td>
							<td><xsl:value-of select = "ExtDocOccReport__GOccReportAuthLabel"/></td>
							<td>Report time:</td>
							<td><xsl:value-of select = "ExtDocOccReport__ReportTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Entered by:</td>
							<td><xsl:value-of select = "ExtDocOccReport__GOccReportEnterRId_L"/></td>
							<td>Entered time:</td>
							<td><xsl:value-of select = "ExtDocOccReport__EnteredTimeTZV2G"/></td>
						</tr>
						<tr>
							<td>Person:</td>
							<td colspan = "3"><xsl:value-of select = "ExtDocOccReport__EDORAssocGPersonRId_L"/></td>
						</tr>
						<tr>
							<td>Address:</td>
							<td colspan = "3"><xsl:value-of select = "ExtDocOccReport__EDORAssocPARId_L"/></td>
						</tr>
						<tr>
							<td>Vehicle:</td>
							<td colspan = "3"><xsl:value-of select = "ExtDocOccReport__EDORAssocGVehicleRId_L"/></td>
						</tr>
						<tr>
							<td>Officer:</td>
							<td colspan = "3"><xsl:value-of select = "ExtDocOccReport__EDORAssocOfficerRId_L"/></td>
						</tr>
					</table>
				</xsl:template>

				<xsl:template name = "ShowNarrative">
					<xsl:param name = "Id"/>
					<table border = "0"
					       cellpadding = "0"
					       cellspacing = "0"
					       CLASS = "NARR"
					       width = "98%">
						<colgroup>
							<col width = "100%"
							     class = "value"/>
						</colgroup>
						<tr>
							<td>
								<xsl:element name = "narrative">
									<xsl:attribute name = "column">DocData</xsl:attribute>
									<xsl:value-of select = "$Id"/>
								</xsl:element>
							</td>
						</tr>
					</table>
				</xsl:template>

				<msxsl:script language = "JScript"
				              implements-prefix = "nicheFunctions">
					function normalizeLabel(theString, theDelimiter, hideColumnList)
					{
						var arr = theString.split(theDelimiter);
						var ret = "";
						for (var i=0; i &lt; arr.length; i++)
						{
							if (arr[i] != '' &amp;&amp; hideColumnList.indexOf(";" + String(i+1) + ";") == -1)
							{
								if (ret != "")
									ret += theDelimiter;
								ret += arr[i];
							}
						}
						return String(ret);
					}
				</msxsl:script>

				<msxsl:script language = "JScript"
				              implements-prefix = "nicheFunctions">
					function prependLabel(theString, theDelimiter, prependIndex)
					{
						//Return immediately if you're only prepending a string.
						if(isNaN(prependIndex)) return prependIndex + theDelimiter + theString;

						var arr = theString.split(theDelimiter);
						var ret = arr[prependIndex];
						for (var i=0; i &lt; arr.length; i++)
						{
							if (i == prependIndex) continue;
							ret += theDelimiter + arr[i];
						}
						return String(ret);
					}
				</msxsl:script>

			</xsl:stylesheet>


    ]]></ReportXSL>
    <DatawindowDef>
        <![CDATA[
				choicelist cl_empty
				{
					choices = {
						"" { ""; }
					};
				};
				choicelist cl_showselection
				{
					choices = {
						"0" { "Current"; }
						"1" { "All"; }
					};
				};
				declare FieldStatus edit
				{
					size = 1000;
					default = "GGGGGGGGG";
				};
				declare ShowEmail checkbox
				{
					label = "Email:";
					default = "1";
				};
				declare ShowClassification checkbox
				{
					label = "Classification:";
					default = "1";
				};
				declare ShowNames checkbox
				{
				  label="Names:";
				  default = "1";
				};
				declare ShowDOB checkbox
				{
					label = "DOB:";
					default = "1";
				};
				declare ShowSSN checkbox
				{
					label = "SSN:";
					default = "0";
				};
				declare ShowDL checkbox
				{
					label = "DL:";
					default = "1";
				};
				declare ShowAddress checkbox
				{
					label = "Address:";
					default = "1";
				};
				declare ShowPhone checkbox
				{
					label = "Telephone:";
					default = "1";
				};
				declare ShowDescriptors checkbox
				{
					label = "Person Descriptors:";
					default = "1";
				};
				declare ShowOccurrences checkbox
				{
					label = "Associated Incidents:";
					default = "1";
				};
				declare ShowPersons checkbox
				{
					label = "Involved Persons:";
					default = "1";
				};
				declare ShowAddresses checkbox
				{
					label = "Involved Addresses:";
					default = "1";
				};
				declare ShowCommAddresses checkbox
				{
					label = "Involved Comm Addresses:";
					default = "0";
				};
				declare ShowVehicles checkbox
				{
					label = "Involved Vehicles:";
					default = "1";
				};
				declare ShowOfficers checkbox
				{
					label = "Involved Officers/Units:";
					default = "1";
				};
				declare ShowProperty checkbox
				{
					label = "Involved Property:";
					default = "1";
				};
				declare ShowMO checkbox
				{
					label = "Modus Operandi:";
					default = "1";
				};
				declare ShowGenOccReport checkbox
				{
					label = "General:";
					default = "1";
				};
				declare ShowSupOccReport checkbox
				{
					label = "Supplementary:";
					default = "1";
				};
				declare ShowFraudDocOccReport checkbox
				{
					label = "Fraudulent Document:";
					default = "1";
				};
				declare ShowGPersonArrest checkbox
				{
					label = "Arrest:";
					default = "1";
				};
				declare ShowGPersonVictim checkbox
				{
					label = "Victim:";
					default = "1";
				};
				declare ShowGPersonDeath checkbox
				{
					label = "Homicide/Sudden Death:";
					default = "1";
				};
				declare ShowGPersonMissing checkbox
				{
					label = "Missing Person:";
					default = "1";
				};
				declare ShowGVehicleSC checkbox
				{
					label = "Vehicle in motion report:";
					default = "1";
				};
				declare ShowGPersonSC checkbox
				{
					label = "Driver contact report:";
					default = "1";
				};
				declare ShowGPersonIntox checkbox
				{
					label = "Intoxication report:";
					default = "1";
				};
				declare ShowGPersonStatement checkbox
				{
					label = "Witness Statement:";
					default = "1";
				};
				declare ShowGPersonPolExtDoc checkbox
				{
					label = "External Person:";
					default = "1";
				};
				declare ShowNotesOccReport checkbox
				{
					label = "Notes:";
					default = "1";
				};
				declare ShowMVCOccReport checkbox
				{
					label = "Traffic Crash:";
					default = "0";
				};
				declare ShowExtDocOccReport checkbox
				{
					label = "External Incident:";
					default = "1";
				};
				declare ShowEnquiryLog checkbox
				{
					label = e"Enquiry log:"s"Inquiry log:";
					default = "1";
				};
				declare ShowACL checkbox
				{
					label = e"ACL:";
					default = "0";
				};

				datawindowdef ParameterWindow "ParameterWindow"
				{
					//total width = 2432
					griddef
					{
						columns = 3;
						labelwidth = 338;
						fieldwidth = 439;
						gutter = 20;
						labelfieldspace = 20;
						rowspace = 28;
						leftmargin = 0;
						rightmargin = 100;
						defaultfieldheight = 56;
					};


					text Title
					{
						label = "Incident Details";
						fontstyle = "Arial";
						fontsize = 15;
						fonteffect = Bold!;
						location = page;
						align = center;
						height = 92;
					};
					break(50);

					griddef
					{
						columns = 2;
						labelwidth = 100;
						fieldwidth = 900;
						leftmargin = 800;
					};

					field ShowPersons;
					field ShowProperty;
					field ShowVehicles;
					field ShowOccurrences;
					field ShowOfficers;
					field ShowAddresses;
					field ShowCommAddresses;
					field ShowMO;
					break(50);

					griddef
					{
						columns = 1;
						gutter = 20;
						labelfieldspace = 20;
						rowspace = 28;
						leftmargin = 50;
						rightmargin = 50;
						defaultfieldheight = 56;
					};

					text Involved_Person_Heading
					{
						label = "Involved Person Attributes";
						fontstyle = "Arial";
						fontsize = 11;
						fonteffect = Bold!;
						align = left;
						height = 82;
						location = page;
					};
					break;

					griddef
					{
						columns = 2;
						labelwidth = 100;
						fieldwidth = 900;
						leftmargin = 800;
					};

					field ShowClassification;
					field ShowDOB;
					field ShowDL;
					field ShowSSN { visible = expression "if (f_GetProperty('Customization.XSLTReport_OccurrenceReport_ShowSSNOption', '', '') <> '0', 1, 0)"; };
					field ShowAddress;
					field ShowEmail;
					field ShowPhone;
					field ShowDescriptors;
					break(50);

					griddef
					{
						columns = 1;
						gutter = 20;
						labelfieldspace = 20;
						rowspace = 28;
						leftmargin = 50;
						rightmargin = 50;
						defaultfieldheight = 56;
					};

					text Reports_Heading
					{
						label = "Reports";
						fontstyle = "Arial";
						fontsize = 11;
						fonteffect = Bold!;
						align = left;
						height = 82;
						location = page;
					};
					break;

					griddef
					{
						columns = 2;
						labelwidth = 100;
						fieldwidth = 900;
						leftmargin = 800;
					};

					field ShowEnquiryLog;
					field ShowGenOccReport;
					field ShowGPersonArrest;
					field ShowGPersonVictim;
					field ShowGPersonDeath;
					field ShowGPersonMissing;
					field ShowGPersonIntox;
					field ShowGPersonSC;
					field ShowGVehicleSC;
					field ShowGPersonStatement;
					field ShowSupOccReport;
					field ShowFraudDocOccReport;
					field ShowNotesOccReport;
					field ShowMVCOccReport;
					field ShowGPersonPolExtDoc;
					field ShowExtDocOccReport;
					field ShowACL;
                    field ShowNames;

					computedfield CreTimeG
					{
						visible = false;
						expression = "f_GetDateTimeGFromC(f_GetDateTimeNowC())";
					};

					field FieldStatus
					{
						visible = false;
					};

				};


				group Parameter_Group "ParameterGroup"
				{
					ParameterWindow
				};
		]]>
    </DatawindowDef>
    <ParameterXAML>
        <ResourceDictionary xmlns = "http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                            xmlns:x = "http://schemas.microsoft.com/winfx/2006/xaml"
                            xmlns:b = "clr-namespace:Niche;assembly=NC5Base"
                            xmlns:bx = "clr-namespace:Niche;assembly=NC5BaseXAML"
                            xmlns:c = "clr-namespace:Niche;assembly=NC5XFormControlLibrary"
                            xmlns:u = "clr-namespace:Niche;assembly=UIUtilityCS"
                            xmlns:ncs = "clr-namespace:Niche;assembly=NicheUtilityCS"
        >
            <b:cl_cFieldBehaviorXSLTReport x:Key = "XSLTReportFieldBehavior" />

            <ncs:ds_cSpecificationInline x:Key = "DataSpecification">
                <x:XData>
                    <DSL xmlns = "">
                        <Metadata>

                            <ChoiceList Name = "cl_bool">
                                <Choice DBValue = "0"
                                        GUIValue = "0" />
                                <Choice DBValue = "1"
                                        GUIValue = "1" />
                            </ChoiceList>
                            <Entity Name = "Parameters">
                                <BoolField Name = "ShowOccurrences"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowPersons"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowAddresses"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowCommAddresses"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowVehicles"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowOfficers"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowProperty"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowMO"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGenOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowSupOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowFraudDocOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonArrest"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonVictim"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonDeath"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonMissing"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGVehicleSC"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonSC"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonIntox"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonStatement"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowGPersonPolExtDoc"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowNotesOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowMVCOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowExtDocOccReport"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowEnquiryLog"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowSSN"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowDescriptors"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowClassification"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowDOB"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowDL"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowAddress"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowPhone"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowEmail"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowACL"
                                           ChoiceListName = "cl_bool" />
                                <BoolField Name = "ShowNames"
                                           ChoiceListName = "cl_bool" />
                            </Entity>
                        </Metadata>
                        <Entity Name = "Parameters"
                                DSLBased = "True">
                            <Field Name = "ShowOccurrencesG"
                            />
                            <Field Name = "ShowPersonsG"
                            />
                            <Field Name = "ShowAddressesG"
                            />
                            <Field Name = "ShowCommAddressesG"
                            />
                            <Field Name = "ShowVehiclesG"
                            />
                            <Field Name = "ShowOfficersG"
                            />
                            <Field Name = "ShowPropertyG"
                            />
                            <Field Name = "ShowMOG"
                            />
                            <Field Name = "ShowGenOccReportG"
                            />
                            <Field Name = "ShowSupOccReportG"
                            />
                            <Field Name = "ShowFraudDocOccReportG"
                            />
                            <Field Name = "ShowGPersonArrestG"
                            />
                            <Field Name = "ShowGPersonVictimG"
                            />
                            <Field Name = "ShowGPersonDeathG"
                            />
                            <Field Name = "ShowGPersonMissingG"
                            />
                            <Field Name = "ShowGVehicleSCG"
                            />
                            <Field Name = "ShowGPersonSCG"
                            />
                            <Field Name = "ShowGPersonIntoxG"
                            />
                            <Field Name = "ShowGPersonStatementG"
                            />
                            <Field Name = "ShowGPersonPolExtDocG"
                            />
                            <Field Name = "ShowNotesOccReportG"
                            />
                            <Field Name = "ShowMVCOccReportG"
                            />
                            <Field Name = "ShowExtDocOccReportG"
                            />
                            <Field Name = "ShowEnquiryLogG"
                            />
                            <Field Name = "ShowSSNG"
                            />
                            <Field Name = "ShowDescriptorsG"
                            />
                            <Field Name = "ShowClassificationG"
                            />
                            <Field Name = "ShowDOBG"
                            />
                            <Field Name = "ShowDLG"
                            />
                            <Field Name = "ShowAddressG"
                            />
                            <Field Name = "ShowPhoneG"
                            />
                            <Field Name = "ShowEmailG"
                            />
                            <Field Name = "ShowACLG"
                            />
                            <Field Name = "ShowNamesG"
                            />
                        </Entity>
                    </DSL>
                </x:XData>
            </ncs:ds_cSpecificationInline>
            <b:dp_cHierarchySpecification x:Key = "InitialHierarchy">
                <x:XData>
                    <Data xmlns = "">
                        <Node Name = "Parameters"
                              DSLBased = "true">
                            <Cell Name = "ShowOccurrencesG"
                                  Value = "1" />
                            <Cell Name = "ShowPersonsG"
                                  Value = "1" />
                            <Cell Name = "ShowAddressesG"
                                  Value = "1" />
                            <Cell Name = "ShowCommAddressesG"
                                  Value = "1" />
                            <Cell Name = "ShowVehiclesG"
                                  Value = "1" />
                            <Cell Name = "ShowOfficersG"
                                  Value = "1" />
                            <Cell Name = "ShowPropertyG"
                                  Value = "1" />
                            <Cell Name = "ShowMOG"
                                  Value = "1" />
                            <Cell Name = "ShowGenOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowSupOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowFraudDocOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonArrestG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonVictimG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonDeathG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonMissingG"
                                  Value = "1" />
                            <Cell Name = "ShowGVehicleSCG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonSCG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonIntoxG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonStatementG"
                                  Value = "1" />
                            <Cell Name = "ShowGPersonPolExtDocG"
                                  Value = "1" />
                            <Cell Name = "ShowNotesOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowMVCOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowExtDocOccReportG"
                                  Value = "1" />
                            <Cell Name = "ShowEnquiryLogG"
                                  Value = "1" />
                            <Cell Name = "ShowSSNG"
                                  Value = "1" />
                            <Cell Name = "ShowDescriptorsG"
                                  Value = "1" />
                            <Cell Name = "ShowClassificationG"
                                  Value = "1" />
                            <Cell Name = "ShowDOBG"
                                  Value = "1" />
                            <Cell Name = "ShowDLG"
                                  Value = "1" />
                            <Cell Name = "ShowAddressG"
                                  Value = "1" />
                            <Cell Name = "ShowPhoneG"
                                  Value = "1" />
                            <Cell Name = "ShowEmailG"
                                  Value = "1" />
                            <Cell Name = "ShowACLG"
                                  Value = "1" />
                            <Cell Name = "ShowNamesG"
                                  Value = "1" />
                        </Node>
                    </Data>
                </x:XData>
            </b:dp_cHierarchySpecification>
            <DataTemplate x:Key = "UIDataTemplate">
                <StackPanel DataContext = "{Binding Data.FirstNode}"
                            c:cl_fFieldBehavior.FieldBehavior = "{StaticResource XSLTReportFieldBehavior}">
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowOccurrencesG}"
                                               LabelText = "Associated Incidents" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowPersonsG}"
                                               LabelText = "Involved Persons" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowAddressesG}"
                                               LabelText = "Address" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowCommAddressesG}"
                                               LabelText = "Involved Comm Addressrd" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowVehiclesG}"
                                               LabelText = "Involved Vehicles" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowOfficersG}"
                                               LabelText = "Involved Officer(s)" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowPropertyG}"
                                               LabelText = "Involved Property" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowMOG}"
                                               LabelText = "Modus Operandi" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGenOccReportG}"
                                               LabelText = "General Report" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowSupOccReportG}"
                                               LabelText = "Supplement Report" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowFraudDocOccReportG}"
                                               LabelText = "Fraudulent Document" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonArrestG}"
                                               LabelText = "Arrested Person(s)" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonVictimG}"
                                               LabelText = "Victims" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonDeathG}"
                                               LabelText = "Homicide/Sudden Death" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonMissingG}"
                                               LabelText = "Missing Person" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGVehicleSCG}"
                                               LabelText = "Vehicle in motion report" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonSCG}"
                                               LabelText = "Driver Contact Report" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonIntoxG}"
                                               LabelText = "Intoxication Report" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonStatementG}"
                                               LabelText = "Witness Statement" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowGPersonPolExtDocG}"
                                               LabelText = "External Person" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowNotesOccReportG}"
                                               LabelText = "Notes" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowMVCOccReportG}"
                                               LabelText = "Motor Vehicle Crash" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowExtDocOccReportG}"
                                               LabelText = "External Document" />

                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowEnquiryLogG}"
                                               LabelText = "Action Entry" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowClassificationG}"
                                               LabelText = "Classification" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowDOBG}"
                                               LabelText = "Date of Birth" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowSSNG}"
                                               LabelText = "Social Security" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowDLG}"
                                               LabelText = "Drivers License" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowAddressG}"
                                               LabelText = "Address" />
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowPhoneG}"
                                               LabelText = "Telephone" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowEmailG}"
                                               LabelText = "Email" />

                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowDescriptorsG}"
                                               LabelText = "Person Descriptors" />
                    </u:uc_cFlowGrid>
                    <u:uc_cFlowGrid Columns = "2">
                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowACLG}"
                                               LabelText = "ACL" />

                        <c:cl_cNMLFieldControl DataValue = "{Binding ShowNamesG}"
                                               LabelText = "Alias" />
                    </u:uc_cFlowGrid>
                </StackPanel>

            </DataTemplate>
            <b:dp_cNamedActionDictionary x:Key = "NamedActions" />
            <b:cl_cContentSpecification x:Key = "XSLTReportParameters"
                                        NamedActions = "{StaticResource NamedActions}"
                                        InitialHierarchySpecification = "{StaticResource InitialHierarchy}"
                                        Specification = "{StaticResource DataSpecification}"
                                        UIDataTemplate = "{StaticResource UIDataTemplate}" />
        </ResourceDictionary>
    </ParameterXAML>
</root>
