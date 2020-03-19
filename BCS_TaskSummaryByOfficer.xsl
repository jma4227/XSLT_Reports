<?xml version="1.0" encoding="Windows-1252"?>
<root>
	<VersionInfo>
		<Filename>BCS_TaskSummaryByOfficer.xml</Filename>
		<Revision>1.3</Revision>
		<NMLVersion>5.04.11.02.18</NMLVersion>
		<Developer>Niche</Developer>
		<NicheBuildName>BexarCounty</NicheBuildName>
		<BuildTime>2018/07/21 22:08:08</BuildTime>
		<UpdateTime>2019/11/18 3:33:00</UpdateTime>
	</VersionInfo>

	<!-- Information to be used when loading the report -->
	<AllowedEntity>Person</AllowedEntity>
	<IsPrintTemplate>1</IsPrintTemplate>
	<ReportName>Task summary by officer</ReportName>
	<Documentation>This report displays a summary of all tasks assigned to the given officer(s).</Documentation>

	<!-- Report format parameters. -->

	<ReportHeader><![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p>"]]></ReportHeader>


	<ReportFooter><![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p><p align='center'>"e"Printed by:""&nbsp;&nbsp;[@AGBL=USERNUM]&nbsp;&nbsp;&nbsp;"e"Date:""&nbsp;&nbsp;[DATE] [TIME]&nbsp;&nbsp;&nbsp;"e"Computer:""&nbsp;&nbsp;[@AGBL=COMPUTERNAME]&nbsp;&nbsp;&nbsp;"e"Page"" [PAGENUM] of [PAGETOTAL]</p>"]]></ReportFooter>

	<SQLParameter>StartTime</SQLParameter>
	<SQLParameter>EndTime</SQLParameter>
	<SQLParameter>TaskType</SQLParameter>
	<SQLParameter>ClearanceStatus</SQLParameter>

	<XSLTParameter>StartTimeG</XSLTParameter>
	<XSLTParameter>EndTimeG</XSLTParameter>
	<XSLTParameter>TaskTypeDisp</XSLTParameter>
	<XSLTParameter>ClearanceStatusDisp</XSLTParameter>

	<OutputType>html</OutputType>

	<SQLSelectXSLT><![CDATA[




					<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
						<xsl:param name="PARAM_ID" />
						<xsl:param name="StartTime" />
						<xsl:param name="EndTime" />
						<xsl:param name="TaskType" />
						<xsl:param name="ClearanceStatus" />
						<xsl:output method="text" omit-xml-declaration="yes" />

						<xsl:template match="/">
							----------------------------------------------------------
							--  XML filename: TaskSummaryByOfficer.xml
							--  File revision: 1.3
							--  NML version: 5.04.11.02.18
							--  Developer: Niche
							--  Niche build name: BexarCounty
							--  Build time: 2018/07/21 22:08:08
							----------------------------------------------------------

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

		                GOccurrence__Id,
		                GOccurrence__LabelShort,

		                GOccurrence__UCRClearanceStatusG,
		                GOccurrence__UCRClearanceStatusDateG


							FROM GTask
								LEFT JOIN (TaskSubjectGOccurrence
									LEFT JOIN (GOccurrence
										LEFT JOIN CFSOccurrence
										)
								)

							WHERE GTask.TaskAssignedToRId IN (<xsl:value-of select="$PARAM_ID" />)
								AND HierarchicalResult = 1

								<xsl:if test="$StartTime != '' and $EndTime != ''">
									<xsl:text>AND GTask.InitiatedTimeTZV2I = MakeInterval(</xsl:text>
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




							ORDER BY GTask.TaskAssignedToRId_L




							-----------------------------------------------------------------

							SELECT
								GUIValue,
								DBValue
							FROM ChoiceListReport
							WHERE ChoiceList='cl_TaskStatus'

							-----------------------------------------------------------------

							SELECT DataTimestampTZV2GL AS DataTimestamp FROM DataTimestamp

							SELECT SPValue AS AgencyName FROM SystemParameterSettingForACC WHERE SPKey='Label.AgencyName'
							SELECT SPValue AS DivisionName, 1 AS CFDSIgnoreDataSetChanges FROM SystemParameterSettingForACC WHERE SPKey='Label.DivisionName'
							SELECT EmployeeNumber AS CurrentEmployeeNumber, Label AS CurrentUser, 1 AS CFDSIgnoreDataSetChanges FROM GPerson WHERE Id=@currentUserId


						</xsl:template>


						<xsl:template name="StuffSQL">
							<xsl:param name="ToStuff" />
							<xsl:text>'</xsl:text><xsl:call-template name="StuffSQLPart"><xsl:with-param name="ToStuff"><xsl:value-of select="$ToStuff" /></xsl:with-param></xsl:call-template><xsl:text>'</xsl:text>
						</xsl:template>

						<xsl:template name="StuffSQLPart">
							<xsl:param name="ToStuff" />
							<xsl:variable name="SingleQuote">'</xsl:variable>
							<xsl:choose>
								<xsl:when test="contains($ToStuff, $SingleQuote)">
									<xsl:value-of select="substring-before($ToStuff, $SingleQuote)" />
									<xsl:text>''</xsl:text>
									<xsl:call-template name="StuffSQLPart">
										<xsl:with-param name="ToStuff"><xsl:value-of select="substring-after($ToStuff, $SingleQuote)" /></xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$ToStuff" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:template>


						<xsl:template name="CreateConditionFromSet">
							<xsl:param name="FieldName" />
							<xsl:param name="FieldValue" />
							<xsl:param name="IsSetField" />
							<xsl:param name="Prefix" />

							<xsl:variable name="Condition">
								<xsl:call-template name="CreateConditionFromSet_Recursive">
									<xsl:with-param name="FieldName" select="$FieldName" />
									<xsl:with-param name="FieldValue" select="substring($FieldValue, 2, string-length($FieldValue) - 2)" />
									<xsl:with-param name="IsSetField" select="$IsSetField" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:if test="string-length($Condition) &gt; 0">
								<xsl:value-of select="$Prefix" /><xsl:text>(</xsl:text>
									<xsl:value-of select="$Condition" />
								<xsl:text>)</xsl:text>
							</xsl:if>
						</xsl:template>

						<xsl:template name="CreateConditionFromSet_Recursive">
							<xsl:param name="FieldName" />
							<xsl:param name="FieldValue" />
							<xsl:param name="IsSetField" />
							<xsl:param name="Prefix" />

							<xsl:variable name="ComparisonOperator">
								<xsl:choose>
									<xsl:when test="$IsSetField = '1'"><xsl:text> LIKE </xsl:text></xsl:when>
									<xsl:otherwise><xsl:text> = </xsl:text></xsl:otherwise>
								</xsl:choose>
							</xsl:variable>

							<xsl:if test="string-length($FieldValue) &gt; 0">

								<xsl:choose>
									<xsl:when test="contains($FieldValue, ';')">
										<xsl:value-of select="$Prefix" />
										<xsl:value-of select="$FieldName" />
										<xsl:value-of select="$ComparisonOperator" />
										<xsl:call-template name="StuffSQL">
											<xsl:with-param name="ToStuff">
												<xsl:choose>
													<xsl:when test="$IsSetField = '1'"><xsl:text>%;</xsl:text><xsl:value-of select="substring-before($FieldValue, ';')" /><xsl:text>;%</xsl:text></xsl:when>
													<xsl:otherwise><xsl:value-of select="substring-before($FieldValue, ';')" /></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="CreateConditionFromSet_Recursive">
											<xsl:with-param name="Prefix"><xsl:text> OR </xsl:text></xsl:with-param>
											<xsl:with-param name="FieldName" select="$FieldName" />
											<xsl:with-param name="FieldValue" select="substring-after($FieldValue, ';')" />
											<xsl:with-param name="IsSetField" select="$IsSetField" />
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$Prefix" />
										<xsl:value-of select="$FieldName" />
										<xsl:value-of select="$ComparisonOperator" />
										<xsl:call-template name="StuffSQL">
											<xsl:with-param name="ToStuff">
												<xsl:choose>
													<xsl:when test="$IsSetField = '1'"><xsl:text>%;</xsl:text><xsl:value-of select="$FieldValue" /><xsl:text>;%</xsl:text></xsl:when>
													<xsl:otherwise><xsl:value-of select="$FieldValue" /></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>

							</xsl:if>

						</xsl:template>


					</xsl:stylesheet>





			]]></SQLSelectXSLT>
	<ReportXSL><![CDATA[

				<?xml version="1.0" encoding="Windows-1252"?>
				  <xsl:stylesheet version = "1.0" xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
						  xmlns:nl = "urn:nicheLanguage" xmlns:nicheFunctions = "urn:nicheFunctions"
						  xmlns:pp = "urn:nichePreprocessor" xmlns:msxsl = "urn:schemas-microsoft-com:xslt">
						<xsl:output method = "xml" indent = "yes" omit-xml-declaration = "yes" />

						<xsl:param name = "StartTimeG" />
						<xsl:param name = "EndTimeG" />
						<xsl:param name = "TaskTypeDisp" />
						<xsl:param name = "ClearanceStatusDisp" />

						<xsl:key name = "Officer" match = "/DATASETLIST/DATASET/ROW/GTask__TaskAssignedToRId"
								use = "." />

						<xsl:template match = "/">
							<HTML>
								<xsl:variable name = "ReportTitle">User Task Summary Report</xsl:variable>
								<xsl:element name = "title"><xsl:value-of select = "$ReportTitle" /></xsl:element>

								<xsl:element name = "BODY">

									<xsl:call-template name = "StyleClasses" />

									  <!-- Insert the title-->
									  <xsl:call-template name = "Title">
										<xsl:with-param name = "Text" select = "$ReportTitle" />
									</xsl:call-template>

									  <!-- Insert the info box -->
									  <xsl:call-template name = "InfoBox">
										<xsl:with-param name = "DataNodes">
											<row>
												<label>Initiated from:</label>
												<value bold = "1"><xsl:value-of select = "$StartTimeG" /></value>
											</row>
											<row>
												<label>Initiated to:</label>
												<value bold = "1"><xsl:value-of select = "$EndTimeG" /></value>
											</row>
											<row>
												<label>Task type(s):</label>
												<value bold = "1"><xsl:value-of select = "$TaskTypeDisp" /></value>
											</row>
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
											<xsl:variable name = "OfficerId" select = "GTask__TaskAssignedToRId" />
											<TR>
												<TD>
													<A href = "#{GTask__TaskAssignedToRId}">
														<xsl:value-of select = "GTask__TaskAssignedToRId_L" />
													</A>
												</TD>
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

									<xsl:for-each
											select = "/DATASETLIST/DATASET/ROW[GTask__TaskNumber][generate-id(GTask__TaskAssignedToRId) = generate-id(key('Officer', GTask__TaskAssignedToRId)[1])]">

										<DIV class = "officerBox">
											<A name = "#{GTask__TaskAssignedToRId}" />
											<H2>Task Details: <A href = "nds://{GTask__TaskAssignedToRId}"><xsl:value-of
													select = "GTask__TaskAssignedToRId_L" /></A></H2>

											<xsl:for-each
													select = "/DATASETLIST/DATASET/ROW[GTask__TaskAssignedToRId = current()/GTask__TaskAssignedToRId]">

												<table class = "layout" width = "100%">
													<colgroup>
														<col width = "10%" align = "right" />
														<col width = "10%" />
														<col width = "10%" align = "right" />
														<col width = "10%" />
														<col width = "10%" align = "right" />
														<col width = "10%" />
													</colgroup>
													<tr>
														<td><h3><I><nl:mls><e>Task #:</e><f>No de tâche:</f></nl:mls></I></h3></td>
														<td>
															<A href = "nds://{GTask__Id}">
																<xsl:value-of select = "GTask__TaskNumber" />
															</A>
														</td>
														<td><I><nl:mls><e>Status:</e><f>Statut:</f></nl:mls></I></td>
														<td colspan = "3"><xsl:value-of select = "GTask__StatusG" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Type:</e><f>Type:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__Type1G" /></td>
														<td><I><nl:mls><e>Due time:</e><f>D.A.:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__DueTimeTZV2G" /></td>
														<td><I><nl:mls><e>Priority:</e><f>Priorité:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__PriorityG" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Title:</e><f>Titre:</f></nl:mls></I></td>
														<td colspan = "5"><xsl:value-of select = "GTask__Title" /></td>
													</tr>
													<tr style="text-align: center;">

														<xsl:variable name = "Clearance"
																select = "DATASET/ROW[GOccurrence__UCRClearanceStatusG]" />
														<td colspan="3"><I><B>Clearance Status:<xsl:if
																test = "count($Clearance) &gt; 1">s</xsl:if></B></I></td>
														  <td >
																<xsl:for-each select = "$Clearance">

																			<xsl:value-of
																					select = "GOccurrence__UCRClearanceStatusG" />
																			<xsl:if
																					test = "position() != last()">
																				  <BR />
																			</xsl:if>

																</xsl:for-each>
														  </td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Remind:</e><f>Heure de rappel:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__ReminderTimeTZV2G" /></td>
														<td><I><nl:mls><e>Supervisor approval:</e><f>Approbation du superviseur:</f></nl:mls></I></td>
														<xsl:choose>
															<xsl:when
																	test = "GTask__SupervisorApprovalRequired = 'True'">
																<td><nl:mls><e>Yes</e><f>Oui</f></nl:mls></td>
															</xsl:when>
															<xsl:otherwise>
																<td><nl:mls><e>No</e><f>Non</f></nl:mls></td>
															</xsl:otherwise>
														</xsl:choose>
														<td><I><nl:mls><e>Initiator approval:</e><f>Approbation de l'auteur:</f></nl:mls></I></td>
														<xsl:choose>
															<xsl:when
																	test = "GTask__InitiatorApprovalRequired = 'True'">
																<td><nl:mls><e>Yes</e><f>Oui</f></nl:mls></td>
															</xsl:when>
															<xsl:otherwise>
																<td><nl:mls><e>No</e><f>Non</f></nl:mls></td>
															</xsl:otherwise>
														</xsl:choose>
													</tr>
													<tr>
														<td><I><nl:mls><e>Initiated:</e><f>Entreprise:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__InitiatedTimeTZV2G" /></td>
														<td><I><nl:mls><e>Opened:</e><f>Active:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__OpenTimeTZV2G" /></td>
														<td><I><nl:mls><e>Completed:</e><f>Accomplie:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__CompleteTimeTZV2G" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Initiated by:</e><f>Auteur:</f></nl:mls></I></td>
														<td colspan = "3"><xsl:value-of
																select = "GTask__TaskInitiatedByRId_L" /></td>
														<td><I><nl:mls><e>Time:</e><f>Heure:</f></nl:mls></I></td>
														<td><xsl:value-of select = "GTask__InitiatorApprovedTZV2G" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Assigned to:</e><f>Attribuée à:</f></nl:mls></I></td>
														<td colspan = "3"><xsl:value-of
																select = "GTask__TaskAssignedToRId_L" /></td>
														<td><I><nl:mls><e>Time:</e><f>Heure:</f></nl:mls></I></td>
														<td><xsl:value-of
																select = "GTask__TaskAssignedToAssignedTimeTZV2G" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Approved by:</e><f>Approuvée par:</f></nl:mls></I></td>
														<td colspan = "3"><xsl:value-of
																select = "GTask__TaskApprovalRId_L" /></td>
														<td><I><nl:mls><e>Time:</e><f>Heure:</f></nl:mls></I></td>
														<td><xsl:value-of
																select = "GTask__TaskApprovalApprovalTimeTZV2G" /></td>
													</tr>
													<tr>
														<td><I><nl:mls><e>Remarks:</e><f>Remarque:</f></nl:mls></I></td>
														<td colspan = "5"><xsl:value-of select = "GTask__Remarks" /></td>
													</tr>
													<tr>
														<xsl:variable name = "Occurrences"
																select = "DATASET/ROW[GOccurrence__LabelShort]" />
														<td><I>Associated occurrence<xsl:if
																test = "count($Occurrences) &gt; 1">s</xsl:if>:</I></td>
														<td colspan = "5">
															<xsl:for-each select = "$Occurrences">
																<A href = "nds://{GOccurrence__Id}">
																	<xsl:value-of select = "GOccurrence__LabelShort" />
																	<xsl:if test = "position() != last()"><BR /></xsl:if>
																</A>
															</xsl:for-each>
														</td>
													</tr>
												</table>
												<xsl:if test = "position() != last()">
													<hr />
												</xsl:if>
											</xsl:for-each>
											</DIV>
											<BR />
										</xsl:for-each>
								</xsl:element>

							</HTML>
						</xsl:template>


						<!-- InfoBox template -->
						<xsl:template name = "InfoBox" xmlns:msxsl = "urn:schemas-microsoft-com:xslt"
								xmlns:nl = "urn:nicheLanguage" xmlns:pp = "urn:nichePreprocessor">
							<xsl:param name = "DataNodes" />
							<xsl:param name = "SpecDesc" />
							<xsl:param name = "ShowPrintedByUser">1</xsl:param>
							<xsl:param name = "ShowTimestamp">1</xsl:param>
							<xsl:param name = "ShowAgencyAndDivision">1</xsl:param>
							<xsl:param name = "ShowInfoBoxBorder">1</xsl:param>
							<xsl:param name = "ShowPoliceId1Label">0</xsl:param>
							<xsl:param name = "UseCurEmpNumberInsteadOfCurrUser">0</xsl:param>

							<span id = "InfoBox">
								<xsl:variable name = "BorderStyle">
									<xsl:if test = "$ShowInfoBoxBorder = 1">border-style:solid;border-width:1px;</xsl:if>
								</xsl:variable>
								<div style = "{$BorderStyle}">
									<xsl:if test = "$ShowAgencyAndDivision = '1' or $ShowPoliceId1Label = '1'">
										<div style = "margin-bottom:0.2cm; padding: .25cm;">
											<xsl:variable name = "AgencyName"><xsl:value-of
													select = "/DATASETLIST/DATASET/ROW/AgencyName" /></xsl:variable>
											<xsl:variable name = "DivisionName"><xsl:value-of
													select = "/DATASETLIST/DATASET/ROW/DivisionName" /></xsl:variable>
											<xsl:if test = "$ShowAgencyAndDivision = '1'">
												<xsl:value-of select = "$AgencyName" />
												<xsl:if test = "string-length($AgencyName) &gt; 0 and string-length($DivisionName) &gt; 0"><xsl:text>, </xsl:text></xsl:if>
												<xsl:value-of select = "$DivisionName" />
											</xsl:if>
											<xsl:if test = "$ShowPoliceId1Label = '1'">
												<xsl:variable name = "PoliceId1Label">
													<xsl:choose>
														<xsl:when
																test = "/DATASETLIST/DATASET/ROW/PoliceId1Label != ''">
															<xsl:value-of
																	select = "/DATASETLIST/DATASET/ROW/PoliceId1Label" />
														</xsl:when>
														<xsl:otherwise>
															<nl:mls><e>MNI:</e><f>MNI:</f><u>MNI:</u><a>MNI:</a><s>MNI:</s></nl:mls>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:if test = "string-length($PoliceId1Label) &gt; 0">
													<xsl:if test = "$ShowAgencyAndDivision = '1' and (string-length($AgencyName) &gt; 0 or string-length($DivisionName) &gt; 0)"><xsl:text>, </xsl:text></xsl:if>
													<xsl:value-of select = "$PoliceId1Label" />
												</xsl:if>
											</xsl:if>
										</div>
									</xsl:if>
									<xsl:if test = "count(msxsl:node-set($DataNodes)/row) &gt; 0">
										<table width = "97%" align = "center" style = "border:none">
											<colgroup>
												<col class = "Label" width = "21%" />
												<col width = "79%" />
											</colgroup>
											<xsl:for-each select = "msxsl:node-set($DataNodes)/row">
												<xsl:call-template name = "InfoBoxLine">
													<xsl:with-param name = "Label" select = "label" />
													<xsl:with-param name = "Data" select = "value" />
													<xsl:with-param name = "BoldLabel" select = "label/@bold" />
													<xsl:with-param name = "BoldData" select = "value/@bold" />
												</xsl:call-template>
											</xsl:for-each>
										</table>
										<BR />
									</xsl:if>
									<xsl:if test = "$ShowPrintedByUser = '1' or $ShowTimestamp = '1' or string-length($SpecDesc) &gt; 0">
										<div>
											<table width = "97%" align = "left" cellpadding = "0" cellspacing = "0"
													style = "border:none">
												<tr>
													<td width = "49%" class = "PrintedLabel"
															style = "vertical-align:bottom; border:none;">
														<xsl:if test = "$ShowTimestamp = '1'">
															<xsl:text><nl:mls><e>Valid as of </e><f>Valide à partir de </f></nl:mls></xsl:text>
															<xsl:choose>
																<xsl:when
																		test = "/DATASETLIST/DATASET/ROW/DataTimestamp != ''">
																	<xsl:value-of
																			select = "/DATASETLIST/DATASET/ROW/DataTimestamp" />
																</xsl:when>
																<xsl:otherwise>
																	&lt;<xsl:text><nl:mls><e>Unknown</e><f>Inconnu</f></nl:mls></xsl:text>&gt;
																</xsl:otherwise>
															</xsl:choose>
														</xsl:if>
														<xsl:if test = "$ShowPrintedByUser = '1'">
															<br />
															<xsl:text><nl:mls><e>Printed by </e><f>Imprimé par </f></nl:mls></xsl:text>
															<xsl:choose>
																<xsl:when
																		test = "$UseCurEmpNumberInsteadOfCurrUser = '1'">
																	<xsl:value-of
																			select = "/DATASETLIST/DATASET/ROW/CurrentEmployeeNumber" />
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of
																			select = "/DATASETLIST/DATASET/ROW/CurrentUser" />
																</xsl:otherwise>
															</xsl:choose>
														</xsl:if>
													</td>
													<td width = "2%" style = "border:none" />
													<td width = "49%" class = "PrintedLabel"
															style = "vertical-align:bottom;text-align:right;border:none">
														<xsl:if test = "string-length($SpecDesc) &gt; 0">
															<xsl:text><nl:mls><e>Summary for: </e><f>Sommaire pour: </f></nl:mls></xsl:text><xsl:value-of
																select = "$SpecDesc" />
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
						<xsl:template name = "InfoBoxLine">
							<xsl:param name = "Label" />
							<xsl:param name = "Data" />
							<xsl:param name = "BoldLabel">0</xsl:param>
							<xsl:param name = "BoldData">0</xsl:param>
							<xsl:if test = "$Label != '' or $Data != ''">
								<xsl:variable name = "LabelStyle">
									<xsl:if test = "$BoldLabel = 1">font-weight:bold;</xsl:if>
									<xsl:text>border:none;</xsl:text>
								</xsl:variable>
								<xsl:variable name = "DataStyle">
									<xsl:if test = "$BoldData = 1">font-weight:bold;</xsl:if>
									<xsl:text>border:none;</xsl:text>
								</xsl:variable>

								<tr>
									<td style = "{$LabelStyle}">
										<xsl:value-of select = "$Label" />
									</td>
									<td style = "{$DataStyle}">
										<xsl:copy-of select = "$Data" />
									</td>
								</tr>
							</xsl:if>
						</xsl:template>


						<!-- Title template -->
						<xsl:template name = "Title" xmlns:pp = "urn:nichePreprocessor">
							<xsl:param name = "Text" />
							<span id = "Title">
								<div class = "TitleBackground"> </div>
								<h1 class = "TitleForeground"><xsl:value-of select = "$Text" /></h1>


							</span>
						</xsl:template>


						<!-- StyleClasses template -->
						<xsl:template name = "StyleClasses">
							<xsl:element name = "style">
								<xsl:attribute name = "type">text/css</xsl:attribute>
								<xsl:text>


										BODY		{ font-size: 10pt; font-family:Helvetica, Arial, sans-serif; vertical-align:top; font-weight: normal;}
										H1 			{ text-align: center; font-size: 16pt; }
										H2			{ font-size: 12pt; font-style: italic; font-weight: bold; text-align: center; }
										H3			{ font-size: 14pt; font-style: italic; font-weight: bold; text-align: left; }
										H6			{ font-size: 8pt; font-weight:bold; margin-top:-10pt; text-align:center; border-bottom: 1px solid #111; }
										TH			{ text-align:left; border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; }
										TABLE		{ font-size: 10pt; border-collapse: collapse; }

										TABLE.GridLayout	{ width:100%; font-size: 7pt; padding: 0px 2px 0px 2px; vertical-align: top; }
										HR.separator		{ display:none; }
										H1.TitleForeground	{ font-size: 16pt; font-weight: bold; margin-top:-20pt; text-align: center;background: white; border-width:2px 0 2px 0; }

										.TitleBackground	{ margin:0pt; border-top-width:19pt; border-style:solid; border-bottom-width:0pt; display:block }




									.				{ font-size: 10pt; font-family: Arial; vertical-align:top; }
									.Data			{ font-size: 10pt; font-style: normal; }
									.Label			{ font-size: 10pt; font-style: italic; padding-left:0.2cm; vertical-align:top }
									.PrintedLabel	{ font-size:8pt; }
									.ReportHeader	{ font-size: 16pt; font-weight: bold; margin-top:-17pt; text-align: center; }
									.ReportHeader2	{ font-size: 12pt; font-style: italic; font-weight: bold; }
									.ReportHeader3	{ font-size: 10pt; font-style: italic; font-weight: bold; }
									.RestrictedUseLabel { font-style: italic; font-weight: bold; }
									.TableData		{ font-size: 7pt; padding: 0px 2px 0px 2px; vertical-align: top; }
									.TableHeader	{ border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; }


									body			{text-align: center; }

									table			{ border-collapse:collapse; border:solid 2px black; }
									caption			{ font-weight:bold; padding:2px; border:solid black; border-width:2px; font-size:1.4em; }
									th				{ font-size:9pt; border:solid 1px black; padding:2px; text-align:center; }
									td				{ border:solid 1px black; padding:4px; vertical-align:top; }
									h2				{ font-family:Arial,sans-serif; font-weight:bold; font-style:normal; padding:2px; border:solid black; border-width:0 0 2px 0; font-size:1.4em; margin:0; }
									h3				{ font-size:1.2em; display:inline; }

									TABLE.layout	{ border:none; }
									TABLE.layout TH	{ font-size:10pt; font-weight:bold; font-style:normal; padding-right:20px; border:none; }
									TABLE.layout TD	{ padding-left:10px; padding-right:10px; border:none; padding:2px; }

									.count			{ padding-right:1em; font-size:1.2em; text-align:right; }
									.total			{ font-weight:bold; border-width:1px 2px; font-size:1.2em; }
									.totalrow		{ font-weight:bold; border-top-width:2px; font-size:1.2em; }
									.officerBox		{ border:solid 1px black; width:99%; margin:0; text-align:center; }

									@media screen
									{
										a			{font-family:Tahoma, sans-serif; text-decoration:none; font-weight:bold; }
										a:hover		{background:#EEEEEE;color:#110088; }
									}
									@media print
									{
										a			{font-family:Tahoma, sans-serif; text-decoration:none; color:black; }
									}
								</xsl:text>
							</xsl:element>
						</xsl:template>


					</xsl:stylesheet>




			]]></ReportXSL>

	<USLReportParameters>
		<DSL>
			<Metadata>
				<Entity Name = "Parameters">
					<Field Name = "StartTime" />
					<Field Name = "EndTime" />
					<Field Name = "StartTimeG" BehaveLike = "GPersonArrest.StartTimeTZV2G" />
					<Field Name = "EndTimeG" BehaveLike = "GPersonArrest.StartTimeTZV2G" />
					<SetField Name = "TaskType" ChoiceListName = "cl_TaskType"
					          ChoiceListSource = "NML" />
					<Field Name = "TaskTypeDisp" />
					<SetField Name = "ClearanceStatus" ChoiceListName = "cl_UCRIncidentClearanceStatus"
					          ChoiceListSource = "NML" />
					<Field Name = "ClearanceStatusDisp" />
				</Entity>
			</Metadata>
			<Entity Name = "Parameters" DSLBased = "True">
				<OnFieldChange Name = "StartTimeG" Action = "CopyDateGFieldToDateCFieldOnUpdate">
					<ActionParameter Name = "SetFieldName" Value = "StartTime" />
				</OnFieldChange>
				<OnFieldChange Name = "EndTimeG" Action = "CopyDateGFieldToDateCFieldOnUpdate">
					<ActionParameter Name = "SetFieldName" Value = "EndTime" />
				</OnFieldChange>
				<OnFieldChange Name = "TaskTypeG" Action = "CopyValueOnUpdate">
					<ActionParameter Name = "SetFieldName" Value = "TaskType" />
				</OnFieldChange>
				<OnFieldChange Name = "ClearanceStatusDisp" Action = "CopyValueOnUpdate">
					<ActionParameter Name = "SetFieldName" Value = "ClearanceStatus" />
				</OnFieldChange>


				<Field Name = "StartTime" />
				<Field Name = "EndTime" />
				<Field Name = "StartTimeG" />
				<Field Name = "EndTimeG" />
				<Field Name = "TaskTypeG" ExportName = "TaskType" ExportType = "StorableValue" />
				<Field Name = "TaskTypeDisp" />
				<Field Name = "ClearanceStatusG" ExportName = "ClearanceStatus"
				       ExportType = "StorableValue" />
				<Field Name = "ClearanceStatusDisp" />
			</Entity>
		</DSL>

		<Data>
			<Node Name = "Parameters" DSLBased = "true">
				<Cell Name = "StartTime" Value = "" />
				<Cell Name = "EndTime" Value = "" />
				<Cell Name = "StartTimeG" Value = "" />
				<Cell Name = "EndTimeG" Value = "" />
				<Cell Name = "TaskTypeG" Value = "" />
				<Cell Name = "TaskTypeDisp" />
				<Cell Name = "ClearanceStatusG" Value = "" />
				<Cell Name = "ClearanceStatusDisp" Value = "" />
			</Node>
		</Data>

		<USL>
			<![CDATA[
								view XSLTViewTemplate
								{
									context: (path: 'Data', firstNode: true)

									flowGrid (maxColumns: 2, content: {
										column (span: 1, content: qaGrid (content: {
											qaRow (style: st_QARowQuestionnaireStretchedFullAnswer, fieldName: 'StartTimeG', headerText: 'Initiated from:')
											qaRow (style: st_QARowQuestionnaireStretchedFullAnswer, fieldName: 'EndTimeG', headerText: 'Initiated to:')
											qaRow (style: st_QARowQuestionnaireStretchedFullAnswer, fieldName: 'TaskTypeG', headerText: 'Task type:')
											qaRow (style: st_QARowQuestionnaireStretchedFullAnswer, fieldName: 'ClearanceStatusG', headerText: 'Clearance Status:')
										}))
									})
								}
							]]>
		</USL>
	</USLReportParameters>

	<DatawindowDef>
		<![CDATA[
							declare FieldStatus edit
							{
								size = 1000;
								default = "GGGGGGGGG";
							};

							declare StartTime edit
							{
								datatype = datetime;
								label = "Initiated from:";
								tag = "EntityName=GOccurrence;FieldName=StartTimeTZV2S";
							};

							declare EndTime edit
							{
								datatype = datetime;
								label = "Initiated to:";
								tag = "EntityName=GOccurrence;FieldName=StartTimeTZV2S";
							};

							declare TaskTypeG set
							{
								label = "Task type:";
								tag = "EntityName=GTask;FieldName=Type1G";
							};

							declare ClearanceStatusG set
							{
								label = "Clearance Status:";
								tag = "EntityName=Occurrence;FieldName=UCRClearanceStatusG";
							}
							datawindowdef ParameterWindow "ParameterWindow"
							{
								//total width = 2432

								griddef
								{
									columns = 1;
									labelwidth = 500;
									fieldwidth = 1000;
									leftmargin = 500;
								};

								// The report title.  This will span both columns.
								text Title
								{
									label = "Officer task summary";
									fontstyle = "Arial Black";
									fontsize = 12;
									fonteffect = italic!;
									location = page;
									align = center;
									height = 92;
								};

								break(90);

								field StartTime;
								field EndTime;
								field TaskTypeG;
								field ClearanceStatusG;
								break;

								computedfield StartTimeG { visible = false; expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(StartTime))"; };
								computedfield EndTimeG { visible = false; expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(EndTime))"; };
								computedField TaskType { visible = false; expression = "if (len(TaskTypeG) > 0, md_GetDBValueFromSetByName('GTask', 'Type1G', f_NoNull(TaskTypeG)), '')";};
								computedField TaskTypeDisp { visible = false; expression = "TaskTypeG"; };
								computedField ClearanceStatus { visible = false; expression = if (len(ClearanceStatusG) > 0, md_GetDBValueFromSetByName('GOccurrence', 'UCRClearanceStatusG', f_NoNull(ClearanceStatusG)), '')";};
								computedField ClearanceStatusDisp { visible = false; expression = "ClearanceStatusG" ; };
							};

							group Parameter_Group "ParameterGroup"
							{
								ParameterWindow
							};
						]]>
	</DatawindowDef>
</root>