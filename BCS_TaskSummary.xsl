<?xml version="1.0" encoding="Windows-1252"?>
<root>
	<VersionInfo>
		<Filename>BCS_TaskSummaryList</Filename>
		<Revision>1.7</Revision>
		<NMLVersion>5.04.11.02.18</NMLVersion>
		<Developer>Niche</Developer>
		<NicheBuildName>BexarCounty</NicheBuildName>
		<BuildTime>2018/07/21 22:08:08</BuildTime>
		<UpdateTime>11/26/2019 7:48 AM</UpdateTime>
	</VersionInfo>

	<!-- Information to be used when loading the report -->
	<!-- Is this report for an entire domain, rather than an instance of data -->
	<IsDomainReport>1</IsDomainReport>

	<!-- Should this show up in the list of reports for an entity in the print menu -->
	<IsPrintTemplate>1</IsPrintTemplate>

	<!-- Suggested report name in the print menu -->
	<ReportName>Task Summary List</ReportName>

	<!-- Can be enclosed in CDATA.  A general description of what the report does -->
	<Documentation>Displays Task Summary List</Documentation>

	<!-- SQL Parameter goes here -->
	<SQLParameter>ACCDomain</SQLParameter>
	<SQLParameter>TimeRange</SQLParameter>
	<SQLParameter>StartTime</SQLParameter>
	<SQLParameter>EndTime</SQLParameter>
	<SQLParameter>StartTimeMinus3Days</SQLParameter>
	<SQLParameter>EndTimePlus3Days</SQLParameter>
	<SQLParameter>NowMinus4Days</SQLParameter>
	<SQLParameter>NowMinus5Days</SQLParameter>
	<SQLParameter>NowMinus10Days</SQLParameter>
	<SQLParameter>AreaLevel6</SQLParameter>
	<SQLParameter>AreaLevel5</SQLParameter>
	<SQLParameter>AreaLevel4</SQLParameter>
	<SQLParameter>AreaLevel3</SQLParameter>
	<SQLParameter>AreaLevel2</SQLParameter>
	<SQLParameter>AreaLevel1</SQLParameter>

	<SQLParameter>OfficerUnitIds</SQLParameter>
	<SQLParameter>ClearanceStatus</SQLParameter>
	<SQLParameter>UseReportServer</SQLParameter>
	<SQLParameter>TaskType</SQLParameter>
	<SQLParameter>TaskStatus</SQLParameter>
	<!--XSLT Parameter goes here -->
	<XSLTParameter>TimeRange</XSLTParameter>
	<XSLTParameter>StartTimeG</XSLTParameter>
	<XSLTParameter>EndTimeG</XSLTParameter>
	<XSLTParameter>AreaLevel6</XSLTParameter>
	<XSLTParameter>AreaLevel5</XSLTParameter>
	<XSLTParameter>AreaLevel4</XSLTParameter>
	<XSLTParameter>AreaLevel3</XSLTParameter>
	<XSLTParameter>AreaLevel2</XSLTParameter>
	<XSLTParameter>AreaLevel1</XSLTParameter>
	<XSLTParameter>ClearanceStatusG</XSLTParameter>
	<XSLTParameter>TaskTypeDisp</XSLTParameter>
	<XSLTParameter>TaskStatusDisp</XSLTParameter>
	<XSLTParameter>OfficerUnitIds</XSLTParameter>
	<XSLTParameter>OfficerUnitCL</XSLTParameter>
	<ReportHeader>
		<![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p>"]]>
	</ReportHeader>

	<ReportFooter>
		<![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p><p align='center'>"e"Printed by:""&nbsp;&nbsp;[@AGBL=USERNUM]&nbsp;&nbsp;&nbsp;"e"Date:""&nbsp;&nbsp;[DATE] [TIME]&nbsp;&nbsp;&nbsp;"e"Computer:""&nbsp;&nbsp;[@AGBL=COMPUTERNAME]&nbsp;&nbsp;&nbsp;"e"Page"" [PAGENUM] of [PAGETOTAL]</p>"]]>
	</ReportFooter>

	<ReportHeaderTop></ReportHeaderTop>
	<ReportFooterBottom></ReportFooterBottom>
	<ReportDetailMarginTop></ReportDetailMarginTop>
	<ReportDetailMarginLeft></ReportDetailMarginLeft>
	<ReportDetailMarginRight></ReportDetailMarginRight>
	<ReportDetailMarginBottom></ReportDetailMarginBottom>
	<DefaultProtectiveMarking></DefaultProtectiveMarking>
	<OutputType>html</OutputType>

	<SQLSelectXSLT><![CDATA[




		  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		  	<xsl:output method = "text" omit-xml-declaration = "yes" />
				<xsl:param name = "ACCDomain" />
				<xsl:param name = "TimeRange" />
				<xsl:param name = "StartTime" />
				<xsl:param name = "EndTime" />
				<xsl:param name="StartTimeMinus3Days" />
				<xsl:param name="EndTimePlus3Days" />
				<xsl:param name="NowMinus4Days" />
				<xsl:param name="NowMinus5Days" />
				<xsl:param name="NowMinus10Days" />
				<xsl:param name = "AreaLevel6" />
				<xsl:param name = "AreaLevel5" />
				<xsl:param name = "AreaLevel4" />
				<xsl:param name = "AreaLevel3" />
				<xsl:param name = "AreaLevel2" />
				<xsl:param name = "AreaLevel1" />
				<xsl:param name = "OfficerUnitIds" />
				<xsl:param name = "ClearanceStatus" />
				<xsl:param name = "UseReportServer" />
				<xsl:param name = "ShowSuspects" />
				<xsl:param name = "ShowMO" />
                <xsl:param name = "TaskType" />
				<xsl:param name = "TaskStatus" />

			<xsl:template match = "/">
				  ----------------------------------------------------------
					--  XML filename: BCS_TaskSummaryList.xml
					--  File revision: 1.7
					--  NML version: 5.04.11.02.18
					--  Developer: Niche
					--  Niche build name: BexarCounty
					--  Build time: 2018/07/21 22:08:06
				  	-- 	Update time: 11/26/2019 07:48 AM
					----------------------------------------------------------

				  	<xsl:variable name = "PersonIds">
						<xsl:call-template name = "GetEntityIds">
							<xsl:with-param name = "Ids" select = "$OfficerUnitIds" />
							<xsl:with-param name = "EntityNumber">1500</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>

					<xsl:variable name = "OrgUnitIds">
						<xsl:call-template name = "GetEntityIds">
							<xsl:with-param name = "Ids" select = "$OfficerUnitIds" />
							<xsl:with-param name = "EntityNumber">1410</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>


				 SELECT
								GTask__Id,
								GTask__TaskNumber,
								GTask__StatusG,
								GTask__Type1G,
								GTask__DueTimeTZV2G,
								GTask__PriorityG,
								GTask__Title,
								GTask__ReminderTimeTZV2G,
								GTask__SupervisorApprovalRequired,
								GTask__InitiatorApprovalRequired,
								GTask__InitiatedTimeTZV2G,
								GTask__OpenTimeTZV2G,
								GTask__CompleteTimeTZV2G,
								GTask__TaskInitiatedByRId_L,
								GTask__InitiatorApprovedTZV2G,
								GTask__TaskAssignedToRId,
								GTask__TaskAssignedToRId_L,
								GTask__TaskAssignedToAssignedTimeTZV2G,
								GTask__TaskApprovalRId_L,
								GTask__TaskApprovalApprovalTimeTZV2G,
								GTask__Remarks,

								Occurrence__Id,
								Occurrence__LabelShort,
								Occurrence__UCRClearanceStatusG,


								Officer__Id,
								Officer__LabelEmpl,

								OrgPoliceUnit__Id,
								OrgPoliceUnit__LabelEmpl

							FROM GTask
								LEFT JOIN (TaskSubjectGOccurrence
								LEFT JOIN Occurrence)
								LEFT JOIN (TaskAssignedTo
									LEFT JOIN (Person Officer
									LEFT JOIN (GPersonOrgMemberGPerson
									LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId
									) ON GPersonOrgMemberGPerson.RId = Officer.Id
									AND GPersonOrgMemberGPerson.IsEffectiveAssignment = 1
								)
							)

							<xsl:variable name="TaskWhereClause">
								WHERE


								<xsl:if test="$StartTime != '' and $EndTime != ''">
									<xsl:text> GTask.InitiatedTimeTZV2I = MakeInterval(</xsl:text>
									<xsl:call-template name="StuffSQL"><xsl:with-param name="ToStuff" select="$StartTime" /></xsl:call-template>
									<xsl:text>, </xsl:text>
									<xsl:call-template name="StuffSQL"><xsl:with-param name="ToStuff" select="$EndTime" /></xsl:call-template>
									<xsl:text>, '[]', 'NullIsInfinite')</xsl:text>
								</xsl:if>
								<xsl:if test="$TaskType != ''">
									<xsl:text> AND </xsl:text>
									<xsl:call-template name="CreateConditionFromSet">
										<xsl:with-param name="FieldName">GTask.Type1</xsl:with-param>
										<xsl:with-param name="FieldValue" select="$TaskType" />
										<xsl:with-param name="IsSetField">0</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="$TaskStatus != ''">
									<xsl:text> AND </xsl:text>
									<xsl:call-template name="CreateConditionFromSet">
										<xsl:with-param name="FieldName">GTask.Status</xsl:with-param>
										<xsl:with-param name="FieldValue" select="$TaskStatus" />
										<xsl:with-param name="IsSetField">0</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								
                                    <xsl:if test="$ClearanceStatus">
									  AND EXISTS (
										  	SELECT GOccurrence.Id
										  		FROM TaskSubjectGOccurrence
										  			LEFT JOIN (GOccurrence
										  				LEFT JOIN CFSOccurrence )
										  	WHERE TaskSubjectGOccurrence.LId = GTask.Id
										  	<xsl:text> AND </xsl:text>
										  	<xsl:call-template name="CreateConditionFromSet">
										  		<xsl:with-param name="FieldName">CFSOccurrence.UCRClearanceStatus</xsl:with-param>
										  		<xsl:with-param name="FieldValue" select="$ClearanceStatus" />
										  		<xsl:with-param name="IsSetField">0</xsl:with-param>
										  	</xsl:call-template>


									)

								 </xsl:if>
								<xsl:if test = "$PersonIds !='' or $OrgUnitIds != ''">
									  AND (
									  <xsl:call-template name = "ComposeWith">
											<xsl:with-param name = "Separator"> OR </xsl:with-param>
											<xsl:with-param name="Strings">
												  <String>
														<xsl:if test="$PersonIds != ''">
															  EXISTS(
															  	SELECT Id FROM TaskAssignedTo TaskInvolvement
															  	WHERE LId = GTask.Id
															    AND TaskInvolvement.RId IN (<xsl:value-of select="$PersonIds" />)
															  )
														</xsl:if>
												  </String>
												  <String>
														<xsl:if test="$OrgUnitIds != ''">
															  EXISTS(
															  	SELECT Id FROM TaskAssignedTo TaskInvolvement
															  	WHERE LId = GTask.Id
															    AND EXISTS(
																	SELECT Id FROM GPersonOrgMemberGPerson
																	WHERE IsEffectiveAssignment = 1
																	AND RId = TaskInvolvement.RId
																	AND LId IN (<xsl:value-of select="$OrgUnitIds" />)
																	)
																)
														</xsl:if>
												  </String>
											</xsl:with-param>
									  </xsl:call-template>
									  )
								</xsl:if>




						</xsl:variable>
				 		<xsl:value-of select="$TaskWhereClause" />
						AND HierarchicalResult = 1

				  SELECT
						Occurrence__Id,
						Occurrence__LabelShort,

						PhysicalAddress__LabelAddressOnly__0,
						PhysicalAddress__ESAreaLevel3G__0
					FROM TaskSubjectGOccurrence
						LEFT JOIN (Occurrence
							LEFT JOIN (GOccIvPA
								LEFT JOIN PhysicalAddress
								) ON GOccIvPA.IsESAreaLevelSource = 1
							)
						LEFT JOIN GTask
						<xsl:value-of select="$TaskWhereClause" />


					<!--Officers Assigned To Tasks -->
					SELECT
						Officer__Id,
						Officer__LabelEmpl,

						GTask__Id,
						OrgPoliceUnit__Id__0,
						OrgPoliceUnit__LabelEmpl__0

						From TaskAssignedTo
							LEFT JOIN GTask
							LEFT JOIN (Person Officer
								LEFT JOIN (GPersonOrgMemberGPerson
									LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId
									) ON GPersonOrgMemberGPerson.RId = Officer.Id
								AND GPersonOrgMemberGPerson.IsEffectiveAssignment = 1
							)
					<xsl:value-of select="$TaskWhereClause" />

				  SELECT
				   DocData, Id AS BlobData_DocData_ExternalDocumentTemplate_Id
				  FROM
                        ExternalDocumentTemplate
                  WHERE TemplateKey = 'REPORT_LOGO'


				  <!-- Statistics Box -->
				  SELECT
								GUIValue,
								DBValue
							FROM ChoiceListReport
							WHERE ChoiceList='cl_TaskStatus'

			SELECT SPValue AS AgencyName FROM SystemParameterSettingForACC WHERE SPKey='Label.AgencyName'
					SELECT SPValue AS DivisionName, 1 AS CFDSIgnoreDataSetChanges FROM SystemParameterSettingForACC WHERE SPKey='Label.DivisionName'
					SELECT EmployeeNumber AS CurrentEmployeeNumber, Label AS CurrentUser, 1 AS CFDSIgnoreDataSetChanges FROM GPerson WHERE Id=@currentUserId

					select DataTimestampTZV2GL AS DataTimestamp, 1 AS CFDSIgnoreDataSetChanges FROM DataTimestamp
					<xsl:if test = "$UseReportServer = '1'">
						WHERE QueryServer = 'Report'
					</xsl:if>
				</xsl:template>


				<xsl:template name = "MultiValueField">
					<xsl:param name = "FormField" />
					<xsl:param name = "DBField" />
					<xsl:if test = "$FormField != ''">
						(
						<xsl:call-template name = "MultiValueFieldPart">
							<xsl:with-param name = "FormField"><xsl:value-of select = "$FormField" /></xsl:with-param>
							<xsl:with-param name = "DBField"><xsl:value-of select = "$DBField" /></xsl:with-param>
						</xsl:call-template>
						)
					</xsl:if>
				</xsl:template>

				<xsl:template name = "MultiValueFieldPart">
					<xsl:param name = "FormField" />
					<xsl:param name = "DBField" />
					<xsl:value-of select = "$DBField" /> LIKE
					<xsl:choose>
						<xsl:when test = "contains($FormField, ',')">
							<xsl:call-template name = "StuffSQL">
								<xsl:with-param name = "ToStuff">
									<xsl:value-of
											select = "normalize-space(translate(substring-before($FormField, ','), '*', '%'))" />
								</xsl:with-param>
							</xsl:call-template>
							 OR
							<xsl:call-template name = "MultiValueFieldPart">
								<xsl:with-param name = "FormField"><xsl:value-of
										select = "substring-after($FormField, ',')" /></xsl:with-param>
								<xsl:with-param name = "DBField"><xsl:value-of select = "$DBField" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name = "StuffSQL">
								<xsl:with-param name = "ToStuff">
									<xsl:value-of select = "normalize-space(translate($FormField, '*', '%'))" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>


				<xsl:template name = "CreateConditionFromSet">
					<xsl:param name = "FieldName" />
					<xsl:param name = "FieldValue" />
					<xsl:param name = "IsSetField" />
					<xsl:param name = "Prefix" />

					<xsl:variable name = "Condition">
						<xsl:call-template name = "CreateConditionFromSet_Recursive">
							<xsl:with-param name = "FieldName" select = "$FieldName" />
							<xsl:with-param name = "FieldValue"
									select = "substring($FieldValue, 2, string-length($FieldValue) - 2)" />
							<xsl:with-param name = "IsSetField" select = "$IsSetField" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test = "string-length($Condition) &gt; 0">
						<xsl:value-of select = "$Prefix" /><xsl:text>(</xsl:text>
							<xsl:value-of select = "$Condition" />
						<xsl:text>)</xsl:text>
					</xsl:if>
				</xsl:template>

				<xsl:template name = "CreateConditionFromSet_Recursive">
					<xsl:param name = "FieldName" />
					<xsl:param name = "FieldValue" />
					<xsl:param name = "IsSetField" />
					<xsl:param name = "Prefix" />

					<xsl:variable name = "ComparisonOperator">
						<xsl:choose>
							<xsl:when test = "$IsSetField = '1'"><xsl:text> LIKE </xsl:text></xsl:when>
							<xsl:otherwise><xsl:text> = </xsl:text></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:if test = "string-length($FieldValue) &gt; 0">

						<xsl:choose>
							<xsl:when test = "contains($FieldValue, ';')">
								<xsl:value-of select = "$Prefix" />
								<xsl:value-of select = "$FieldName" />
								<xsl:value-of select = "$ComparisonOperator" />
								<xsl:call-template name = "StuffSQL">
									<xsl:with-param name = "ToStuff">
										<xsl:choose>
											<xsl:when test = "$IsSetField = '1'"><xsl:text>%;</xsl:text><xsl:value-of
													select = "substring-before($FieldValue, ';')" /><xsl:text>;%</xsl:text></xsl:when>
											<xsl:otherwise><xsl:value-of
													select = "substring-before($FieldValue, ';')" /></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name = "CreateConditionFromSet_Recursive">
									<xsl:with-param name = "Prefix"><xsl:text> OR </xsl:text></xsl:with-param>
									<xsl:with-param name = "FieldName" select = "$FieldName" />
									<xsl:with-param name = "FieldValue" select = "substring-after($FieldValue, ';')" />
									<xsl:with-param name = "IsSetField" select = "$IsSetField" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select = "$Prefix" />
								<xsl:value-of select = "$FieldName" />
								<xsl:value-of select = "$ComparisonOperator" />
								<xsl:call-template name = "StuffSQL">
									<xsl:with-param name = "ToStuff">
										<xsl:choose>
											<xsl:when test = "$IsSetField = '1'"><xsl:text>%;</xsl:text><xsl:value-of
													select = "$FieldValue" /><xsl:text>;%</xsl:text></xsl:when>
											<xsl:otherwise><xsl:value-of select = "$FieldValue" /></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:if>

				</xsl:template>


				<xsl:template name = "StuffSQL">
					<xsl:param name = "ToStuff" />
					<xsl:text>'</xsl:text><xsl:call-template name = "StuffSQLPart"><xsl:with-param name = "ToStuff"><xsl:value-of
						select = "$ToStuff" /></xsl:with-param></xsl:call-template><xsl:text>'</xsl:text>
				</xsl:template>

				<xsl:template name = "StuffSQLPart">
					<xsl:param name = "ToStuff" />
					<xsl:variable name = "SingleQuote">'</xsl:variable>
					<xsl:choose>
						<xsl:when test = "contains($ToStuff, $SingleQuote)">
							<xsl:value-of select = "substring-before($ToStuff, $SingleQuote)" />
							<xsl:text>''</xsl:text>
							<xsl:call-template name = "StuffSQLPart">
								<xsl:with-param name = "ToStuff"><xsl:value-of
										select = "substring-after($ToStuff, $SingleQuote)" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select = "$ToStuff" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>


				<xsl:template name = "GetEntityIds">
					<xsl:param name = "Ids" />
					<xsl:param name = "EntityNumber" />
					<xsl:param name = "FirstInList">1</xsl:param>

					<xsl:variable name = "TrimmedIds"
							select = "translate(normalize-space(translate($Ids, '&#xD;&#xA;', ';;')), ' ', '')" />

					<xsl:if test = "string-length($TrimmedIds) &gt; 0">
						<xsl:variable name = "sep" select = "';'" />
						<xsl:choose>
							<xsl:when test = "contains($TrimmedIds, $sep)">
								<xsl:variable name = "id1" select = "substring-before($TrimmedIds, $sep)" />
								<xsl:variable name = "remainingIds" select = "substring-after($TrimmedIds, $sep)" />
								  <!--
									  The ID is of the form 'XXXXXYYYYYZZZZZZZZZZZZZZZ' (including quotes), where XXXXX is the
									  entity number, and is of variable length.  We start at the 2nd character (because of the quote),
									  and determine how many more characters to read based on the total length of the string.
									  We subtract 2 for the quotes, and 20 for YYYYYZZZZZZZZZZZZZZZ, leaving us with the position of
									  the last character of XXXXX.  So the call to substring() below converts 'XXXXXYYYYYZZZZZZZZZZZZZZZ'
									  into XXXXX.

									  This prevents us from accidentally identifying an Id for entity 15000 as a Person Id.
								  -->
								  <xsl:variable name = "EntityNumberForThisId"
										  select = "substring($id1, 1, string-length($id1) - 20)" />

								<xsl:if test = "$EntityNumberForThisId = $EntityNumber">
									<xsl:if test = "$FirstInList != 1"><xsl:text>,</xsl:text></xsl:if>
									<xsl:call-template name = "StuffSQL">
										<xsl:with-param name = "ToStuff" select = "normalize-space($id1)" />
									</xsl:call-template>
								</xsl:if>
								<xsl:if test = "string-length($remainingIds) &gt; 0">
									<!-- Make the recursive call -->
									  <xsl:call-template name = "GetEntityIds">
										<xsl:with-param name = "Ids" select = "$remainingIds" />
										<xsl:with-param name = "EntityNumber" select = "$EntityNumber" />
										<xsl:with-param name = "FirstInList">
											<xsl:choose>
												<xsl:when
														test = "$EntityNumberForThisId = $EntityNumber or $FirstInList = '0'">0</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<!-- There is only one Id so output it. -->
								  <xsl:variable name = "EntityNumberForThisId"
										  select = "substring($TrimmedIds, 1, string-length($TrimmedIds) - 20)" />
								<xsl:if test = "$EntityNumberForThisId = $EntityNumber">
									<xsl:if test = "$FirstInList != 1"><xsl:text>, &#xA;</xsl:text></xsl:if>
									<xsl:call-template name = "StuffSQL">
										<xsl:with-param name = "ToStuff" select = "$TrimmedIds" />
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:template>



				<xsl:template name = "ComposeWith" xmlns:msxsl = "urn:schemas-microsoft-com:xslt">
					<xsl:param name = "Strings" />
					<xsl:param name = "Separator">
						<xsl:text> / </xsl:text>
					</xsl:param>
					<xsl:for-each select = "msxsl:node-set($Strings)/String">
						<xsl:if test = "string-length(text()) &gt; 0 and count(preceding-sibling::String[string-length(.) &gt; 0]) &gt; 0">
							<xsl:value-of select = "$Separator" />
						</xsl:if>
						<xsl:value-of select = "./text()" />
					</xsl:for-each>
				</xsl:template>

	</xsl:stylesheet>






    ]]></SQLSelectXSLT>

	<ReportXSL>
		<![CDATA[
        <?xml version="1.0" encoding="Windows-1252"?>
			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nicheFunctions="urn:nicheFunctions" xmlns:nl="urn:nicheLanguage" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
				<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
				<xsl:param name="TimeRange" />
				<xsl:param name="StartTimeG" />
				<xsl:param name="EndTimeG" />
				<xsl:param name="AreaLevel6" />
				<xsl:param name="AreaLevel5" />
				<xsl:param name="AreaLevel4" />
				<xsl:param name="AreaLevel3" />
				<xsl:param name="AreaLevel2" />
				<xsl:param name="AreaLevel1" />
				<xsl:param name="LegacyBoloReport" />
				<xsl:param name="BoloReport" />
				<xsl:param name="FlagTypeG" />
				<xsl:param name="FlagActive" />
				<xsl:param name="TaskTypeG" />
				<xsl:param name="TaskStatusG" />
				<xsl:param name="OfficerUnitIds" />
				<xsl:param name="OfficerUnitCL" />

				<xsl:key name = "Officer" match = "/DATASETLIST/DATASET/ROW/GTask__TaskAssignedToRId"
								use = "." />
				<xsl:key name = "Unit" match = "/DATASETLIST/DATASET/ROW/OrgPoliceUnit__Id" use = "." />

				<xsl:template match="/">
					<xsl:element name="HTML">
						<xsl:variable name="ReportTitle">
							<xsl:text><nl:mls><e>Task</e></nl:mls> summary list</xsl:text>

						</xsl:variable>
						<xsl:element name="title"><xsl:value-of select="$ReportTitle" /></xsl:element>

						<!-- Insert the style class declarations -->
						<xsl:call-template name="StyleClasses" />

						<xsl:element name="BODY">
							<!-- Insert the title-->
							<xsl:call-template name="Title">
								<xsl:with-param name="Text" select="$ReportTitle" />
							</xsl:call-template>
							<xsl:if test="/DATASETLIST/DATASET/ROW/DocData != ''">
                                <narrative column="DocData" height="60" width="40">
                                    <xsl:value-of select="/DATASETLIST/DATASET/ROW/BlobData_DocData_ExternalDocumentTemplate_Id" />
                                </narrative>
                            </xsl:if>
							<!-- Insert the info box -->
							<xsl:call-template name="InfoBox">
								<xsl:with-param name="SpecDesc">
									<xsl:choose>
										<xsl:when test="$TimeRange = 'ALL'">Indefinite period</xsl:when>
										<xsl:when test="$TimeRange = 'L24'">Last 24 hours</xsl:when>
										<xsl:when test="$TimeRange = 'L48'">Last 48 hours</xsl:when>
										<xsl:when test="$TimeRange = 'L7D'">Last 7 days</xsl:when>
										<xsl:when test="$TimeRange = 'RNG'">Period from <xsl:value-of select="$StartTimeG" /> to <xsl:value-of select="$EndTimeG" /></xsl:when>
									</xsl:choose>
									<xsl:if test="$AreaLevel6"> - <xsl:value-of select="$AreaLevel6" /></xsl:if>
									<xsl:if test="$AreaLevel5"> - <xsl:value-of select="$AreaLevel5" /></xsl:if>
									<xsl:if test="$AreaLevel4"> - <xsl:value-of select="$AreaLevel4" /></xsl:if>
									<xsl:if test="$AreaLevel3"> - <xsl:value-of select="$AreaLevel3" /></xsl:if>
									<xsl:if test="$AreaLevel2"> - <xsl:value-of select="$AreaLevel2" /></xsl:if>
									<xsl:if test="$AreaLevel1"> - <xsl:value-of select="$AreaLevel1" /></xsl:if>

								</xsl:with-param>
							</xsl:call-template>
							<BR />

							<TABLE>
										<CAPTION>Summary</CAPTION>
										<TR>
											<TH class = "header">Assigned to:</TH>
											<TH class = "total">Total</TH>
											<xsl:for-each select = "/DATASETLIST/DATASET/ROW[DBValue]">
												<TH><xsl:value-of select = "GUIValue" /></TH>
											</xsl:for-each>
										</TR>
										<xsl:for-each
												select = "/DATASETLIST/DATASET/ROW[GTask__TaskNumber][generate-id(GTask__TaskAssignedToRId) = generate-id(key('Officer', GTask__TaskAssignedToRId)[1])]">
												<xsl:variable name = "OfficerId" select = "Officer__Id" />

											<TR>
											<xsl:choose>
												<xsl:when test="$OfficerUnitCL = 'UNT'"><xsl:call-template name="AssignedUnits" /></xsl:when>
												<xsl:when test="$OfficerUnitCL = 'OFC'"><xsl:call-template name="AssignedOfficers" /></xsl:when>
											</xsl:choose>

												<TD class = "total count"><xsl:value-of
														select = "count(/DATASETLIST/DATASET/ROW[GTask__TaskAssignedToRId = $OfficerId])" /></TD>
												<xsl:for-each select = "/DATASETLIST/DATASET/ROW[DBValue]">
													<TD class = "count"><xsl:value-of
															select = "count(/DATASETLIST/DATASET/ROW[GTask__TaskAssignedToRId = $OfficerId][GTask__StatusG = current()/GUIValue])" /></TD>
												</xsl:for-each>
											</TR>
										</xsl:for-each>
										<TR>
											<TD class = "totalrow">Total:</TD>
											<TD class = "totalrow total count"><xsl:value-of
													select = "count(/DATASETLIST/DATASET/ROW[GTask__TaskNumber])" /></TD>
											<xsl:for-each select = "/DATASETLIST/DATASET/ROW[DBValue]">
												<TD class = "totalrow count"><xsl:value-of
														select = "count(/DATASETLIST/DATASET/ROW[GTask__StatusG = current()/GUIValue])" /></TD>
											</xsl:for-each>
										</TR>
									</TABLE>
									<BR />


							<!-- Report body -->
							<TABLE width="100%" cellspacing="0">
								<TR>
									<xsl:call-template name="TableHeaders" />
								</TR>
								<xsl:for-each select="/DATASETLIST/DATASET/ROW[GTask__TaskNumber]">
									<xsl:variable name="TaskId" select="GTask__Id" />
										<xsl:variable name="Style">
										<xsl:text>background-color:</xsl:text>
										<xsl:choose>
											<xsl:when test="position() mod 2 = 0">#EEEEEE;</xsl:when>
											<xsl:otherwise>#FFFFFF;</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="AlternateRowStyle">
										<xsl:text>background-color:</xsl:text>
										<xsl:choose>
											<xsl:when test="position() mod 2 = 1">#EEEEEE;</xsl:when>
											<xsl:otherwise>#FFFFFF;</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>

									<TR style="{$Style}">
									<xsl:variable name = "Occurrences" select = "DATASET/ROW[Occurrence__LabelShort]" />
									<xsl:if	test = "count($Occurrences) &gt; 1">s</xsl:if>
										<TD colspan = "5">
													<xsl:for-each select = "$Occurrences">
														<A href = "nds://{Occurrence__Id}">
															<xsl:value-of select = "Occurrence__LabelShort" />
															<xsl:if test = "position() != last()"><BR /></xsl:if>
														</A>
													</xsl:for-each>
										</TD>
										<TD>
													<A href="nds://{GTask__Id}">
														<xsl:value-of select="GTask__TaskNumber" />
													</A>
										</TD>
										<TD><xsl:value-of select="GTask__Title"/></TD>
										<TD><xsl:value-of select="GTask__Type1G" /></TD>
										<TD><xsl:value-of select="GTask__StatusG" /></TD>

									<xsl:variable name = "Clearance" select = "DATASET/ROW[Occurrence__UCRClearanceStatusG]" />
										 <TD>
											<xsl:for-each select = "$Clearance">
												<xsl:value-of select = "Occurrence__UCRClearanceStatusG" />
													<xsl:if	test = "position() != last()">
													<BR />
													</xsl:if>
												</xsl:for-each>
										 </TD>

										<TD>
											<xsl:for-each select="/DATASETLIST/DATASET/ROW[Officer__LabelEmpl][GTask__Id = $TaskId]">
												<A href="nds://{Officer__Id}:Employee">
													<xsl:value-of select="Officer__LabelEmpl" />
												</A>
												<xsl:if test="position() != last()"><BR /></xsl:if>
											</xsl:for-each>
										</TD>

										<TD>
											<xsl:for-each select="/DATASETLIST/DATASET/ROW[Officer__LabelEmpl][GTask__Id = $TaskId]">
												<A href="nds://{OrgPoliceUnit__Id}:Employee">
													<xsl:value-of select="OrgPoliceUnit__LabelEmpl__0" />
												</A>
												<xsl:if test="position() != last()"><BR /></xsl:if>
											</xsl:for-each>
										</TD>
										<TD><xsl:value-of select = "GTask__InitiatedTimeTZV2G" /></TD>
										<TD><xsl:value-of select = "GTask__OpenTimeTZV2G" /></TD>
										<TD><xsl:value-of select = "GTask__CompleteTimeTZV2G" /></TD>
									</TR>
								</xsl:for-each>

							</TABLE>

						</xsl:element>
					</xsl:element>
				</xsl:template>

				<xsl:template name="AssignedUnits">
						<xsl:variable name = "TaskId" select = "GTask__Id" />
										<TD>
											<xsl:for-each select="/DATASETLIST/DATASET/ROW[Officer__LabelEmpl][GTask__Id = $TaskId]">
												<A href="nds://{OrgPoliceUnit__Id}:Employee">
													<xsl:value-of select="OrgPoliceUnit__LabelEmpl__0" />
												</A>
												<xsl:if test="position() != last()"><BR /></xsl:if>

											</xsl:for-each>
											<BR />
											<I class="subscript">(<xsl:value-of select = "GTask__TaskAssignedToRId_L" />)</I>
											</TD>
				</xsl:template>
				<xsl:template name="AssignedOfficers">
					<TD>
													<A href = "#{GTask__TaskAssignedToRId}">
														<xsl:value-of select = "GTask__TaskAssignedToRId_L" />
													</A>
												</TD>
				</xsl:template>
				<xsl:template name="TableHeaders">
									<TH colspan = "5">Associated Incident</TH>
									<TH>Task number</TH>
									<TH>Title</TH>
                                    <TH>Task Type</TH>
                                    <TH>Task Status</TH>
                                    <TH>Clearance Status</TH>
									<TH>Officer Assigned</TH>
									<TH>Unit Assigned</TH>
									<TH>Task Initiated </TH>
									<TH>Task Opened</TH>
									<TH>Task Completed</TH>

				</xsl:template>


				<xsl:template name="ComposeWith" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
					<xsl:param name="Strings" />
					<xsl:param name="Separator">
						<xsl:text> / </xsl:text>
					</xsl:param>
					<xsl:for-each select="msxsl:node-set($Strings)/String">
						<xsl:if test="string-length(text()) &gt; 0 and count(preceding-sibling::String[string-length(.) &gt; 0]) &gt; 0">
							<xsl:value-of select="$Separator" />
						</xsl:if>
						<xsl:value-of select="./text()" />
					</xsl:for-each>
				</xsl:template>


				<!-- StyleClasses template -->
				<xsl:template name="StyleClasses">
					<xsl:element name="style">
						<xsl:attribute name="type">text/css</xsl:attribute>
						<xsl:text>


								BODY		{ font-size: 10pt; font-family:Arial; vertical-align:top; }
								H2			{ font-size: 12pt; font-style: italic; font-weight: bold; }
								H3			{ font-size: 10pt; font-style: italic; font-weight: bold; }
								H6			{ font-size: 8pt; font-weight:bold; margin-top:-10pt; text-align:center; }
								TH			{ padding: 5px 5px;text-align:left; border-color: silver; border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; }
								TD			{ padding-left: 5px; padding-right: 5px;}
								TABLE		{ font-size: 10pt; }

								TABLE.GridLayout	{ width:100%; font-size: 7pt; padding: 0px 2px 0px 2px; vertical-align: top; }
								HR.separator		{ display:none; }
								H1.TitleForeground	{ font-size: 16pt; font-weight: bold; margin-top:-20pt; text-align: center; border:solid black; border-width:2px 0 2px 0; }

										.TitleBackground	{ margin:0pt; border-top-width:19pt; border-style:solid; border-bottom-width:0pt; border-color:white; display:block }




							.				{ font-size: 10pt; font-family: Arial; vertical-align:top; }
							.Data			{ font-size: 10pt; font-style: normal; }
							.Label			{ font-size: 10pt; font-style: italic; padding-left:0.2cm; vertical-align:top }
							.PrintedLabel	{ font-size:8pt; }
							.ReportHeader	{ font-size: 16pt; font-weight: bold; margin-top:-17pt; text-align: center; }
							.ReportHeader2	{ font-size: 12pt; font-style: italic; font-weight: bold; }
							.ReportHeader3	{ font-size: 10pt; font-style: italic; font-weight: bold; }
							.RestrictedUseLabel { font-style: italic; font-weight: bold; }
							.SilverLine		{ border-top: solid; border-top-width: 2px; border-color: silver; }
							.TableData		{ font-size: 7pt; padding: 0px 2px 0px 2px; vertical-align: top; }
							.TableHeader	{ border-color: silver; border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; }

							body	{ font-family: Tahoma }
							TD		{ font-size: 8pt; vertical-align: top; }
							A		{ font-family: Tahoma,Arial,sans serif; text-decoration:none }
							A:hover	{ background: #F6F6F6; }
							I    	{font-size: 6pt; }
						</xsl:text>
					</xsl:element>
				</xsl:template>


				<!-- Title template -->
				<xsl:template name="Title" xmlns:pp="urn:nichePreprocessor">
					<xsl:param name="Text" />
					<span id="Title">
						<div class="TitleBackground"> </div>
						<h1 class="TitleForeground"><xsl:value-of select="$Text" /></h1>


					</span>
				</xsl:template>



			<!-- InfoBox template -->
				<xsl:template name="InfoBox" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:nl="urn:nicheLanguage" xmlns:pp="urn:nichePreprocessor">
					<xsl:param name="DataNodes" />
					<xsl:param name="SpecDesc" />
					<xsl:param name="ShowPrintedByUser">1</xsl:param>
					<xsl:param name="ShowTimestamp">1</xsl:param>
					<xsl:param name="ShowAgencyAndDivision">1</xsl:param>
					<xsl:param name="ShowInfoBoxBorder">1</xsl:param>
					<xsl:param name="ShowPoliceId1Label">0</xsl:param>
					<xsl:param name="UseCurEmpNumberInsteadOfCurrUser">0</xsl:param>

					<span id="InfoBox">
						<xsl:variable name="BorderStyle">
							<xsl:if test="$ShowInfoBoxBorder = 1">border-style:solid;border-width:1px;</xsl:if>
						</xsl:variable>
						<div style="{$BorderStyle}">
							<xsl:if test="$ShowAgencyAndDivision = '1' or $ShowPoliceId1Label = '1'">
								<div style="margin-bottom:0.2cm; padding: .25cm;">
									<xsl:variable name="AgencyName"><xsl:value-of select="/DATASETLIST/DATASET/ROW/AgencyName" /></xsl:variable>
									<xsl:variable name="DivisionName"><xsl:value-of select="/DATASETLIST/DATASET/ROW/DivisionName" /></xsl:variable>
									<xsl:if test="$ShowAgencyAndDivision = '1'">
										<xsl:value-of select="$AgencyName" />
										<xsl:if test="string-length($AgencyName) &gt; 0 and string-length($DivisionName) &gt; 0"><xsl:text>, </xsl:text></xsl:if>
										<xsl:value-of select="$DivisionName" />
									</xsl:if>
									<xsl:if test="$ShowPoliceId1Label = '1'">
										<xsl:variable name="PoliceId1Label">
											<xsl:choose>
												<xsl:when test="/DATASETLIST/DATASET/ROW/PoliceId1Label != ''">
													<xsl:value-of select="/DATASETLIST/DATASET/ROW/PoliceId1Label" />
												</xsl:when>
												<xsl:otherwise>
													<nl:mls><e>MNI:</e><f>MNI:</f><u>MNI:</u><a>MNI:</a><s>MNI:</s></nl:mls>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:if test="string-length($PoliceId1Label) &gt; 0">
											<xsl:if test="$ShowAgencyAndDivision = '1' and (string-length($AgencyName) &gt; 0 or string-length($DivisionName) &gt; 0)"><xsl:text>, </xsl:text></xsl:if>
											<xsl:value-of select="$PoliceId1Label" />
										</xsl:if>
									</xsl:if>
								</div>
							</xsl:if>
							<xsl:if test="count(msxsl:node-set($DataNodes)/row) &gt; 0">
								<table width="97%" align="center" style="border:none">
									<colgroup>
										<col class="Label" width="21%" />
										<col width="79%" />
									</colgroup>
									<xsl:for-each select="msxsl:node-set($DataNodes)/row">
										<xsl:call-template name="InfoBoxLine">
											<xsl:with-param name="Label" select="label" />
											<xsl:with-param name="Data" select="value" />
											<xsl:with-param name="BoldLabel" select="label/@bold" />
											<xsl:with-param name="BoldData" select="value/@bold" />
										</xsl:call-template>
									</xsl:for-each>
								</table>
								<BR />
							</xsl:if>
							<xsl:if test="$ShowPrintedByUser = '1' or $ShowTimestamp = '1' or string-length($SpecDesc) &gt; 0">
								<div>
									<table width="97%" align="left" cellpadding="0" cellspacing="0" style="border:none">
										<tr>
											<td width="49%" class="PrintedLabel" style="vertical-align:bottom; border:none;">
												<xsl:if test="$ShowTimestamp = '1'">
													<xsl:text><nl:mls><e>Valid as of </e><f>Valide ? partir de </f></nl:mls></xsl:text>
													<xsl:choose>
														<xsl:when test="/DATASETLIST/DATASET/ROW/DataTimestamp != ''">
															<xsl:value-of select="/DATASETLIST/DATASET/ROW/DataTimestamp" />
														</xsl:when>
														<xsl:otherwise>
															&lt;<xsl:text><nl:mls><e>Unknown</e><f>Inconnu</f></nl:mls></xsl:text>&gt;
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												<xsl:if test="$ShowPrintedByUser = '1'">
													<br />
													<xsl:text><nl:mls><e>Printed by </e><f>Imprim? par </f></nl:mls></xsl:text>
													<xsl:choose>
														<xsl:when test="$UseCurEmpNumberInsteadOfCurrUser = '1'">
															<xsl:value-of select="/DATASETLIST/DATASET/ROW/CurrentEmployeeNumber" />
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="/DATASETLIST/DATASET/ROW/CurrentUser" />
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
											</td>
											<td width="2%" style="border:none" />
											<td width="49%" class="PrintedLabel" style="vertical-align:bottom;text-align:right;border:none">
												<xsl:if test="string-length($SpecDesc) &gt; 0">
													<xsl:text><nl:mls><e>Summary for: </e><f>Sommaire pour: </f></nl:mls></xsl:text><xsl:value-of select="$SpecDesc" />
												</xsl:if>
											</td>
										</tr>
									</table>
								</div>
							</xsl:if>
						</div>
						<br />
					</span>
					<br />
				</xsl:template>

			<!-- InfoBoxLine template -->
				<xsl:template name="InfoBoxLine">
					<xsl:param name="Label" />
					<xsl:param name="Data" />
					<xsl:param name="BoldLabel">0</xsl:param>
					<xsl:param name="BoldData">0</xsl:param>
					<xsl:if test="$Label != '' or $Data != ''">
						<xsl:variable name="LabelStyle">
							<xsl:if test="$BoldLabel = 1">font-weight:bold;</xsl:if>
							<xsl:text>border:none;</xsl:text>
						</xsl:variable>
						<xsl:variable name="DataStyle">
							<xsl:if test="$BoldData = 1">font-weight:bold;</xsl:if>
							<xsl:text>border:none;</xsl:text>
						</xsl:variable>

						<tr>
							<td style="{$LabelStyle}">
								<xsl:value-of select="$Label" />
							</td>
							<td style="{$DataStyle}">
								<xsl:copy-of select="$Data" />
							</td>
						</tr>
					</xsl:if>
				</xsl:template>


			</xsl:stylesheet>]]>
	</ReportXSL>

	<DatawindowDef>
		<![CDATA[
			declare FieldStatus edit
			{
				size = 2000;
				default = "GGGGGGGGG";
			};


			declare TimeRange choicelist
			{
				choices=
				{

					"RNG"{e"Specify Time Range"f"P?riode:";}
				};
				label = e"Time range:"f"P?riode:";
				default="RNG";
			};

			declare AreaLevel6 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel6";
			};

			declare AreaLevel5 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel5";
			};

			declare AreaLevel4 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel4";
			};

			declare AreaLevel3 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel3";
			};

			declare AreaLevel2 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel2";
			};

			declare AreaLevel1 edit
			{
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel1";
			};

			declare StartTime edit
			{
				datatype = datetime;
				label = e"from"f"de";
				tag="EntityName=Occurrence;FieldName=ReportedTimeTZV2S";
			};

			declare EndTime edit
			{
				datatype = datetime;
				label = e"to"f"?";
				tag="EntityName=Occurrence;FieldName=ReportedTimeTZV2S";
			};

			declare boloreport checkbox
			{
				label = e"BOLO:"f"ADS:";
				datatype = int;
				default = "0";
			};

			declare FlagTypeCL set
			{
				label = e"Flag type:"f"Type d'indicateur:";
				tag = "EntityName=GOccurrenceFlag;FieldName=Type1G";
				selectlimit = 10;
				default = "";
			};

			declare FlagActive choicelist
			{
				label = "Active:";
				choices=
				{
					"1" {e"Yes"f"Oui";}
					"0" {e"No"f"Non";}
					"U" {"";}
				};
				default = "U";
			};

			declare ClearanceStatusG set
			{
				label = "Clearance Status:";
				tag = "EntityName=Occurrence;FieldName=UCRClearanceStatusG";
			};

			declare TaskTypeG set
			{
				label = "Task type:";
				tag = "EntityName=GTask;FieldName=Type1G";
			};
			declare TaskStatusG set
			{
				label = "Task status:";
				tag= "EntityName=GTask;FieldName=StatusG";
			};

			declare OfficerUnitCL choicelist {
				label = "Task Assigned To:";
				choices =
				{
					"OFC"{e"Officer";}
					"UNT"{e"Unit";}
					"U" {"";}
			    };
			    default = "U";
			};
			declare OfficerRId_L edit
			{
				label="Officer:";
				tag="EntityName=Flag;FieldName=FlagAssocOfficerRId_L;UseSearchSelector=1";
			};
			declare OfficerRId edit
			{
				tag="EntityName=Flag;FieldName=FlagAssocOfficerRId";
			};
			declare OfficerUnitRId_L edit
			{
				label="Unit: ";
				tag="EntityName=Flag;FieldName=FlagAssocUnitRId_L;UseSearchSelector=1";
			};

			declare OfficerUnitRId edit
			{
				tag="EntityName=Flag;FieldName=FlagAssocUnitRId";
			};

			declare ddlb_accdomain choicelist {label=e"Domain:"f"Domaine:";};
			declare ddlb_scope choicelist {label=e"Scope:"f"Port?e:";};

			declare UseReportServer checkbox
			{
				label = e"Use Report server:";
				default = "0";
			};

			datawindowdef ParameterWindow "ParameterWindow"
			{
				//total width = 3000

				griddef
				{
					columns = 2;
					labelwidth = 350;
					fieldwidth = 600;
					leftmargin = 100;
				};

				// The report title.  This will span both columns.
				text Title
				{
					label = "Incident summary list";
					fontstyle = "Arial Black";
					fontsize = 12;
					fonteffect = italic!;
					location = page;
					align = center;
					height = 92;
				};

				break(120);

					// Row 1


				griddef
				{
					columns = 3;
					labelwidth = 350;
					fieldwidth = 600;
					leftmargin = 100;
				};

				field AreaLevel6 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel6.Visible', '', '') <> '0', 1, 0)";};
				break;
				// Row 2
				griddef
				{
					columns = 2;
					labelwidth = 50;
					fieldwidth = 500;
					leftmargin = 500;
				};



				griddef
				{
					columns = 2;
					labelwidth = 350;
					fieldwidth = 600;
					leftmargin = 100;
				};

				field AreaLevel5 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel5.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 3
				field TimeRange;
				field AreaLevel4 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel4.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 4
				field StartTime {visible = expression "if (isNull(TimeRange), 0, if (TimeRange = 'RNG', 1, 0))";};
				field AreaLevel3 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel3.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 5
				field EndTime{visible = expression "if (isNull(TimeRange), 0, if (TimeRange = 'RNG', 1, 0))";};
				field AreaLevel2 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel2.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 6
				text Warning // only visible when StartTime > EndTime
				{
					label="The starting date in the date range must come before the ending date.";
					align = center;
					height = 120;
					location = columns(1);
					visible = expression "if (f_nonull(StartTime) = '' or f_nonull(EndTime) = '', 0, if(TimeRange = 'RNG' and f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), 1, 0))";
					textcolor=rgb(255,0,0); //red
				};
				field AreaLevel1 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel1.Visible', '', '') <> '0', 1, 0)";};

				break;

				griddef
				{
					columns = 4;
					labelwidth = 210;
					fieldwidth = 200;
					leftmargin = 100;
				};

				field BoloReport {visible = expression "if ( LegacyBoloReport = '1', 1, 0)"; };
				field FlagTypeCL {colspan=2; };
				field FlagActive;

				griddef
				{
					columns = 1;
					labelwidth = 300;
					fieldwidth = 1000;
					leftmargin = 100;
				};
				field OfficerUnitCL;
				break;
				griddef
				{
					columns = 2;
					labelwidth = 300;
					fieldwidth = 500;
					leftmargin = 100;
				};
				field OfficerRId_L {visible = expression "if (isNull(OfficerUnitCL), 0, if (OfficerUnitCL = 'OFC', 1, 0 ))";};
				field OfficerUnitRId_L {visible = expression "if ( isNull(OfficerUnitCL), 0, if (OfficerUnitCL = 'UNT', 1, 0) )"; };
				break;



				griddef
				{
					columns = 2;
					labelwidth = 550;
					fieldwidth = 400;
					leftmargin = 200;
				};
				field ClearanceStatusG;
				field TaskTypeG;
				field TaskStatusG;
				griddef
				{
					columns = 2;
					labelwidth = 350;
					fieldwidth = 400;
					leftmargin = 50;
				};
				field ddlb_accdomain;
				field ddlb_scope;

				griddef
				{
					columns = 1;
					labelwidth = 500;
					fieldwidth = 500;
					leftmargin = 500;
				};

				field UseReportServer;
				field OfficerRId { visible = false; property CreateControlOnDW ="1"; };
				field OfficerUnitRId { visible = false; property CreateControlOnDW = "1"; };

				// Labels for AreaLevel fields are computed fields so the labels can be customer-specific
				computedfield AreaLevel6Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel6.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel6') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 195);
				};
				computedfield AreaLevel5Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel5.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel5') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 295);
				};
				computedfield AreaLevel4Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel4.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel4') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 395);
				};
				computedfield AreaLevel3Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel3.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel3') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 495);
				};
				computedfield AreaLevel2Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel2.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel2') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 595);
				};
				computedfield AreaLevel1Label
				{
					visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel1.Visible', '', '') <> '0', 1, 0)";
					expression = "f_translatestring('msg:ESAreaLevel1') + ':'";
					border = NoBorder!;
					align = Right;
					pos = (1025, 695);
				};


				// Parameters for the XSLT report

				// Used by the DW to validate the data
				computedfield valid
				{
					visible = false;
					expression =
						"(TimeRange = 'ALL' or TimeRange = 'L24' or TimeRange = 'L48' or TimeRange = 'L7D' or "
							"(TimeRange = 'RNG' and (f_nonull(StartTime) <>'' and f_nonull(EndTime) <> '' "
								"and f_getdatetimecomparablecfromg(StartTime) <= f_getdatetimecomparablecfromg(EndTime)))) "
								"and (((LegacyBoloReport = '1' AND BoloReport = 1)) OR (LegacyBoloReport <> '1'))";
				};

				// Used to display an error message to the user
				computedfield invalidfields
				{
					visible = false;
					expression =
						"if (FlagType <> '' and (FlagActive='0' or FlagActive='U') and TimeRange = 'ALL', "
							"'~t' + f_TranslateString('str:flagtypeandactive') + '~n', '') + "
						"if (TimeRange = 'RNG' and f_nonull(StartTime) = '', "
							"'~t' + f_TranslateString('str:startdate') + '~n', '') + "
						"if (TimeRange = 'RNG' and f_nonull(EndTime) = '', "
							"'~t' + f_TranslateString('str:enddate') + '~n', '') + "
						"if (f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), "
							"'~t' + f_TranslateString('str:daterangewarning') + '~n', '') + "
						"if (f_isEmpty(FlagType) AND (BoloReport = 0), "
							"'~t' + f_TranslateString('str:flagtype') + '~n', '')";
				};

				computedfield OfficerUnitIds { visible = false; expression = "if ( OfficerUnitCL = 'UNT', f_ReplaceAll(OfficerUnitRId, '~n', ';'), f_ReplaceAll(OfficerRId, '~n', ';') ) ";};


				computedField FlagType { visible = false; expression = "if (len(FlagTypeCL) > 0, md_GetDBValueFromSetByName('GOccurrenceFlag', 'Type1G', f_NoNull(FlagTypeCL)), '')";};
				computedField FlagTypeG { visible = false; expression = "FlagTypeCL";};

				computedField ClearanceStatus { visible = false; expression = "if (len(ClearanceStatusG) > 0, md_GetDBValueFromSetByName('Occurrence', 'UCRClearanceStatusG', f_NoNull(ClearanceStatusG)), '')";};
				computedField ClearanceStatusDisp { visible = false; expression = "ClearanceStatusG";};
				computedField TaskType { visible = false; expression = "if (len(TaskTypeG) > 0, md_GetDBValueFromSetByName('GTask', 'Type1G', f_NoNull(TaskTypeG)), '')";};
				computedField TaskTypeDisp { visible = false; expression = "TaskTypeG";};

				computedField TaskStatus { visible = false; expression = "if (len(TaskStatusG) > 0, md_GetDBValueFromSetByName('GTask', 'StatusG', f_NoNull(TaskStatusG)), '')";};
				computedField TaskStatusDisp { visible = false; expression = "TaskStatusG";};
				computedfield StartTimeMinus3Days { visible = false; expression = "f_GetDateTimeCPlusDuration(f_GetDateTimeCFromS(StartTime), '-3d')"; };
				computedfield EndTimePlus3Days { visible = false; expression = "f_GetDateTimeCPlusDuration(f_GetDateTimeCFromS(EndTime), '3d')"; };

				computedfield NowMinus4Days { visible = false; expression = "f_GetDateTimePhysicalFromC(f_GetDateTimeCPlusDuration(f_GetDatetimeNowC(), '-4d'))"; };
				computedfield NowMinus5Days { visible = false; expression = "f_GetDateTimePhysicalFromC(f_GetDateTimeCPlusDuration(f_GetDatetimeNowC(), '-5d'))"; };
				computedfield NowMinus10Days { visible = false; expression = "f_GetDateTimePhysicalFromC(f_GetDateTimeCPlusDuration(f_GetDatetimeNowC(), '-10d'))"; };

				computedfield StartTimeG
				{
					visible = false;
					expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(StartTime))";
				};

				computedfield EndTimeG
				{
					visible = false;
					expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(EndTime))";
				};

				computedfield ACCDomain	{ visible = false; expression = "ddlb_accdomain + ddlb_scope"; };


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

</root>
