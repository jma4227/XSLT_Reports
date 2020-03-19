<?xml version="1.0" encoding="Windows-1252"?>
<root>
	<VersionInfo>
		<Filename>OccurrenceSummaryBrief.xml</Filename>
		<Revision>1.17</Revision>
		<NMLVersion>5.04.11.02.18</NMLVersion>
		<Developer>Niche</Developer>
		<NicheBuildName>BexarCounty</NicheBuildName>
		<BuildTime>2018/07/21 22:08:06</BuildTime>
	</VersionInfo>

	<!-- Information to be used when loading the report -->
	<!-- Is this report for an entire domain, rather than an instance of data -->
	<IsDomainReport>1</IsDomainReport>

	<!-- Should this show up in the list of reports for an entity in the print menu -->
	<IsPrintTemplate>1</IsPrintTemplate>

	<!-- Suggested report name in the print menu -->
	<ReportName>e"Occurrence summary - brief"s"Incident summary - brief"</ReportName>

	<!-- Can be enclosed in CDATA.  A general description of what the report does -->
	<Documentation>Displays a very brief summary of all occurrences conforming to the specified parameters</Documentation>

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
	<SQLParameter>BoloReport</SQLParameter>
	<SQLParameter>LegacyBoloReport</SQLParameter>
	<SQLParameter>FlagType</SQLParameter>
	<SQLParameter>FlagActive</SQLParameter>
	<SQLParameter>UseReportServer</SQLParameter>

	<XSLTParameter>TimeRange</XSLTParameter>
	<XSLTParameter>StartTimeG</XSLTParameter>
	<XSLTParameter>EndTimeG</XSLTParameter>
	<XSLTParameter>AreaLevel6</XSLTParameter>
	<XSLTParameter>AreaLevel5</XSLTParameter>
	<XSLTParameter>AreaLevel4</XSLTParameter>
	<XSLTParameter>AreaLevel3</XSLTParameter>
	<XSLTParameter>AreaLevel2</XSLTParameter>
	<XSLTParameter>AreaLevel1</XSLTParameter>
	<XSLTParameter>BoloReport</XSLTParameter>
	<XSLTParameter>LegacyBoloReport</XSLTParameter>
	<XSLTParameter>FlagTypeG</XSLTParameter>
	<XSLTParameter>FlagActive</XSLTParameter>


	<ReportHeader><![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p>"]]></ReportHeader>


	<ReportFooter><![CDATA[e"""<p align='center'><b>[@PARAM=PROTECTIVEMARKING]</b></p><p align='center'>"e"Printed by:""&nbsp;&nbsp;[@AGBL=USERNUM]&nbsp;&nbsp;&nbsp;"e"Date:""&nbsp;&nbsp;[DATE] [TIME]&nbsp;&nbsp;&nbsp;"e"Computer:""&nbsp;&nbsp;[@AGBL=COMPUTERNAME]&nbsp;&nbsp;&nbsp;"e"Page"" [PAGENUM] of [PAGETOTAL]</p>"]]></ReportFooter>

	<ReportHeaderTop></ReportHeaderTop>
	<ReportFooterBottom></ReportFooterBottom>
	<ReportDetailMarginTop></ReportDetailMarginTop>
	<ReportDetailMarginLeft></ReportDetailMarginLeft>
	<ReportDetailMarginRight></ReportDetailMarginRight>
	<ReportDetailMarginBottom></ReportDetailMarginBottom>
	<DefaultProtectiveMarking></DefaultProtectiveMarking>
	<OutputType>html</OutputType>
	<SQLSelectXSLT><![CDATA[<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
				<xsl:output method="text" omit-xml-declaration="yes" />
				<xsl:param name="ACCDomain" />
				<xsl:param name="TimeRange" />
				<xsl:param name="StartTime" />
				<xsl:param name="EndTime" />
				<xsl:param name="StartTimeMinus3Days" />
				<xsl:param name="EndTimePlus3Days" />
				<xsl:param name="NowMinus4Days" />
				<xsl:param name="NowMinus5Days" />
				<xsl:param name="NowMinus10Days" />
				<xsl:param name="AreaLevel6" />
				<xsl:param name="AreaLevel5" />
				<xsl:param name="AreaLevel4" />
				<xsl:param name="AreaLevel3" />
				<xsl:param name="AreaLevel2" />
				<xsl:param name="AreaLevel1" />
				<xsl:param name="BoloReport" />
				<xsl:param name="LegacyBoloReport" />
				<xsl:param name="FlagType" />
				<xsl:param name="FlagActive" />
				<xsl:param name="UseReportServer" />

				<xsl:template match="/">
					----------------------------------------------------------
					--  XML filename: OccurrenceSummaryBrief.xml
					--  File revision: 1.17
					--  NML version: 5.04.11.02.18
					--  Developer: Niche
					--  Niche build name: BexarCounty
					--  Build time: 2018/07/21 22:08:06
					----------------------------------------------------------

					SELECT
						OCC__Summary,
						OCC__LabelShort

					FROM Occurrence OCC

					WHERE OCC.ACCDomain = '<xsl:value-of select="$ACCDomain" />'
						<!-- We check ReportedTime first, because it is indexed, so comparing against it is much faster.
							We give it a buffer of an extra 3 days, to make sure we account for time zones, daylight savings, etc.
							Once we've narrowed it down, we do the actual check against ReportedTimeTZV2I on a much smaller data set. -->
						<xsl:if test="$TimeRange = 'L24'"> AND OCC.ReportedTime &gt; <xsl:value-of select="$NowMinus4Days" /> AND OCC.ReportedTimeTZV2I &gt; 'now-1d'</xsl:if>
						<xsl:if test="$TimeRange = 'L48'"> AND OCC.ReportedTime &gt; <xsl:value-of select="$NowMinus5Days" /> AND OCC.ReportedTimeTZV2I &gt; 'now-2d'</xsl:if>
						<xsl:if test="$TimeRange = 'L7D'"> AND OCC.ReportedTime &gt; <xsl:value-of select="$NowMinus10Days" /> AND OCC.ReportedTimeTZV2I &gt; 'now-7d'</xsl:if>
					<xsl:if test="$TimeRange = 'RNG'"> AND OCC.ReportedTime &gt; <xsl:call-template name="StuffSQL"><xsl:with-param name="ToStuff" select="$StartTimeMinus3Days" /></xsl:call-template>
														AND Occ.ReportedTime &lt; <xsl:call-template name="StuffSQL"><xsl:with-param name="ToStuff" select="$EndTimePlus3Days" /></xsl:call-template>
														AND OCC.ReportedTimeTZV2I = '[<xsl:value-of select="$StartTime" />, <xsl:value-of select="$EndTime" />]'</xsl:if>

					<xsl:if test="$AreaLevel6">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel6" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel6</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$AreaLevel5">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel5" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel5</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$AreaLevel4">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel4" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel4</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$AreaLevel3">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel3" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel3</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$AreaLevel2">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel2" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel2</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$AreaLevel1">
						AND
						<xsl:call-template name="MultiValueField">
							<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel1" /></xsl:with-param>
							<xsl:with-param name="DBField">OCC.ESAreaLevel1</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="$LegacyBoloReport = '1' and $BoloReport = '1'">
						AND OCC.BOLO = 1
					</xsl:if>

					<xsl:if test="($LegacyBoloReport != '1' or $BoloReport != '1') and $FlagType != ''">
						AND EXISTS(SELECT Id FROM GOccurrenceFlag GOF WHERE GOF.WId = OCC.Id
						AND
							<xsl:call-template name="CreateConditionFromSet">
								<xsl:with-param name="FieldName">GOF.Type1</xsl:with-param>
								<xsl:with-param name="FieldValue"><xsl:value-of select="$FlagType" /></xsl:with-param>
							</xsl:call-template>
							<xsl:if test="$FlagActive != 'U'">
								AND GOF.Active = '<xsl:value-of select="$FlagActive" />'
							</xsl:if>
						)
					</xsl:if>

					<xsl:if test="$UseReportServer = '1'">
						AND QueryServer = 'Report'
					</xsl:if>


					SELECT SPValue AS AgencyName FROM SystemParameterSettingForACC WHERE SPKey='Label.AgencyName'
					SELECT SPValue AS DivisionName, 1 AS CFDSIgnoreDataSetChanges FROM SystemParameterSettingForACC WHERE SPKey='Label.DivisionName'
					SELECT EmployeeNumber AS CurrentEmployeeNumber, Label AS CurrentUser, 1 AS CFDSIgnoreDataSetChanges FROM GPerson WHERE Id=@currentUserId

					select DataTimestampTZV2GL AS DataTimestamp, 1 AS CFDSIgnoreDataSetChanges FROM DataTimestamp
						<xsl:if test="$UseReportServer = '1'">
							where QueryServer = 'Report'
						</xsl:if>

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


			</xsl:stylesheet>]]></SQLSelectXSLT>
	<ReportXSL>
		<![CDATA[<?xml version="1.0" encoding="Windows-1252"?>
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
				<xsl:template match="/">
					<xsl:element name="HTML">
						<xsl:variable name="ReportTitle"><nl:mls><e>Occurrence</e><s>Incident</s></nl:mls> Summary</xsl:variable>
						<xsl:element name="title"><xsl:value-of select="$ReportTitle" /></xsl:element>

						<!-- Insert the style class declarations -->
						<xsl:call-template name="StyleClasses" />

						<xsl:element name="BODY">
							<!-- Insert the title-->
							<xsl:call-template name="Title">
								<xsl:with-param name="Text" select="$ReportTitle" />
							</xsl:call-template>

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
									<xsl:if test="$LegacyBoloReport and $BoloReport"> - BOLO</xsl:if>
									<xsl:if test="$FlagTypeG"><xsl:text> - </xsl:text><xsl:value-of select="translate($FlagTypeG, ';', '-')" /></xsl:if>
									<xsl:choose>
										<xsl:when test="$FlagActive = '1'"> - active</xsl:when>
										<xsl:when test="$FlagActive = '0'"> - inactive</xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>

							<!-- Report body -->
							<xsl:call-template name="DisplayOccurrenceSummary">
								<xsl:with-param name="FlagType" select="concat($FlagTypeG, ';')" />
							</xsl:call-template>
						</xsl:element>
					</xsl:element>
				</xsl:template>

				<xsl:template name="DisplayOccurrenceSummary">
					<xsl:param name="FlagType" />

					<xsl:if test="$FlagType != ''">
						<xsl:variable name="CurrentFlag" select="substring-before($FlagType, ';')" />

						<xsl:if test="count(DATASETLIST/DATASET/ROW[contains(OCC__Flag_cacheG, $CurrentFlag)]) &gt; 0">
							<div class="ReportHeader2"><xsl:value-of select="$CurrentFlag" /></div>
							<xsl:for-each select="DATASETLIST/DATASET/ROW[contains(OCC__Flag_cacheG, $CurrentFlag)]">
								<xsl:call-template name="DisplaySingleOccurrence" />
							</xsl:for-each>
						</xsl:if>

						<xsl:call-template name="DisplayOccurrenceSummary">
							<xsl:with-param name="FlagType" select="substring-after($FlagType, ';')" />
						</xsl:call-template>

					</xsl:if>

				</xsl:template>

				<xsl:template name="DisplaySingleOccurrence">
					<hr />
					<table width="100%" cellspacing="2" cellpadding="0">
						<tr>
							<td class="Label"><nl:mls><e>Occurrence</e><s>Incident</s></nl:mls>:</td>
							<td colspan="3"><b><xsl:value-of select="OCC__LabelShort" /></b></td>
						</tr>
						<tr>
							<td class="Label">Summary:</td>
							<td colspan="3"><xsl:value-of select="OCC__Summary" /></td>
						</tr>
					</table>
					<br />

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
								TH			{ text-align:left; border-color: silver; border-style: none none solid none; border-width:2px; font-size: 7pt; font-style: italic; vertical-align: bottom; }
								TABLE		{ font-size: 10pt; }

								TABLE.GridLayout	{ width:100%; font-size: 7pt; padding: 0px 2px 0px 2px; vertical-align: top; }
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
													<xsl:text><nl:mls><e>Valid as of </e><f>Valide à partir de </f></nl:mls></xsl:text>
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
													<xsl:text><nl:mls><e>Printed by </e><f>Imprimé par </f></nl:mls></xsl:text>
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
				size = 1000;
				default = "GGGGGGGGG";
			};
			declare TimeRange choicelist
			{
				choices=
				{
					"ALL"{e"All"f"Tous";}
					"L24"{e"Last 24 hours"f"Dernières 24 heures";}
					"L48"{e"Last 48 hours"f"Dernières 48 heures";}
					"L7D"{e"Last 7 days"f"7 derniers jours";}
					"RNG"{e"Specify"f"Période:";}
				};
				label = e"Time range:"f"Période:";
				default="L24";
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
				label = e"to"f"à";
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
				default = ";";
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

			declare ddlb_accdomain choicelist {label=e"Domain:"f"Domaine:";};
			declare ddlb_scope choicelist {label=e"Scope:"f"Portée:";};

			declare UseReportServer checkbox
			{
				label = e"Use Report server:";
				default = "1";
			};

			datawindowdef ParameterWindow "ParameterWindow"
			{
				//total width = 2432

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
					label = e"Occurrence summary"f"Sommaire de l'incident"s"Incident summary";
					fontstyle = "Arial Black";
					fontsize = 12;
					fonteffect = italic!;
					location = page;
					align = center;
					height = 92;
				};

				break(120);

				// Row 1
				skipcol;
				field AreaLevel6 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel6.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 2
				field TimeRange;
				field AreaLevel5 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel5.Visible', '', '') <> '0', 1, 0)";};
				break;

				// Row 3
				skipcol;
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

				// Row 7
				field ddlb_accdomain {colspan=2;};
				field ddlb_scope {colspan=2;};

				griddef
				{
					columns = 1;
					labelwidth = 500;
					fieldwidth = 500;
					leftmargin = 500;
				};

				field UseReportServer;

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

				computedField FlagType { visible = false; expression = "if (len(FlagTypeCL) > 0, md_GetDBValueFromSetByName('GOccurrenceFlag', 'Type1G', f_NoNull(FlagTypeCL)), '')";};
				computedField FlagTypeG { visible = false; expression = "FlagTypeCL";};

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

				computedfield LegacyBoloReport
				{
					visible = false;
					expression = "f_NoNull(f_GetProperty('GOccurrence.LegacyBOLOReport', '', ''))";
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