<?xml version="1.0" encoding="Windows-1252"?>
<root>
	<VersionInfo>
		<Filename>BCS_IncidentStatistics</Filename>
		<Revision>1.15</Revision>
		<NMLVersion>5.04.11.02.18</NMLVersion>
		<Developer>Niche</Developer>
		<NicheBuildName>BexarCounty</NicheBuildName>
		<BuildTime>1/31/2020 3:22 PM</BuildTime>
	</VersionInfo>

	!-- Information to be used when loading the report -->
	<!-- Is this report for an entire domain, rather than an instance of data -->
	<IsDomainReport>1</IsDomainReport>

	<!-- Should this show up in the list of reports for an entity in the print menu -->
	<IsPrintTemplate>1</IsPrintTemplate>

	<!-- Suggested report name in the print menu -->
	<ReportName>Incident Statistics</ReportName>

	<!-- Can be enclosed in CDATA.  A general description of what the report does -->
	<Documentation></Documentation>

	<ReportPaperOrientation>landscape</ReportPaperOrientation>

	<ReportHeader>
		<![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p>"]]></ReportHeader>

	<ReportFooter>
		<![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p><p align='center'>"e"Printed by:""&nbsp;&nbsp;[@AGBL=USERNUM]&nbsp;&nbsp;&nbsp;"e"Date:""&nbsp;&nbsp;[DATE] [TIME]&nbsp;&nbsp;&nbsp;"e"Computer:""&nbsp;&nbsp;[@AGBL=COMPUTERNAME]&nbsp;&nbsp;&nbsp;"e"Page"" [PAGENUM] of [PAGETOTAL]</p>"]]></ReportFooter>

	<ReportHeaderTop></ReportHeaderTop>
	<ReportFooterBottom></ReportFooterBottom>
	<ReportDetailMarginTop></ReportDetailMarginTop>
	<ReportDetailMarginLeft></ReportDetailMarginLeft>
	<ReportDetailMarginRight></ReportDetailMarginRight>
	<ReportDetailMarginBottom></ReportDetailMarginBottom>
	<DefaultProtectiveMarking></DefaultProtectiveMarking>
	<OutputType>html</OutputType>

	<SQLParameter>StartTime</SQLParameter>
	<SQLParameter>EndTime</SQLParameter>
	<SQLParameter>ESAreaLevel3</SQLParameter>
	<SQLParameter>ESAreaLevel5</SQLParameter>
	<SQLParameter>ESAreaLevel6</SQLParameter>
	<SQLParameter>OfficerRId</SQLParameter>
	<SQLParameter>OfficerClassification</SQLParameter>
	<SQLParameter>OccurrenceStatus</SQLParameter>
	<SQLParameter>OccurrenceTypeRId</SQLParameter>
	<SQLParameter>OccurrenceClassification</SQLParameter>
	<SQLParameter>OffenseTypeRId</SQLParameter>
	<SQLParameter>Charges</SQLParameter>
	<SQLParameter>ACCDomain</SQLParameter>
	<SQLParameter>UseReportServer</SQLParameter>



	<SQLSelectXSLT><![CDATA[

		<xsl:stylesheet version = "1.0"
		                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
			<xsl:param name = "StartTime"/>
			<xsl:param name = "EndTime"/>
			<xsl:param name = "ESAreaLevel3"/>
			<xsl:param name = "ESAreaLevel5"/>
			<xsl:param name = "ESAreaLevel6"/>
			<xsl:param name = "OfficerRId"/>
			<xsl:param name = "OfficerClassification"/>
			<xsl:param name = "OccurrenceStatus"/>
			<xsl:param name = "OccurrenceTypeRId"/>
			<xsl:param name = "OccurrenceClassification"/>
			<xsl:param name = "ACCDomain"/>
			<xsl:param name = "UseReportServer"/>
			<xsl:output method = "text"
			            omit-xml-declaration = "yes"/>

			<xsl:template match = "/">

				-----------------------------------------------------------------------------------
				-- XML filename: BCS_IncidentStatistics.xml
				-- File revision: 1.13
				-- NML version: 5.04.11.02.18
				-- Developer: Niche
				-- Niche build name: BexarCounty
				-- Build time: 2018/07/21 22:08:11
				-----------------------------------------------------------------------------------

				SELECT
				Occurrence__Id,
				Occurrence__ACCDomain,
				Occurrence__StartTimeTZV2G,
				Occurrence__ESAreaLevel6G,
				Occurrence__ESAreaLevel5G,
				Occurrence__ESAreaLevel3G,
				Occurrence__UCRClearanceStatus,
				Occurrence__OccurrenceStdOccTypeRId_L,
				Occurrence__ClassificationG,
				Occurrence__OccurrenceFileNoG,

				GOccInvGPerson__LabelRight





				FROM Occurrence
				LEFT JOIN (USStatsClassification
				LEFT JOIN USStatsClassificationOffense
				)
				LEFT JOIN NIBRSIncident
				LEFT JOIN (GOccInvGPerson
				LEFT JOIN Person Officer
				)
				LEFT JOIN (GOccIvPA
				LEFT JOIN PhysicalAddress
				) ON GOccIvPA.IsESAreaLevelSource = 1

				WHERE
				<xsl:if test = "$StartTime = '' or $EndTime = ''">
					<xsl:message terminate = "yes">ERROR: You must provide incident start and end
						times.
					</xsl:message>
				</xsl:if>

				MakeInterval(Occurrence.StartTimeTZV2I, Occurrence.EndTimeTZV2I, '[]',
				'NullCollapses')
				= MakeInterval(
				<xsl:call-template name = "StuffSQL">
					<xsl:with-param name = "ToStuff"
					                select = "$StartTime"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
				<xsl:call-template name = "StuffSQL">
					<xsl:with-param name = "ToStuff"
					                select = "$EndTime"/>
				</xsl:call-template>
				<xsl:text>, '[]', 'NullCollapses')</xsl:text>

				<xsl:if test = "$OfficerRId">
					AND GOccInvGPerson.RId =
					<xsl:call-template name = "StuffSQL">
						<xsl:with-param
							  name = "ToStuff"
							  select = "$OfficerRId"/>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$OfficerClassification">
					AND
					<xsl:call-template name = "CreateConditionFromSet">
						<xsl:with-param name = "FieldName">Officer
							.Classification
						</xsl:with-param>
						<xsl:with-param name = "FieldValue"
						                select = "$OfficerClassification"/>
						<xsl:with-param name = "IsSetField">1</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<xsl:if test = "$OccurrenceStatus">
					AND
					<xsl:call-template name = "CreateConditionFromSet">
						<xsl:with-param name = "FieldName">Occurrence.UCRClearanceStatus
						</xsl:with-param>
						<xsl:with-param name = "FieldValue"
						                select = "$OccurrenceStatus"/>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$OccurrenceTypeRId">
					AND Occurrence.OccurrenceStdOccTypeRId =
					<xsl:call-template name = "StuffSQL">
						<xsl:with-param name = "ToStuff"
						                select = "$OccurrenceTypeRId"/>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$OccurrenceClassification">
					AND
					<xsl:call-template name = "CreateConditionFromSet">
						<xsl:with-param name = "FieldName">Occurrence.Classification
						</xsl:with-param>
						<xsl:with-param name = "FieldValue"
						                select = "$OccurrenceClassification"/>
						<xsl:with-param name = "IsSetField">1</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$ESAreaLevel6">
					AND
					<xsl:call-template name = "MultiValueField">
						<xsl:with-param name = "FormField">
							<xsl:value-of select = "$ESAreaLevel6"/>
						</xsl:with-param>
						<xsl:with-param name = "DBField">Occurrence.ESAreaLevel6</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$ESAreaLevel5">
					AND
					<xsl:call-template name = "MultiValueField">
						<xsl:with-param name = "FormField">
							<xsl:value-of select = "$ESAreaLevel5"/>
						</xsl:with-param>
						<xsl:with-param name = "DBField">Occurrence.ESAreaLevel5</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test = "$ESAreaLevel3">
					AND
					<xsl:call-template name = "MultiValueField">
						<xsl:with-param name = "FormField">
							<xsl:value-of select = "$ESAreaLevel3"/>
						</xsl:with-param>
						<xsl:with-param name = "DBField">Occurrence.ESAreaLevel3</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				AND Occurrence.ACCDomain =
				<xsl:call-template name = "StuffSQL">
					<xsl:with-param name = "ToStuff"
					                select = "$ACCDomain"/>
				</xsl:call-template>

				<xsl:if test = "$UseReportServer ='1'">
					AND QueryServer = 'Report'
				</xsl:if>

				ORDER BY Occurrence.Id

					SELECT SPValue AS AgencyName FROM SystemParameterSettingForACC WHERE SPKey='Label.AgencyName'
					SELECT SPValue AS DivisionName, 1 AS CFDSIgnoreDataSetChanges FROM SystemParameterSettingForACC WHERE SPKey='Label.DivisionName'
					SELECT EmployeeNumber AS CurrentEmployeeNumber, Label AS CurrentUser, 1 AS CFDSIgnoreDataSetChanges FROM GPerson WHERE Id=@currentUserId

					SELECT DataTimestampTZV2GL AS DataTimestamp, 1 AS CFDSIgnoreDataSetChanges FROM DataTimestamp
						<xsl:if test="$UseReportServer = '1'">
							WHERE QueryServer = 'Report'
						</xsl:if>
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


				<xsl:template name="MultiValueField">
					<xsl:param name="FormField" />
					<xsl:param name="DBField" />
					<xsl:if test="$FormField != ''">
						(
						<xsl:call-template name="MultiValueFieldPart">
							<xsl:with-param name="FormField"><xsl:value-of select="$FormField" /></xsl:with-param>
							<xsl:with-param name="DBField"><xsl:value-of select="$DBField" /></xsl:with-param>
						</xsl:call-template>
						)
					</xsl:if>
				</xsl:template>

				<xsl:template name="MultiValueFieldPart">
					<xsl:param name="FormField" />
					<xsl:param name="DBField" />
					<xsl:value-of select="$DBField" /> LIKE
					<xsl:choose>
						<xsl:when test="contains($FormField, ',')">
							<xsl:call-template name="StuffSQL">
								<xsl:with-param name="ToStuff">
									<xsl:value-of select="normalize-space(translate(substring-before($FormField, ','), '*', '%'))" />
								</xsl:with-param>
							</xsl:call-template>
							 OR
							<xsl:call-template name="MultiValueFieldPart">
								<xsl:with-param name="FormField"><xsl:value-of select="substring-after($FormField, ',')" /></xsl:with-param>
								<xsl:with-param name="DBField"><xsl:value-of select="$DBField" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="StuffSQL">
								<xsl:with-param name="ToStuff">
									<xsl:value-of select="normalize-space(translate($FormField, '*', '%'))" />
								</xsl:with-param>
							</xsl:call-template>
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

	<Report>
		<FileType>HTML</FileType>
		<FileExtension>htm</FileExtension>
		<AllowPrint>1</AllowPrint>
		<AllowSave>1</AllowSave>
		<AllowPrintPreview>1</AllowPrintPreview>
		<AllowPagedPreview>1</AllowPagedPreview>
		<AllowEmail>1</AllowEmail>
		<XSLT><![CDATA[


			<?xml version="1.0" encoding="Windows-1252" ?>
			<xsl:stylesheet version = "1.0"
			                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
			                xmlns:nicheFunctions = "urn:nicheFunctions"
			                xmlns:msxsl = "urn:schemas-microsoft-com:xslt">
				<xsl:output method = "xml"
				            indent = "yes"
				            omit-xml-declaration = "yes"/>
				<xsl:param name="OccurrenceTypeRId" />

				<xsl:template match = "/">
					<HTML>
						<xsl:variable name = "ReportTitle">Incident Statistics</xsl:variable>
						<xsl:element name = "title">
							<xsl:value-of select = "$ReportTitle"/>
						</xsl:element>

						<!--	Insert the style class declarations -->
						<xsl:call-template name = "StyleClasses"/>

						<xsl:element name = "BODY">
							<!--	Insert the title -->
							<xsl:call-template name = "Title">
								<xsl:with-param name = "Text"
								                select = "$ReportTitle"/>
							</xsl:call-template>
							<!--	Insert the info box -->
							<xsl:call-template name = "InfoBox"></xsl:call-template>

							<!--	Report Body -->
							<TABLE>
								<TR>
									<TH>Date/Time</TH>
									<TH>Sector</TH>
									<TH>Area</TH>
									<TH>Officer/unit</TH>
									<TH>Clearance Status</TH>
									<TH>Incident Type</TH>
									<TH>Incident Classification</TH>
									<TH>Incident #</TH>
								</TR>
								<xsl:for-each
									  select = "/DATASETLIST/DATASET/ROW[Occurrence__OccurrenceFileNoG]">
									<TR>
										<TD class = "TableData">
											<xsl:value-of select = "Occurrence__StartTimeTZV2G"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of select = "Occurrence__ESAreaLevel5G"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of select = "Occurrence__ESAreaLevel3G"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of select = "GOccInvGPerson__LabelRight"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of
												  select = "Occurrence__UCRClearanceStatusG"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of
												  select = "Occurrence__OccurrenceStdOccTypeRId_L"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of select = "Occurrence__ClassificationG"/>
										</TD>
										<TD class = "TableData">
											<xsl:value-of select = "Occurrence__OccurrenceFileNoG"/>
										</TD>
									</TR>
								</xsl:for-each>
							</TABLE>

								<BR /><BR />
							<SPAN style="font-weight:bold">Total unique incidents: </SPAN><SPAN><xsl:value-of select="count(/DATASETLIST/DATASET/ROW[Occurrence__Id][not(Occurrence__Id = preceding-sibling::ROW[1]/Occurrence__Id)])" /></SPAN>

						</xsl:element>
					</HTML>
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
								TH			{ text-align:left; border-color: silver; border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; padding: 10px; }
								TABLE		{ font-size: 12pt; }

								TABLE.GridLayout	{ width:100%; font-size: 10pt; padding: 0px 2px 0px 2px; vertical-align: top; }
								HR.separator		{ display:none; }
								H1.TitleForeground	{ font-size: 16pt; font-weight: bold; margin-top:-20pt; text-align: center; border:solid black; border-width:2px 0 2px 0; }

								.TitleBackground	{ margin:0pt; border-top-width:19pt; border-style:solid; border-bottom-width:0pt; border-color:silver; display:block }




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
				<xsl:template name = "InfoBox"
				              xmlns:msxsl = "urn:schemas-microsoft-com:xslt"
				              xmlns:nl = "urn:nicheLanguage"
				              xmlns:pp = "urn:nichePreprocessor">
					<xsl:param name = "DataNodes"/>
					<xsl:param name = "SpecDesc"/>
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
									<xsl:variable name = "AgencyName"><xsl:value-of select = "/DATASETLIST/DATASET/ROW/AgencyName"/></xsl:variable>
									<xsl:variable name = "DivisionName"><xsl:value-of select = "/DATASETLIST/DATASET/ROW/DivisionName"/></xsl:variable>
									<xsl:if test = "$ShowAgencyAndDivision = '1'">
										<xsl:value-of select = "$AgencyName"/>
										<xsl:if test = "string-length($AgencyName) &gt; 0 and string-length($DivisionName) &gt; 0"><xsl:text>, </xsl:text></xsl:if>
										<xsl:value-of select = "$DivisionName"/>
									</xsl:if>
									<xsl:if test = "$ShowPoliceId1Label = '1'">
										<xsl:variable name = "PoliceId1Label">
											<xsl:choose>
												<xsl:when test = "/DATASETLIST/DATASET/ROW/PoliceId1Label != ''">
													<xsl:value-of select = "/DATASETLIST/DATASET/ROW/PoliceId1Label"/>
												</xsl:when>
												<xsl:otherwise>
													<nl:mls><e>MNI:</e><f>MNI:</f><u>MNI:</u><a>MNI:</a><s>MNI:</s></nl:mls>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:if test = "string-length($PoliceId1Label) &gt; 0">
											<xsl:if test = "$ShowAgencyAndDivision = '1' and (string-length($AgencyName) &gt; 0 or string-length($DivisionName) &gt; 0)"><xsl:text>, </xsl:text></xsl:if>
											<xsl:value-of select = "$PoliceId1Label"/>
										</xsl:if>
									</xsl:if>
								</div>
							</xsl:if>
							<xsl:if test = "count(msxsl:node-set($DataNodes)/row) &gt; 0">
								<table width = "97%"
								       align = "center"
								       style = "border:none">
									<colgroup>
										<col class = "Label"
										     width = "21%"/>
										<col width = "79%"/>
									</colgroup>
									<xsl:for-each select = "msxsl:node-set($DataNodes)/row">
										<xsl:call-template name = "InfoBoxLine">
											<xsl:with-param name = "Label"
											                select = "label"/>
											<xsl:with-param name = "Data"
											                select = "value"/>
											<xsl:with-param name = "BoldLabel"
											                select = "label/@bold"/>
											<xsl:with-param name = "BoldData"
											                select = "value/@bold"/>
										</xsl:call-template>
									</xsl:for-each>
								</table>
								<BR/>
							</xsl:if>
							<xsl:if test = "$ShowPrintedByUser = '1' or $ShowTimestamp = '1' or string-length($SpecDesc) &gt; 0">
								<div>
									<table width = "97%"
									       align = "left"
									       cellpadding = "0"
									       cellspacing = "0"
									       style = "border:none">
										<tr>
											<td width = "49%"
											    class = "PrintedLabel"
											    style = "vertical-align:bottom; border:none;">
												<xsl:if test = "$ShowTimestamp = '1'">
													<xsl:text><nl:mls><e>Valid as of </e><f>Valide à partir de </f></nl:mls></xsl:text>
													<xsl:choose>
														<xsl:when test = "/DATASETLIST/DATASET/ROW/DataTimestamp != ''">
															<xsl:value-of select = "/DATASETLIST/DATASET/ROW/DataTimestamp"/>
														</xsl:when>
														<xsl:otherwise>
															&lt;<xsl:text><nl:mls><e>Unknown</e><f>Inconnu</f></nl:mls></xsl:text>&gt;
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												<xsl:if test = "$ShowPrintedByUser = '1'">
													<br/>
													<xsl:text><nl:mls><e>Printed by </e><f>Imprimé par </f></nl:mls></xsl:text>
													<xsl:choose>
														<xsl:when test = "$UseCurEmpNumberInsteadOfCurrUser = '1'">
															<xsl:value-of select = "/DATASETLIST/DATASET/ROW/CurrentEmployeeNumber"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select = "/DATASETLIST/DATASET/ROW/CurrentUser"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
											</td>
											<td width = "2%"
											    style = "border:none"/>
											<td width = "49%"
											    class = "PrintedLabel"
											    style = "vertical-align:bottom;text-align:right;border:none">
												<xsl:if test = "string-length($SpecDesc) &gt; 0">
													<xsl:text><nl:mls><e>Summary for: </e><f>Sommaire pour: </f></nl:mls></xsl:text><xsl:value-of select = "$SpecDesc"/>
												</xsl:if>
											</td>
										</tr>
									</table>
								</div>
							</xsl:if>
						</div>
						<br/>
					</span>
					<br/>
				</xsl:template>

				<!-- InfoBoxLine template -->
				<xsl:template name = "InfoBoxLine">
					<xsl:param name = "Label"/>
					<xsl:param name = "Data"/>
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
								<xsl:value-of select = "$Label"/>
							</td>
							<td style = "{$DataStyle}">
								<xsl:copy-of select = "$Data"/>
							</td>
						</tr>
					</xsl:if>
				</xsl:template>
			</xsl:stylesheet>


		]]></XSLT>
	</Report>
	<!--

		<Report>
			<FileType>Excel</FileType>
			<FileExtension>csv</FileExtension>
			<DataElementName>Data</DataElementName>
			<AllowPrint>1</AllowPrint>
			<AllowSave>1</AllowSave>
			<AllowPrintPreview>1</AllowPrintPreview>
			<AllowPagedPreview>1</AllowPagedPreview>
			<AllowEmail>1</AllowEmail>
			<XSLT><![CDATA[

				<?xml version="1.0" encoding ="Windows-1252"?>
				<xsl:stylesheet version = "1.0"
								xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
								xmlns:nicheFunctions = "urn:nicheFunctions"
								xmlns:msxsl = "urn:schemas-microsoft-com:xslt">
				<xsl:output method = "xml"
							indent = "yes"
							omit-xml-declaration = "yes"/>
				<xsl:template match = "/">
					<Data>

					<xsl:template name = "ConvertHTMLTableToCSV">
						<xsl:with-param name = "HTMLTable">
							<TABLE>
									<TR>
										<TH>Date/Time</TH>
										<TH>Sector</TH>
										<TH>Area</TH>
										<TH>Officer/unit</TH>
										<TH>Clearance Status</TH>
										<TH>Incident Type</TH>
										<TH>Incident Classification</TH>
										<TH>Incident #</TH>
									</TR>
									<xsl:for-each
										  select = "/DATASETLIST/DATASET/ROW[Occurrence__ACCDomain]">
										<TR>
											<TD class = "TableData">
												<xsl:value-of select = "Occurrence__StartTimeTZV2G"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of select = "Occurrence__ESAreaLevel5G"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of select = "Occurrence__ESAreaLevel3G"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of select = "GOccInvGPerson__LabelRight"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of
													  select = "Occurrence__UCRClearanceStatus"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of
													  select = "Occurrence__OccurrenceStdOccTypeRId_L"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of select = "Occurrence__ClassificationG"/>
											</TD>
											<TD class = "TableData">
												<xsl:value-of select = "Occurrence__OccurrenceFileNoG"/>
											</TD>
										</TR>
									</xsl:for-each>
							</TABLE>
						</xsl:with-param>
					</xsl:template>
					</Data>
				</xsl:template>

					<xsl:template name = "ConvertHTMLTableToCSV">
							<xsl:param name = "HTMLTable"/>
							<Data>
								<xsl:for-each select = "msxsl:node-set($HTMLTable)/table|msxsl:node-set($HTMLTable)/TABLE">
									<xsl:for-each select = "tr|TR">
										<xsl:for-each select = "th|td|TH|TD">
											&lt;!&ndash; Check if it's a number of more than 15 digits (and isn't hyperlinked).  If so, add an '=' in front, so Excel doesn't convert to scientific notation &ndash;&gt;
											&lt;!&ndash;xsl:if test=". &gt; 0 and string-length(.) &gt; 15 and a/@href = '' and A/@href=''">=</xsl:if&ndash;&gt;
											<xsl:call-template name = "StuffCSV">
												<xsl:with-param name = "ToStuff"
																select = "normalize-space(.)"/>
												<xsl:with-param name = "HyperlinkId">
													<xsl:value-of select = "substring-after(A/@href, 'nds://')"/>
													<xsl:value-of select = "substring-after(a/@href, 'nds://')"/>
												</xsl:with-param>
											</xsl:call-template>
											<xsl:text>,</xsl:text>
										</xsl:for-each>
										<xsl:text>,</xsl:text>
										<xsl:call-template name = "PrintNewline"/>
									</xsl:for-each>
								</xsl:for-each>
							</Data>
						</xsl:template>


				<xsl:template name = "StuffCSV">
					<xsl:param name = "ToStuff"/>
					<xsl:param name = "HyperlinkId"/>
					<xsl:param name = "RawData"
							   select = "'1'"/>
					<xsl:choose>
						<xsl:when test = "$HyperlinkId != ''">
							<xsl:call-template name = "StuffCSV">
								<xsl:with-param name = "ToStuff">
									<xsl:text>=HYPERLINK("nds://</xsl:text>
									<xsl:value-of select = "$HyperlinkId"/>
									<xsl:text>", </xsl:text>
									<xsl:call-template name = "StuffCSV"><xsl:with-param name = "ToStuff"
																						 select = "$ToStuff"/><xsl:with-param name = "RawData"
																															  select = "'0'"/></xsl:call-template>
									<xsl:text>)</xsl:text>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test = "starts-with($ToStuff, '=') and $RawData = '1'">
							<xsl:text>"="</xsl:text>
							<xsl:call-template name = "StuffCSV"><xsl:with-param name = "ToStuff"
																				 select = "$ToStuff"/><xsl:with-param name = "RawData"
																													  select = "'0'"/></xsl:call-template>
							<xsl:text>""</xsl:text>
						</xsl:when>
						<xsl:when test = "contains($ToStuff, '&quot;')">
							<xsl:call-template name = "StuffCSV"><xsl:with-param name = "ToStuff"
																				 select = "substring-before($ToStuff, '&quot;')"/><xsl:with-param name = "RawData"
																																				  select = "'0'"/></xsl:call-template>
							<xsl:call-template name = "StuffCSV"><xsl:with-param name = "ToStuff"
																				 select = "substring-after($ToStuff, '&quot;')"/><xsl:with-param name = "RawData"
																																				 select = "'0'"/></xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>"</xsl:text>
							<xsl:value-of select = "$ToStuff"/>
							<xsl:text>"</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>


						<xsl:template name = "PrintNewline">
							<xsl:text xml:space = "preserve"></xsl:text>
						</xsl:template>
				</xsl:stylesheet>

			]]></XSLT>
		</Report>
	-->

	<USLReportParameters>
		<DSL>
			<Metadata>
				<ChoiceList Name = "cl_bool">
					<Choice DBValue = "0"
					        GUIValue = "0"/>
					<Choice DBValue = "1"
					        GUIValue = "1"/>
				</ChoiceList>
				<ChoiceList Name = "cl_accdomain">
					<Choice DBValue = "Current"
					        GUIValue = "Domain"/>
					<Choice DBValue = "Current+"
					        GUIValue = "Domain and subdomains"/>

				</ChoiceList>
				<Entity Name = "Parameters">
					<Field Name = "StartTime"/>
					<Field Name = "EndTime"/>
					<Field Name = "StartTimeG"
					       BehaveLike = "GPersonArrest.StartTimeTZV2G"/>
					<Field Name = "EndTimeG"
					       BehaveLike = "GPersonArrest.StartTimeTZV2G"/>

					<Field Name = "ESAREALEVEL6G"
					       BehaveLike = "PhysicalAddress.ESAreaLevel6G"/>
					<Field Name = "ESAREALEVEL5G"
					       BehaveLike = "PhysicalAddress.ESAreaLevel5G"/>

					<Field Name = "ESAREALEVEL3G"
					       BehaveLike = "PhysicalAddress.ESAreaLevel3G"/>


					<Field Name = "OfficerRId"/>
					<Field Name = "OfficerRId_L">
						<Selector ColumnHelpFields = "OfficerRId=Id;OfficerRId_L=Label"
						          ColumnHelp = "SpecificationKey=d_gpersonemploylist;Title=Officer selector;Text1=1. Enter officer's badge number or name.;Text2=. Select officer from list.;Condition=ACCDomain=='Current-' AND Indexed==1 AND IsEmployee==1"/>
					</Field>
					<SetField Name = "OfficerClassification"
					          ChoiceListName = "cl_PersonClassification"
					          ChoiceListSource = "NML"/>
					<SetField Name = "OccurrenceStatusInternal"
					          ChoiceListName = "cl_UCRIncidentClearanceStatus"
					          ChoiceListSource = "NML"/>


					<Field Name = "OccurrenceTypeRId_L">
						<Selector ColumnHelpFields = "OccurrenceTypeRId=Id;OccurrenceTypeRId_L=Label"
						          ColumnHelp = "SpecificationKey=d_StandardOccurrenceTypeLabel;Title=Standard Incident Type Selector;Text1=1. Enter all or part of an Incident Type.;Text2=2. Select Incident Type from list.;Condition=ACCDomain=='Current-' AND MakeInterval(EffectiveFromTimeTZV2I, EffectiveToTimeTZV2I, '[]', 'NullIsInfinite')=='now';DateRestrictedCondition=ACCDomain=='Current-' AND ((EffectiveToTimeTZV2I IS NULL OR EffectiveToTimeTZV2I &gt; '{0}') AND (EffectiveFromTimeTZV2I IS NULL OR EffectiveFromTimeTZV2I &lt; '{0}') AND AnyOfSetHasProperty(Properties, 'cl_StandardOccurrenceTypeProperties', 'clvIsOffenseNoticeOcc', '1')==1)"/>
					</Field>
					<Field Name = "OccurrenceTypeRId"
					       BehaveLike = "Occurrence.OccurrenceStdOccTypeRId"/>


					<SetField Name = "OccurrenceClassification"
					          ChoiceListName = "cl_OccurrenceClassification"
					          ChoiceListSource = "NML"/>
					<!--<SetField Name = "TaskType"
					          ChoiceListName = "cl_TaskType"
					          ChoiceListSource = "NML"/>-->
					<Field Name = "AccDomainG"/>
					<BoolField Name = "UseReportServer"
					           ChoiceListName = "cl_bool"/>
				</Entity>
			</Metadata>
			<Entity Name = "Parameters"
			        DSLBased = "True">
				<OnFieldChange Name = "StartTimeG"
				               Action = "CopyDateGFieldToDateCFieldOnUpdate">
					<ActionParameter Name = "SetFieldName"
					                 Value = "StartTime"/>
				</OnFieldChange>
				<OnFieldChange Name = "EndTimeG"
				               Action = "CopyDateGFieldToDateCFieldOnUpdate">
					<ActionParameter Name = "SetFieldName"
					                 Value = "EndTime"/>
				</OnFieldChange>
				<Field Name = "StartTime"/>
				<Field Name = "EndTime"/>
				<Field Name = "StartTimeG"/>
				<Field Name = "EndTimeG"/>

				<!--GUI fields for Area Parameters-->
				<Field Name = "ESAREALEVEL6G"
				       ExportName = "ESAreaLevel6"
				       ExportType = "DisplayValue"/>
				<Field Name = "ESAREALEVEL5G"
				       ExportName = "ESAreaLevel5"
				       ExportType = "DisplayValue"/>
				<Field Name = "ESAREALEVEL3G"
				       ExportName = "ESAreaLevel3"
				       ExportType = "DisplayValue"/>

				<!--GUI fields for Officer search parameters-->
				<Field Name = "OfficerRId"
				       ExportName = "OfficerRId"
				       ExportType = "StorableValue"/>
				<Field Name = "OfficerRId_L"
				       ExportName = "OfficerRId_L"
				       ExportType = "DisplayValue"/>

				<!--GUI fields for Officer Classification search paramters-->
				<Field Name = "OfficerClassificationG"
				       ExportName = "OfficerClassification"
				       ExportType = "StorableValue"/>
				<Field Name = "OccurrenceStatusInternalG"
				       ExportName = "OccurrenceStatus"
				       ExportType = "StorableValue"/>

				<!--GUI fields for Incident Type search parameters-->
				<Field Name = "OccurrenceTypeRId"
				       ExportName = "OccurrenceTypeRId"
				       ExportType = "StorableValue"/>
				<Field Name = "OccurrenceTypeRId_L"
				       ExportName = "OccurrenceTypeRId_L"
				       ExportType = "DisplayValue"/>

				<Field Name = "OccurrenceClassificationG"
				       ExportName = "OccurrenceClassification"
				       ExportType = "StorableValue"/>
				<!--<Field Name = "TaskTypeG"-->
				<!--       ExportName = "TaskType"-->
				<!--       ExportType = "StorableValue"/>-->

				<Field Name = "AccDomainG"
				       ExportName = "ACCDomain"
				       ExportType = "DisplayValue"/>
				<Field Name = "UseReportServerG"
				       ExportName = "UseReportServer"
				       ExportType = "StorableValue"/>

			</Entity>
		</DSL>

		<Data>
			<Node Name = "Parameters"
			      DSLBased = "true">
				<Cell Name = "StartTime"
				      Value = ""/>
				<Cell Name = "EndTime"
				      Value = ""/>
				<Cell Name = "StartTimeG"
				      Value = ""/>
				<Cell Name = "EndTimeG"
				      Value = ""/>

				<Cell Name = "ESAREALEVEL6G"/>
				<Cell Name = "ESAREALEVEL5G"/>
				<Cell Name = "ESAREALEVEL3G"/>

				<Cell Name = "OfficerRId"/>
				<Cell Name = "OfficerRId_L"/>

				<Cell Name = "OfficerClassificationG"
				      Value = ""/>
				<Cell Name = "OccurrenceStatusInternalG"/>

				<Cell Name = "OccurrenceTypeRId"/>
				<Cell Name = "OccurrenceTypeRId_L"/>
				<Cell Name = "OccurrenceClassificationG"/>
				<!--<Cell Name = "TaskTypeG"/>-->
				<Cell Name = "AccDomainG"
				      Value = ""/>
				<Cell Name = "UseReportServerG"
				      Value = "0"/>

			</Node>
		</Data>

		<USL>
			<![CDATA[
				view AnalysisOfCaseLoad
				{
					context: (path: 'Data', firstNode: true)
					flowGrid(maxColumns: 2, content: {
						column(span: 2, content: textBlock(labelText: 'Incident statistics:', style: st_XSLTReportHeader))
						column(span: 2, content: nmlFieldControl(labelText: 'Choose start of range for incident time:', fieldName: 'StartTimeG'))
						column(span: 2, content: nmlFieldControl(labelText: 'Choose end of range for incident time:', fieldName: 'EndTimeG'))

						column (content: nmlFieldControl(labelKey: 'FL:PhysicalAddress:ESAreaLevel6G', fieldName: 'ESAREALEVEL6G', visibility: nmlFieldVisibility ('PhysicalAddress', 'ESAreaLevel6')))
						column (content: nmlFieldControl(labelKey: 'FL:PhysicalAddress:ESAreaLevel5G', fieldName: 'ESAREALEVEL5G', visibility: nmlFieldVisibility ('PhysicalAddress', 'ESAreaLevel5')))

						column (content: nmlFieldControl(labelKey: 'FL:PhysicalAddress:ESAreaLevel3G', fieldName: 'ESAREALEVEL3G', visibility: nmlFieldVisibility ('PhysicalAddress', 'ESAreaLevel3')))
						column(content: nmlFieldControl(labelText: 'Officer/unit', fieldName: 'OfficerRId_L'))

						column(content: nmlFieldControl(labelText: 'Officer/unit classification(s):', fieldName: 'OfficerClassificationG'))
						column(content: nmlFieldControl(labelText: 'Incident status', fieldName: 'OccurrenceStatusInternalG'))

						column(content: nmlFieldControl(labelText: 'Incident type', fieldName: 'OccurrenceTypeRId_L'))
						column(content: nmlFieldControl(labelText: 'Incident classification', fieldName: 'OccurrenceClassificationG'))
						<!--column(content: nmlFieldControl(labelText: 'Task Type', fieldName: 'TaskTypeG'))-->


						column(forceNewRow: true, content: customControl(labelText: 'Domain', fieldName: 'AccDomainG', type: selectDomain))
						column(content: nmlFieldControl(labelText: 'Use report server', fieldName: 'UseReportServerG'))
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

			declare StartTime edit				{ datatype = datetime; tag="EntityName=Occurrence;FieldName=StartTimeTZV2S"; label = "Choose start of range for incident time:"; };
			declare EndTime edit  				{ datatype = datetime; tag="EntityName=Occurrence;FieldName=StartTimeTZV2S"; label = "Choose end of range for incident time:"; };


			declare ESAreaLevel3 edit			{ tag = "EntityName=PhysicalAddress;FieldName=ESAreaLevel3;AllowMultiValues=1"; size = 50; label = "Site:"; };
			declare ESAreaLevel5 edit			{ tag = "EntityName=PhysicalAddress;FieldName=ESAreaLevel5;AllowMultiValues=1"; size = 50; label = "State/zone:"; };
			declare ESAreaLevel6 edit			{ tag = "EntityName=PhysicalAddress;FieldName=ESAreaLevel6;AllowMultiValues=1"; size = 50; label = "Region:"; };

			declare OfficerRId_L edit			{ tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer1RId_L"; label = "Officer/unit:"; };
			declare OfficerRId edit				{ tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer1RId"; };

			declare OfficerClassification set	{ tag = "EntityName=Person;FieldName=ClassificationG"; label = "Officer/unit classification"; };


			declare OccurrenceStatusInternal set{ tag = "EntityName=Occurrence;FieldName=UCRClearanceStatusG"; label = "Incident status:"; };


			declare OccurrenceTypeRId_L edit	{ tag = "EntityName=Occurrence;FieldName=OccurrenceStdOccTypeRId_L"; label = "Incident type:"; };
			declare OccurrenceTypeRId edit		{ tag = "EntityName=Occurrence;FieldName=OccurrenceStdOccTypeRId"; };

			declare OccurrenceClassification set{ tag = "EntityName=Occurrence;FieldName=ClassificationG"; label = "Incident classification"; };


			declare ddlb_accdomain choicelist	{ label = "Domain:"; tag = "MorphField=false"; };
			declare ddlb_scope choicelist		{ label = "Scope:";};

			declare UseReportServer checkbox
			{
				label = e"Use Report server:"f"Serveur de rapport";
				default = "0";
			};

			datawindowdef ParameterWindow "ParameterWindow"
			{
				//total width = 2432

				griddef
				{
					columns = 1;
					labelwidth = 0;
					fieldwidth = 2000;
					leftmargin = 0;
				};

				// The report title.  This will span both columns.
				text Title
				{
					label = "Incident statistics";
					fontstyle = "Arial Black";
					fontsize = 12;
					fonteffect = italic!;
					location = page;
					align = center;
					height = 92;
				};

				break(90);

				griddef
				{
					columns = 1;
					labelwidth = 1000;
					fieldwidth = 500;
					leftmargin = 200;
				};

				field StartTime;
				field EndTime;
				break;

				text Warning
				{
					pos = (0, 400);
					label=e"The starting date in the date range must come before the ending date."f"L'heure de départ dans la plage de temps doit être avant l'heure de Fin.";
					align = center;
					width = 2000;
					visible = expression "if (f_nonull(StartTime) = '' or f_nonull(EndTime) = '', 0, if(f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), 1, 0))";
					textcolor=rgb(255,0,0); //red
				};

				break;

				griddef
				{
					columns = 3;
					leftmargin = 0;
					labelwidth = 200;
					fieldwidth = 400;
				};

				field ESAreaLevel6;
				field ESAreaLevel5;

				field ESAreaLevel3;



				griddef
				{
					columns = 2;
					labelwidth = 550;
					fieldwidth = 500;
					leftmargin = 0;
				};

				field OfficerRId_L;
				field OfficerRId { visible = false; property CreateControlOnDW = "1"; };
				field OfficerClassification;

				field OccurrenceStatusInternal;
				field OccurrenceTypeRId_L;
				field OccurrenceTypeRId { visible = false; property CreateControlOnDW = "1"; };
				field OccurrenceClassification;

				break(80);
				field ddlb_accdomain;
				field UseReportServer;
				field ddlb_scope { visible = false; }; // This field needs to exist, but we don't want it.
				break;


				// Used to display an error message to the user
				computedfield invalidfields
				{
					visible = false;
					expression =
						"if (f_nonull(StartTime) = '', "
							"'~t' + f_TranslateString('str:startdate') + '~n', '') + "
						"if (f_nonull(EndTime) = '', "
							"'~t' + f_TranslateString('str:enddate') + '~n', '') + "
						"if (f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), "
							"'~t' + f_TranslateString('str:daterangewarning') + '~n', '') ";
				};

				// Used by the DW to validate the data
				computedfield valid
				{
					visible = false;
					expression =
						"((f_nonull(StartTime) <>'' and f_nonull(EndTime) <> '' )"
								"and f_getdatetimecomparablecfromg(StartTime) <= f_getdatetimecomparablecfromg(EndTime)) ";
				};

				computedfield StartTimeG { visible = false; expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(StartTime))"; };
				computedfield EndTimeG { visible = false; expression = "f_GetDateTimeGFromC(f_GetDateTimeCFromS(EndTime))"; };

				computedfield ACCDomain
				{
					visible = false;
					expression = "f_ProcessDomainForReport(ddlb_accdomain)";
				};

				computedfield OccurrenceStatus
				{
					visible = false;
					expression ="if (len(OccurrenceStatusInternal) > 0, md_GetDBValueFromSetByName('Occurrence', 'UCRClearanceStatusG', f_NoNull(OccurrenceStatusInternal)), '')";
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
</root>