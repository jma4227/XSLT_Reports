<root>
	<!--$Id: DailySummaryReport.xslt, v 2.01 2020/03/11 BCSO James Ma Exp $
		TODO
		  Task type can be independent search parameter, but Status is dependent on Type
		  Create a datawindow to search by unit individually or by unit.

		  Version 2.01.05 Additions 2020/03/31 BCSO James Ma EXP $
		    - Add statistics box at top of page. This statistics box can be either officer or by
		    Assigned Unit.

		    - Fix Search parameter for $TaskAssignedTo $TaskType & TaskStatus. SQL parameters
		    needed a choose statement to properly execute search parameters.

		    - Add correction to datatables JS by adding extra 'null' in aoColumns options. it is
		    added because of the 'clone' th and td variables that are in the datatables functions


		Version 2.01.04 Additions 2020/03/26 BCSO James Ma EXP $
			- Added SQL Parameter for Searching by  Assigned Tasks by Officer/Unit.
			- Added Datawindow Checkbox to search assigned tasks by unit
			- Assigned to cell is linked with Unit/task assigned

		Version 2.01.03 Additions 2020/03/18 BCSO James Ma EXP $
			- Fixed search by Task Type and Task Status to only select the chosen parameter and
			not all incidents.


		Version 2.01.02 Additions 2020/03/18 BCSO James Ma EXP $
			- Add Search Parameter for Officer/Unit
			- Added Search Capabilities using Officer # or Unit Name

		Version 2.01.01 Additions 2020/03/11 BCSO James Ma EXP $

			- Add Search Parameter for Incident Type and Incident Classification
			- Add Datawindow option to choose Incident Type & Incident Classification

	-->

	<!-- $Id: DailySummaryReport.xslt,v 1.11 2012/07/03 OPP Donovan Snelleman Exp $

		Version 1.11 Additions 2012/07/03 OPP Donovan Snelleman
			- Add Datawindow Option to include/disclude Mapping options
			- Add a layer name to the mapping data

		Version 1.10 Additions 2012/03/30 OPP Donovan Snelleman
			- Add Mapping ability to report

		Version 1.9 Additions 2011/11/03 OPP Donovan Snelleman
			- Add a free text field to DDW which allows user to add custom notes to the top of the report
			- Make sure street checks show with street check type
			- Add option to highlight BOLO Occurrences
			- Add option to highlight Occurrence that are missing the UCR
			- Add Duty Location to the output of the report
			- Fix to remove character "\" from summaries, as this was causing errors in compilation (2011/11/29)

		Version 1.8 Additions 2011/01/25 OPP Donovan Snelleman
			- Add a "Last 12 Hours" time frame option

		Version 1.7 Additions 2010/07/08 08:10:00 OPP Donovan Snelleman
			- Remove code for platoons, Unit Code area will be just for Specialized Units
			- Remove the Print Occurrence Summary checkbox since it does not work with new datatables
			- If special unit is entered, make the query look for duty location in both Occ. Address and Disp Address

		Version 1.6 Additions 2010/06/23 10:38:00 OPP Donovan Snelleman
			- Fix issue with Unit box not returning anything for a supplied platoon

		Version 1.5 Additions 2010/06/21 09:38:00 OPP Donovan Snelleman
			- Fix issue with mht files not working after being emailed
			- Javascript to show details duplicates existing field in mht. create workaround to skip function if column already exists
			- Remove JavascriptSlideClass since it is not used anymore

		Version 1.4 Additions 2010/05/25 11:09 OPP Donovan Snelleman
			- Add Investigator as an option for shown officers
			- Add Sort and Filter ability to Data Table
			- Above changed forced a differnet way of showing details, handled by javascript now
			- Change so images to load from intranet link instead of External Document

		Version 1.3 Additions 2010/05/13 12:01:00 OPP Donovan Snelleman
			- Add Data Window Def, to search by Unit instead of Duty Location. This is for special units to be able to track their work
			- Show duty Loc field if Unit Code is added to search
			- changed label from Officer to Rpt/Disp Officer
			- added total count of occurrences to bottom of report

		Version 1.2 Additions 2010/04/09 08:34:00 OPP Donovan Snelleman
			- Undocumented

		Version 1.1 Additions 2010/?/? OPP Donovan Snelleman
			- Undocumented

		Version 1.0 2010/?/? OPP Donovan Snelleman
			- Initial Creation
	-->

	<!-- Information to be used when loading the report -->
	<!-- Is this report for an entire domain, rather than an instance of data -->
	<IsDomainReport>1</IsDomainReport>

	<!-- Should this show up in the list of reports for an entity in the print menu -->
	<IsPrintTemplate>1</IsPrintTemplate>

	<!-- Suggested report name in the print menu -->
	<ReportName>Daily Summary Report</ReportName>

	<!-- Can be enclosed in CDATA.  A general description of what the report does -->
	<Documentation>Provides a list of all occurrences and their summaries in the supplied area in
		the given date range
	</Documentation>

	<SQLParameter>ACCDomain</SQLParameter>
	<SQLParameter>TimeRange</SQLParameter>
	<SQLParameter>StartTime</SQLParameter>
	<SQLParameter>EndTime</SQLParameter>
	<SQLParameter>AreaLevel5</SQLParameter>
	<SQLParameter>AreaLevel3</SQLParameter>
	<SQLParameter>OccurrenceTypeRId</SQLParameter>
	<SQLParameter>OccurrenceClassification</SQLParameter>
	<SQLParameter>ClearanceStatus</SQLParameter>
	<SQLParameter>TaskStatus</SQLParameter>
	<SQLParameter>TaskType</SQLParameter>
	<SQLParameter>OfficerUnitIds</SQLParameter>
	<SQLParameter>UnitCode</SQLParameter>
	<SQLParameter>ReportableOnly</SQLParameter>
	<SQLParameter>DispatchOnly</SQLParameter>
	<SQLParameter>HighlightBolo</SQLParameter>
	<SQLParameter>HighlightMissingUCR</SQLParameter>
	<SQLParameter>IncludeMapping</SQLParameter>
	<SQLParameter>TaskAssignedTo</SQLParameter>


	<XSLTParameter>TimeRange</XSLTParameter>
	<XSLTParameter>StartTimeG</XSLTParameter>
	<XSLTParameter>EndTimeG</XSLTParameter>
	<XSLTParameter>AreaLevel5</XSLTParameter>
	<XSLTParameter>AreaLevel3</XSLTParameter>
	<XSLTParameter>OfficerUnitIds</XSLTParameter>
	<XSLTParameter>UnitCode</XSLTParameter>
	<XSLTParameter>ReportableOnly</XSLTParameter>
	<XSLTParameter>DispatchOnly</XSLTParameter>
	<XSLTParameter>AdditionalInfo</XSLTParameter>
	<XSLTParameter>HighlightBolo</XSLTParameter>
	<XSLTParameter>HighlightMissingUCR</XSLTParameter>
	<XSLTParameter>IncludeMapping</XSLTParameter>
	<XSLTParameter>TaskAssignedTo</XSLTParameter>
	<XSLTParameter>TaskTypeG</XSLTParameter>
	<XSLTParameter>TaskStatusG</XSLTParameter>
	<XSLTParameter>OccurrenceTypeRId</XSLTParameter>


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
	<SQLSelectXSLT><![CDATA[



			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
				<xsl:output method="text" omit-xml-declaration="yes" />
				<xsl:param name="ACCDomain" />
				<xsl:param name="TimeRange" />
				<xsl:param name="StartTime" />
				<xsl:param name="EndTime" />
				<xsl:param name="AreaLevel5" />
				<xsl:param name="AreaLevel3" />
				<xsl:param name="OfficerUnitIds" />
				<xsl:param name="UnitCode" />
				<xsl:param name="ReportableOnly" />
				<xsl:param name="DispatchOnly" />
				<xsl:param name="HighlightBolo" />
				<xsl:param name="HighlightMissingUCR" />
				<xsl:param name="IncludeMapping" />
				<xsl:param name="OccurrenceTypeRId" />
				<xsl:param name="OccurrenceClassification" />
				<xsl:param name="ClearanceStatus" />
				<xsl:param name="TaskStatus" />
				<xsl:param name="TaskType" />
				<xsl:param name="TaskAssignedTo" />

				<xsl:template match="/">



					<xsl:variable name="PersonIds">
						<xsl:call-template name="GetEntityIds">
							<xsl:with-param name="Ids" select="$OfficerUnitIds" />
							<xsl:with-param name="EntityNumber">1500</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>

					<xsl:variable name="OrgUnitIds">
						<xsl:call-template name="GetEntityIds">
							<xsl:with-param name="Ids" select="$OfficerUnitIds" />
							<xsl:with-param name="EntityNumber">1410</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>



						<xsl:variable name="TaskPersonIds">
							<xsl:call-template name="GetEntityIds">
								<xsl:with-param name="Ids" select="$TaskAssignedTo" />
								<xsl:with-param name="EntityNumber">1500</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="TaskOrgUnitIds">
							<xsl:call-template name="GetEntityIds">
								<xsl:with-param name="Ids" select="$TaskAssignedTo" />
								<xsl:with-param name="EntityNumber">1410</xsl:with-param>
							</xsl:call-template>
						</xsl:variable>

					<xsl:variable name="OccWhereClause">
						WHERE OCC.ACCDomain = '<xsl:value-of select="$ACCDomain" />'
						<xsl:if test="$TimeRange = 'L12'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-12h'</xsl:if>
						<xsl:if test="$TimeRange = 'L24'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-1d'</xsl:if>
						<xsl:if test="$TimeRange = 'L3D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-3d'</xsl:if>
						<xsl:if test="$TimeRange = 'L4D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-4d'</xsl:if>
						<xsl:if test="$TimeRange = 'L7D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-7d'</xsl:if>
						<xsl:if test="$TimeRange = 'L30D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-30d'</xsl:if>
						<xsl:if test="$TimeRange = 'RNG'"> AND OCC.ReportedTimeTZV2I = '[<xsl:value-of select="$StartTime" />, <xsl:value-of select="$EndTime" />]'</xsl:if>

							<xsl:if test="$UnitCode">
							AND (
								EXISTS (
									SELECT ID FROM GOccInvGPerson WHERE EXISTS (
										SELECT Id FROM OrgPoliceUnit
										WHERE <xsl:call-template name="MultiValueField">
												<xsl:with-param name="FormField"><xsl:value-of select="$UnitCode" /></xsl:with-param>
												<xsl:with-param name="DBField">EmployeeNumber</xsl:with-param>
											</xsl:call-template>
											AND AutoLink('GOccInvGPerson','OrgPoliceUnit')=1
									) AND AutoLink('Goccurrence', 'GOccInvGPerson')=1
								)
							)
						</xsl:if>

							<xsl:if test="$PersonIds !='' or $OrgUnitIds != ''">
								AND(
								<xsl:call-template name="ComposeWith">
									<xsl:with-param name = "Separator"> OR </xsl:with-param>
									<xsl:with-param name = "Strings">
										<String>
											<xsl:if test="$PersonIds != ''">
												EXISTS(
													SELECT Id FROM GOccInvGPerson offIv
													WHERE LId = OCC.Id
														AND offIv.RId IN (<xsl:value-of select="$PersonIds" />)
														AND NOT EXISTS( SELECT Id FROM GOccInvGPerson
															WHERE LId = OCC.Id
																AND Id &lt;&gt; offIv.Id
																AND CreTimeTZV2I &gt; offIv.CreTimeTZV2I
														)
												)

											</xsl:if>
										</String>
										<String>
											<xsl:if test="$OrgUnitIds != ''">
												EXISTS(
													SELECT Id FROM GOccInvGPerson offIv
														WHERE LId = OCC.Id
														AND NOT EXISTS(SELECT Id FROM GOccInvGPerson
															WHERE LId = OCC.Id
																AND Id &lt;&gt; offIv.Id
																AND CreTimeTZV2I &gt; offIv.CreTimeTZV2I
														)
														AND EXISTS(
															SELECT Id FROM GPersonOrgMemberGPerson
															WHERE IsEffectiveAssignment = 1
																AND RId = offIv.RId
																AND LId IN (<xsl:value-of select =
																	                            "$OrgUnitIds" />)
														)
												)
											</xsl:if>
										</String>
									</xsl:with-param>
								</xsl:call-template>
								)
							</xsl:if>


						<xsl:if test="$AreaLevel5">
							AND <xsl:call-template name="MultiValueField">
								<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel5" /></xsl:with-param>
								<xsl:with-param name="DBField">OCC.ESAreaLevel5</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="$AreaLevel3">
							<xsl:choose>
								<xsl:when test="$UnitCode">
									AND EXISTS (SELECT GOccIvPA.ID
										FROM GOccIvPA LEFT JOIN PhysicalAddress
										WHERE (GOccIvPA.Classification like '%DAD%' OR GOccIvPA.Classification like '%OLC%')
											AND EXISTS (
												SELECT PhysicalAddress.Id
												FROM PhysicalAddress
												WHERE <xsl:call-template name="MultiValueField">
														<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel3" /></xsl:with-param>
														<xsl:with-param name="DBField">PhysicalAddress.ESAreaLevel3</xsl:with-param>
													</xsl:call-template>
													AND AutoLink('GOccIvPA', 'PhysicalAddress')=1
											)
											AND AutoLink('GOccurrence','GOccIvPA')=1
									)
								</xsl:when>
								<xsl:otherwise>
									AND <xsl:call-template name="MultiValueField">
										<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel3" /></xsl:with-param>
										<xsl:with-param name="DBField">OCC.ESAreaLevel3</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>

						<xsl:if test="$ReportableOnly = '1'">
							AND o2.Reportable = 1
						</xsl:if>

						<xsl:if test="$DispatchOnly = '1'">
							AND o2.dispatchocctypeg IS NOT NULL
						</xsl:if>
							<xsl:if test="$OccurrenceTypeRId">
							AND o2.OccurrenceStdOccTypeRId = <xsl:call-template name="StuffSQL"><xsl:with-param name="ToStuff" select="$OccurrenceTypeRId" /></xsl:call-template>
						</xsl:if>


						<xsl:if test = "$OccurrenceClassification != ''">
							AND
							<xsl:call-template name = "CreateConditionFromSet">
								<xsl:with-param name = "FieldName">o2.Classification
								</xsl:with-param>
								<xsl:with-param name = "FieldValue"
								                select = "$OccurrenceClassification"/>
								<xsl:with-param name = "IsSetField">1</xsl:with-param>
							</xsl:call-template>
					</xsl:if>

					<xsl:if test="$ClearanceStatus != ''">
							AND
								<xsl:call-template name="CreateConditionFromSet">
									<xsl:with-param name="FieldName">Occurrence.UCRClearanceStatus</xsl:with-param>
									<xsl:with-param name="FieldValue" select="$ClearanceStatus" />
								</xsl:call-template>
					</xsl:if>

					<!--<xsl:if test="$TaskType != '' or $TaskStatus != ''">-->
					<!--AND (-->
					<!--	<xsl:call-template name="ComposeWith">-->
					<!--		<xsl:with-param name="Separator"> OR </xsl:with-param>-->
					<!--		<xsl:with-param name="Strings">-->
					<!--			<String>-->
					<!--			<xsl:if test="$TaskType != ''">-->
					<!--				EXISTS (-->
					<!--					SELECT Task.Id-->
					<!--						FROM TaskSubjectGOccurrence-->
					<!--							LEFT JOIN GTask Task-->
					<!--						WHERE TaskSubjectGOccurrence.RId = OCC.Id-->
					<!--							AND (<xsl:call-template name="CreateConditionFromSet">-->
					<!--								<xsl:with-param name="FieldName">Task.Type1</xsl:with-param>-->
					<!--								<xsl:with-param name="FieldValue" select="$TaskType" />-->
					<!--							</xsl:call-template>)-->
					<!--								<xsl:if test="$TaskStatus != ''">-->
					<!--					AND (<xsl:call-template name="CreateConditionFromSet">-->
					<!--						<xsl:with-param name="FieldName">Task.Status</xsl:with-param>-->
					<!--						<xsl:with-param name="FieldValue" select="$TaskStatus" />-->
					<!--					</xsl:call-template>)-->
					<!--					</xsl:if>-->
					<!--					)-->
					<!--						</xsl:if>-->
					<!--			</String>-->
					<!--			<String>-->
					<!--				<xsl:if test="$TaskStatus != ''">-->
					<!--				EXISTS (-->
					<!--					SELECT Task.Id-->
					<!--					FROM TaskSubjectGOccurrence-->
					<!--						LEFT JOIN GTask Task-->
					<!--					WHERE TaskSubjectGOccurrence.RId = OCC.Id-->
					<!--					AND (<xsl:call-template name="CreateConditionFromSet">-->
					<!--						<xsl:with-param name="FieldName">Task.Status</xsl:with-param>-->
					<!--						<xsl:with-param name="FieldValue" select="$TaskStatus" />-->
					<!--					</xsl:call-template>)-->
					<!--				)-->
					<!--				</xsl:if>-->
					<!--			</String>-->
					<!--		</xsl:with-param>-->
					<!--	</xsl:call-template>-->
					<!--	)-->
					<!--	</xsl:if>-->

							<xsl:if test="$TaskPersonIds !='' or $TaskOrgUnitIds != ''">
								AND(
								<xsl:call-template name="ComposeWith">
									<xsl:with-param name = "Separator"> OR </xsl:with-param>
									<xsl:with-param name = "Strings">
										<String>
											<xsl:if test="$TaskPersonIds != ''">
												EXISTS(
													SELECT GTask.Id FROM TaskSubjectGOccurrence
														LEFT JOIN (GTask Task
															LEFT JOIN TaskAssignedTo TaskInvolvement ON TaskInvolvement.LId = Task.Id)
															WHERE TaskSubjectGOccurrence.RId = Occ.Id
															AND TaskInvolvement.RId IN (<xsl:value-of select="$TaskPersonIds" />)


													<xsl:if test="$TaskType != ''">
													AND EXISTS (
														SELECT Task.Id
														FROM GTask Task
															LEFT JOIN TaskSubjectGOccurrence
															WHERE TaskSubjectGOccurrence.RId = OCC.Id
															AND (<xsl:call-template name="CreateConditionFromSet">
															<xsl:with-param name="FieldName">Task.Type1</xsl:with-param>
															<xsl:with-param name="FieldValue" select="$TaskType" />
															</xsl:call-template>)
															<xsl:if test="$TaskStatus != ''">
																AND (<xsl:call-template name="CreateConditionFromSet">
																	<xsl:with-param name="FieldName">Task.Status</xsl:with-param>
																	<xsl:with-param name="FieldValue" select="$TaskStatus" />
																	</xsl:call-template>)
															</xsl:if>
																AND NOT (ChoiceHasProperty(GTask.Status, 'cl_TaskStatus', 'clvIsCancelled', '1') = 1)
														)
														</xsl:if>
												)
											</xsl:if>
										</String>
										<String>
											<xsl:if test="$TaskOrgUnitIds != ''">
												EXISTS(
													SELECT GTask.Id FROM TaskSubjectGOccurrence
														LEFT JOIN (GTask Task
															LEFT JOIN TaskAssignedTo TaskInvolvement ON TaskInvolvement.LId = Task.Id)
														WHERE TaskSubjectGOccurrence.RId = Occ.Id
														<!--Checks the cases assigned to Unit (ie. General Investigations, Violent Crimes)-->

														AND TaskInvolvement.RId IN (<xsl:value-of select="$TaskOrgUnitIds" />)
														<!--Searches Tasks assigned to Individuals assigned to selected Unit -->
														<xsl:if test="$TaskType != ''">
														AND (<xsl:call-template name="CreateConditionFromSet">
															<xsl:with-param name="FieldName">Task.Type1</xsl:with-param>
															<xsl:with-param name="FieldValue" select="$TaskType" />
														</xsl:call-template>)
														</xsl:if>
														<xsl:if test="$TaskStatus != ''">
														AND (<xsl:call-template name="CreateConditionFromSet">
															<xsl:with-param name="FieldName">Task.Status</xsl:with-param>
															<xsl:with-param name="FieldValue" select="$TaskStatus" />
														</xsl:call-template>)
														</xsl:if>
														<!--Searches all assigned officers to the selected Unit-->
														AND EXISTS(
															SELECT Id FROM GPersonOrgMemberGPerson
															WHERE IsEffectiveAssignment = 1
																AND RId = TaskInvolvement.RId
																AND LId IN (<xsl:value-of select =
																                            "$TaskOrgUnitIds" />)
														)
													)
											</xsl:if>
										</String>
									</xsl:with-param>
								</xsl:call-template>
								)
							</xsl:if>

					</xsl:variable>

					<xsl:variable name="SCWhereClause">
						WHERE OCC.ACCDomain = '<xsl:value-of select="$ACCDomain" />'
						<xsl:if test="$TimeRange = 'L12'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-12h'</xsl:if>
						<xsl:if test="$TimeRange = 'L24'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-1d'</xsl:if>
						<xsl:if test="$TimeRange = 'L3D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-3d'</xsl:if>
						<xsl:if test="$TimeRange = 'L4D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-4d'</xsl:if>
						<xsl:if test="$TimeRange = 'L7D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-7d'</xsl:if>
						<xsl:if test="$TimeRange = 'L30D'"> AND OCC.ReportedTimeTZV2I &gt; 'nowNoOffset-30d'</xsl:if>
						<xsl:if test="$TimeRange = 'RNG'"> AND OCC.ReportedTimeTZV2I = '[<xsl:value-of select="$StartTime" />, <xsl:value-of select="$EndTime" />]'</xsl:if>

						<xsl:if test="$UnitCode">
							AND (
								EXISTS (
									SELECT ID FROM GOccInvGPerson WHERE EXISTS (
										SELECT Id FROM Person
										WHERE <xsl:call-template name="MultiValueField">
												<xsl:with-param name="FormField"><xsl:value-of select="$UnitCode" /></xsl:with-param>
												<xsl:with-param name="DBField">EmployeeNumber</xsl:with-param>
											</xsl:call-template>
											AND AutoLink('GOccInvGPerson','Person')=1
									) AND AutoLink('Goccurrence', 'GOccInvGPerson')=1
								)
							)
						</xsl:if>

						<xsl:if test="$AreaLevel5">
							AND <xsl:call-template name="MultiValueField">
								<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel5" /></xsl:with-param>
								<xsl:with-param name="DBField">OCC.ESAreaLevel5</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="$AreaLevel3">
							<xsl:choose>
								<xsl:when test="$UnitCode">
									AND EXISTS (SELECT GOccIvPA.ID
										FROM GOccIvPA LEFT JOIN PhysicalAddress
										WHERE (GOccIvPA.Classification like '%DAD%' OR GOccIvPA.Classification like '%OLC%')
											AND EXISTS (
												SELECT PhysicalAddress.Id
												FROM PhysicalAddress
												WHERE <xsl:call-template name="MultiValueField">
														<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel3" /></xsl:with-param>
														<xsl:with-param name="DBField">PhysicalAddress.ESAreaLevel3</xsl:with-param>
													</xsl:call-template>
													AND AutoLink('GOccIvPA', 'PhysicalAddress')=1
											)
											AND AutoLink('GOccurrence','GOccIvPA')=1
									)
								</xsl:when>
								<xsl:otherwise>
									AND <xsl:call-template name="MultiValueField">
										<xsl:with-param name="FormField"><xsl:value-of select="$AreaLevel3" /></xsl:with-param>
										<xsl:with-param name="DBField">OCC.ESAreaLevel3</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						AND IsSpecialization(OCC.Id, "SCOccurrence") = 1
					</xsl:variable>

					<xsl:variable name="PlatoonSearch">
						OR EXISTS (
							SELECT ID FROM GOccInvGPerson WHERE EXISTS (
								SELECT GPerson.Id
								FROM GPerson LEFT JOIN (GPersonOrgMemberGPerson LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId) ON GPersonOrgMemberGPerson.RId = GPerson.Id
								WHERE <xsl:call-template name="MultiValueField">
										<xsl:with-param name="FormField"><xsl:value-of select="$UnitCode" /></xsl:with-param>
										<xsl:with-param name="DBField">OrgPoliceUnit.EmployeeNumber</xsl:with-param>
									</xsl:call-template>
									AND GPersonOrgMemberGPerson.AssignmentTypeG = 'Primary' AND GPersonOrgMemberGPerson.EffectiveToTime IS NULL
									AND AutoLink('GOccInvGPerson','GPerson')=1
							) AND AutoLink('Goccurrence', 'GOccInvGPerson')=1
						)
					</xsl:variable>

				<!--Incidents-->
                    SELECT OCC.id AS OccId, OCC.OccurrenceFileNo AS OccNo, OCC.reportedtimetzv2g AS ReportedTime, o2.dispatchocctypeg AS DispType,
                     OCC.OccurrenceType AS OccType, o2.ClassificationG AS OccClass, OCC.UCRClearanceStatusG AS Status, OCC.SummaryOneLine as OccSummary, o2.OccurrenceStdOccTypeRId,
                     Occ.ESAreaLevel3 as DutyLoc,
                     <!--Task__Id, Task__TaskNumber, Task__StatusG, Task__Type1G, Task__TaskAssignedToRId_L-->
                     <!-- Task__Id__0 AS Task__Id, Task__TaskNumber__0 AS Task__TaskNumber, Task__StatusG__0 AS Task__StatusG, Task__Type1G__0 AS Task__Type1G, Task__TaskAssignedToRId__0 AS Task__TaskAssignedToRId, Task__TaskAssignedToRId_L__0 AS Task__TaskAssignedToRId_L-->
                      Task__Id, Task__TaskNumber, Task__StatusG, Task__Type1G,  Task__TaskAssignedToRId,  Task__TaskAssignedToRId_L

					FROM GOccurrence OCC
						<!-- Tasks (subject of) -->
							LEFT JOIN (TaskSubjectGOccurrence
								LEFT JOIN (GTask Task
									LEFT JOIN TaskAssignedTo)
							) ON Task.Id = TaskSubjectGOccurrence.LId
								<xsl:if test="string-length($TaskType) &gt; 0">
								AND (<xsl:call-template name="CreateConditionFromSet">
									<xsl:with-param name="FieldName">Task.Type1</xsl:with-param>
									<xsl:with-param name="FieldValue" select="$TaskType" />
								</xsl:call-template>)
								</xsl:if>
									<xsl:if test="string-length($TaskStatus) &gt; 0">
								AND (<xsl:call-template name="CreateConditionFromSet">
									<xsl:with-param name="FieldName">Task.Status</xsl:with-param>
									<xsl:with-param name="FieldValue" select="$TaskStatus" />
								</xsl:call-template>)
								</xsl:if>
						LEFT JOIN Occurrence o2
					<xsl:value-of select="$OccWhereClause" />
						AND HierarchicalResult = 1
					ORDER BY OCC.reportedtimetzv2g ASC, OCC.ID ASC



					SELECT OCC__Id AS OccTask__Id, Task__Id AS TaskId, Task__TaskAssignedToRId_L AS TaskAssignedToRId_L, Task__TaskAssignedToRId AS TaskAssignedToRId,  OrgPoliceUnit__Id__0
					FROM TaskSubjectGOccurrence
						LEFT JOIN (GTask Task
								LEFT JOIN (TaskAssignedTo
										LEFT JOIN (Person Officer
										LEFT JOIN (GPersonOrgMemberGPerson
										LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId)
										ON GPersonOrgMemberGPerson.RId = Officer.Id
										AND GPersonOrgMemberGPerson.IsEffectiveAssignment = 1) ON Officer.Id = TaskAssignedTo.RId
								) ON TaskAssignedTo.LId = Task.Id
							)ON Task.Id = TaskSubjectGOccurrence.LId
								<xsl:if test="string-length($TaskType) &gt; 0">
								AND (<xsl:call-template name="CreateConditionFromSet">
									<xsl:with-param name="FieldName">Task.Type1</xsl:with-param>
									<xsl:with-param name="FieldValue" select="$TaskType" />
								</xsl:call-template>)
								</xsl:if>
									<xsl:if test="string-length($TaskStatus) &gt; 0">
								AND (<xsl:call-template name="CreateConditionFromSet">
									<xsl:with-param name="FieldName">Task.Status</xsl:with-param>
									<xsl:with-param name="FieldValue" select="$TaskStatus" />
								</xsl:call-template>)
								</xsl:if>
						LEFT JOIN (GOccurrence OCC
							LEFT JOIN Occurrence o2)
					<xsl:value-of select="$OccWhereClause" />
						<!--AND HierarchicalResult = 1-->

					SELECT OCC.id AS OccRPOId, officer.label AS RPO_Officer, OrgPoliceUnit.Id__0, OrgPoliceUnit__LabelEmpl__0
					FROM GOccurrence OCC
						LEFT JOIN Occurrence o2
						LEFT JOIN (GOccInvGPerson offIv
							LEFT JOIN (GPerson offi
								LEFT JOIN (Person Officer
									LEFT JOIN (GPersonOrgMemberGPerson
										LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId
										) ON GPersonOrgMemberGPerson.RId = Officer.Id
										AND GPersonOrgMemberGPerson.IsEffectiveAssignment = 1
									)
								)
							)
					<xsl:value-of select="$OccWhereClause" />
						AND offIv.Classification LIKE '%RPO%'
						AND NOT EXISTS (
						  SELECT Id FROM OrgPoliceUnit opu WHERE opu.Assignable = 1 AND AutoLink('offi', 'OrgPoliceUnit') = 1
						)
					ORDER BY OCC.ID ASC, offIv.CreTimeTZV2I

					SELECT OCC.id AS OccINVId, offi.label AS INV_Officer
					FROM GOccurrence OCC
						LEFT JOIN Occurrence o2
						LEFT JOIN (GOccInvGPerson offIv
							LEFT JOIN (GPerson offi
								LEFT JOIN (Person Officer
									LEFT JOIN (GPersonOrgMemberGPerson
										LEFT JOIN OrgPoliceUnit ON OrgPoliceUnit.Id = GPersonOrgMemberGPerson.LId
										) ON GPersonOrgMemberGPerson.RId = Officer.Id
										AND GPersonOrgMemberGPerson.IsEffectiveAssignment = 1
									)
								)
							)
					<xsl:value-of select="$OccWhereClause" />
						AND offIv.Classification LIKE '%INV%'
						AND NOT EXISTS (
							SELECT Id FROM OrgPoliceUnit opu WHERE opu.Assignable = 1 AND AutoLink('offi', 'OrgPoliceUnit') = 1
						)
					ORDER BY OCC.ID ASC, offIv.cretime

					SELECT OCC.id AS OccDRUId, opu.EmployeeNumber AS DRU_Officer
					FROM GOccurrence OCC
						LEFT JOIN Occurrence o2
						LEFT JOIN (GOccInvGPerson offIv
							LEFT JOIN (GPerson offi LEFT JOIN OrgPoliceUnit opu))
					<xsl:value-of select="$OccWhereClause" />
						AND (offIv.Classification LIKE '%RPO%' OR offIv.Classification LIKE '%DOF%' OR offIv.Classification LIKE '%RPU%')
						AND opu.Assignable = 1
					ORDER BY OCC.ID ASC, offIv.cretime, offi.cretime


					-- Highlight Bolo Occurrences
					<xsl:if test="$HighlightBolo = 1">
						SELECT OCC.id AS BoloOccId, ocf.Type1G
						FROM GOccurrence OCC
							LEFT JOIN Occurrence o2
							LEFT JOIN GOccurrenceFlag ocf
						<xsl:value-of select="$OccWhereClause" />
							AND ocf.Type1 = 'MAJ' AND (ocf.FlagTimeTZV2I > 'NowNoOffset' OR ocf.FlagTime IS NULL)
						ORDER BY OCC.reportedtime ASC, o2.ID ASC
					</xsl:if>

					-- Highlight Occurrences WIthout / Missing UCR
					<xsl:if test="$HighlightMissingUCR = 1">
						SELECT OCC.id AS UCRoOccId
						FROM GOccurrence OCC
							LEFT JOIN (Occurrence o2)
						<xsl:value-of select="$OccWhereClause" />
							AND NOT EXISTS (SELECT Id FROM UCRIncident WHERE WId = o2.id)
						ORDER BY OCC.reportedtime ASC, o2.ID ASC
					</xsl:if>

					-- Street check Queries
					<xsl:if test="$ReportableOnly = '0' and $DispatchOnly = '0'">
						SELECT OCC.id AS SCOccId, "StreetCheck" SCDispType, sc.Type1G AS SCOccType
						FROM GOccurrence OCC
							LEFT JOIN SCOccurrence sc
						<xsl:value-of select="$SCWhereClause" />
						ORDER BY OCC.reportedtime ASC, OCC.ID ASC
					</xsl:if>

					<xsl:if test="$IncludeMapping = '1'">
						-- Get Mapping Address Information
						--SELECT o.id, o.OccurrenceFileNo AS OccurrenceFileNo, o.ReportedTimeTZV2G AS ReportedTime, o.ESAreaLevel3 AS DutyLoc, o.ESAreaLevel5 AS Area, o.ESAreaLevel1 AS ESZ, o.ESAreaLevel5 AS Beat, pa.StreetNameG AS StrNoSuffix, pa.CivicSiteStreetNumberG AS StrNum, pa.StreetTypeG AS StrType, pa.StreetDirection AS StrDir, pa.MunicipalityNameG AS Muni, ui.MostSeriousViolationMerged, ui.SecondViolationMerged, ui.ThirdViolationMerged, ui.FourthViolationMerged, pa.XCoordinateG as X, pa.YCoordinateG AS Y, oip.NLXCoordinate AS NLX, oip.NLYCoordinate AS NLY, '' AS LambertX, '' AS LambertY, oip.NLAddressG AS NLStrNoSuffix, oip.NLCivicSiteStreetNumberG AS NLStrNum, oip.NLStreetTypeG AS NLStrType, oip.NLStreetDirection AS NLStrDir, oip.NLMunicipalityNameG AS NLMuni, oip.NLCommonName AS NLCommonName, pa.ManuallyVerified, pa.CompassKey
						SELECT o.id AS mapOccID, o.OccurrenceFileNo AS mapOccurrenceFileNo, o.ReportedTimeTZV2G AS mapReportedTime, pa.StreetNameG AS mapStrNoSuffix, pa.CivicSiteStreetNumberG AS mapStrNum, pa.StreetTypeG AS mapStrType, pa.StreetDirection AS mapStrDir, pa.MunicipalityNameG AS mapMuni, ui.MostSeriousViolationMerged AS mapMostSerious, pa.XCoordinateG as mapX, pa.YCoordinateG AS mapY, pa.ManuallyVerified AS mapManuallyVerified, pa.CompassKey AS mapCompassKey
						FROM Occurrence o LEFT JOIN UCRIncident ui LEFT JOIN (GOccIvPA oip LEFT JOIN PhysicalAddress pa)
						WHERE oip.Classification LIKE '%OLC%'
						AND EXISTS (
							SELECT OCC.id
							FROM GOccurrence OCC LEFT JOIN Occurrence o2
							<xsl:value-of select="$OccWhereClause" />
							AND Occ.Id = o.id
						)
						ORDER BY o.ReportedTime, oip.id
					</xsl:if>

					SELECT
						GUIValue,
						DBValue
						FROM ChoiceListReport
						WHERE ChoiceList='cl_TaskStatus'

					select SPValue as AgencyName from SystemParameterSettingForACC where SPKey='Label.AgencyName'
					select SPValue as DivisionName from SystemParameterSettingForACC where SPKey='Label.DivisionName'
					select Label as CurrentUser from GPerson where id=@currentUserId
					exec pr_getnow '%B %d, %Y at %H:%M', 'CurrentTime'

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

				<xsl:template name="StuffSQL">
					<xsl:param name="ToStuff" />
					<xsl:text>'</xsl:text><xsl:call-template name='StuffSQLPart'><xsl:with-param name="ToStuff"><xsl:value-of select="$ToStuff" /></xsl:with-param></xsl:call-template><xsl:text>'</xsl:text>
				</xsl:template>

				<xsl:template name="StuffSQLPart">
					<xsl:param name="ToStuff" />
					<xsl:variable name="SingleQuote">'</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains($ToStuff, $SingleQuote)"><xsl:value-of select="substring-before($ToStuff, $SingleQuote)" />''<xsl:call-template name="StuffSQLPart"><xsl:with-param name="ToStuff"><xsl:value-of select="substring-after($ToStuff, $SingleQuote)" /></xsl:with-param></xsl:call-template></xsl:when>
						<xsl:otherwise><xsl:value-of select="$ToStuff" /></xsl:otherwise>
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

					<xsl:template name="GetEntityIds">
					<xsl:param name="Ids" />
					<xsl:param name="EntityNumber" />
					<xsl:param name="FirstInList">1</xsl:param>

					<xsl:variable name="TrimmedIds" select="translate(normalize-space(translate($Ids, '&#xD;&#xA;', ';;')), ' ', '')" />

					<xsl:if test="string-length($TrimmedIds) &gt; 0">
						<xsl:variable name="sep" select="';'" />
						<xsl:choose>
							<xsl:when test="contains($TrimmedIds, $sep)">
								<xsl:variable name="id1" select="substring-before($TrimmedIds, $sep)" />
								<xsl:variable name="remainingIds" select="substring-after($TrimmedIds, $sep)" />
								<!--
									The ID is of the form 'XXXXXYYYYYZZZZZZZZZZZZZZZ' (including quotes), where XXXXX is the
									entity number, and is of variable length.  We start at the 2nd character (because of the quote),
									and determine how many more characters to read based on the total length of the string.
									We subtract 2 for the quotes, and 20 for YYYYYZZZZZZZZZZZZZZZ, leaving us with the position of
									the last character of XXXXX.  So the call to substring() below converts 'XXXXXYYYYYZZZZZZZZZZZZZZZ'
									into XXXXX.

									This prevents us from accidentally identifying an Id for entity 15000 as a Person Id.
								-->
								<xsl:variable name="EntityNumberForThisId" select="substring($id1, 1, string-length($id1) - 20)" />

								<xsl:if test="$EntityNumberForThisId = $EntityNumber">
									<xsl:if test="$FirstInList != 1"><xsl:text>,</xsl:text></xsl:if>
									<xsl:call-template name="StuffSQL">
										<xsl:with-param name="ToStuff" select="normalize-space($id1)" />
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="string-length($remainingIds) &gt; 0">
									<!-- Make the recursive call -->
									<xsl:call-template name="GetEntityIds">
										<xsl:with-param name="Ids" select="$remainingIds" />
										<xsl:with-param name="EntityNumber" select="$EntityNumber" />
										<xsl:with-param name="FirstInList">
											<xsl:choose>
												<xsl:when test="$EntityNumberForThisId = $EntityNumber or $FirstInList = '0'">0</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<!-- There is only one Id so output it. -->
								<xsl:variable name="EntityNumberForThisId" select="substring($TrimmedIds, 1, string-length($TrimmedIds) - 20)" />
								<xsl:if test="$EntityNumberForThisId = $EntityNumber">
									<xsl:if test="$FirstInList != 1"><xsl:text>,</xsl:text></xsl:if>
									<xsl:call-template name="StuffSQL">
										<xsl:with-param name="ToStuff" select="$TrimmedIds" />
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
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
			</xsl:stylesheet>



	]]></SQLSelectXSLT>
	<ReportXSL>
		<![CDATA[<?xml version="1.0" encoding="utf-8" ?>
			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nicheFunctions="urn:nicheFunctions" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
				<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
				<xsl:param name="TimeRange" />
				<xsl:param name="StartTimeG" />
				<xsl:param name="EndTimeG" />
				<xsl:param name="AreaLevel5" />
				<xsl:param name="AreaLevel3" />
				<xsl:param name="OfficerUnitIds" />
				<xsl:param name="UnitCode" />
				<xsl:param name="ReportableOnly" />
				<xsl:param name="DispatchOnly" />
				<xsl:param name="AdditionalInfo" />
				<xsl:param name="HighlightBolo" />
				<xsl:param name="HighlightMissingUCR" />
				<xsl:param name="IncludeMapping" />
				<xsl:param name="OccurrenceTypeRId" />
				<xsl:param name="OccurrenceClassification" />
				<xsl:param name="TaskAssignedTo" />
				<xsl:param name="TaskTypeG" />
				<xsl:param name="TaskStatusG" />

				<xsl:key name="Officer" match= "/DATASETLIST/DATASET/ROW[OccId]/DATASET[@entity='TASK']/ROW/Task__TaskAssignedToRId" use = "." />
				<xsl:template match="/">
					<HTML>
						<xsl:variable name="ReportTitle">Daily Summary Report</xsl:variable>
						<xsl:element name="title"><xsl:value-of select="$ReportTitle" /></xsl:element>

						<!-- Insert the JavaScript Files -->
						<xsl:call-template name="loadJavaScriptFiles" />

						<!-- Insert the CSS Files that go with the JavaScripts-->
						<xsl:call-template name="loadCSSFiles" />

						<!-- Insert the style class declarations -->
						<xsl:call-template name="StyleClasses" />
						<!--<xsl:variable name="TotalTask"> <xsl:value-of select="count(/DATASETLIST/DATASET[Task]/ROW/DATASET/ROW/[Task__Id])" /> </xsl:variable>-->
						<xsl:variable name="TotalCount"> <xsl:value-of select="count(/DATASETLIST/DATASET/ROW[OccId])"/> </xsl:variable>

						<script type="text/javascript" charset="utf-8">
							var oTable;
							var summaryList = new Array(<xsl:value-of select="$TotalCount" />);
							var occList = new Array(<xsl:value-of select="$TotalCount" />);

								function fnFormatDetails ( nTr )
							{
								var aData = oTable.fnGetData( nTr );
								var sOut = "";
								var i;
								for (i in occList) {
									if (occList[i] == aData[1].substring(64, 76)) { sOut = '<tr style="font-size: 10px;"><td>'+summaryList[i]+'</td></tr>'; break; }
								}
								return sOut;
							}

							$(document).ready(function() {
								/*
								* Insert a 'details' column to the table
								*/
								<xsl:for-each select="/DATASETLIST/DATASET/ROW[OccId]">
									<xsl:variable name="summary">
										<xsl:call-template name="StringReplaceQuotation">
											<xsl:with-param name="text" select="OccSummary" />
										</xsl:call-template>
									</xsl:variable>
									summaryList[<xsl:value-of select="position()"/>] = "<xsl:value-of select='$summary' />";
									occList[<xsl:value-of select="position()"/>] = "<xsl:value-of select='OccNo' />"
								</xsl:for-each>

								var nCloneTh = document.createElement( 'th' );
								var nCloneTd = document.createElement( 'td' );
								nCloneTd.innerHTML = '<img src="C:\Users\jm33149\Desktop\BCS_XSLT\icons\doubledownarrow.gif" alt="" />';
								nCloneTd.className = "noprint";
								nCloneTh.className = "noprint";
								nCloneTd.setAttribute('style', 'text-align: center; width: 20px;');
								var alreadyExists = false;

								$('#dailySummary tbody tr').each( function () {

									if (((this.childNodes[0].innerHTML).match('doubledownarrow')) || ((this.childNodes[0].innerHTML).match('doubleuparrow'))) {
										alreadyExists = true;
									}
									else {
										this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
									}
								} );

								$('#dailySummary thead tr').each( function () {
									if (!alreadyExists) {
										this.insertBefore( nCloneTh, this.childNodes[0] );
									}
								} );

								/*
								* Initialse DataTables, with no sorting on the 'details' column
								*/
								oTable = $('#dailySummary').dataTable( {
									"aoColumns": [
										{ "bSortable": false },
										null, null, null, null, null, null, null,  null, null, null, null
									],
									"aaSorting": [[3, 'asc']],
									"bPaginate": false,
									"bsortClasses": false
								});

								$('td img', oTable.fnGetNodes() ).each( function () {
									$(this).click( function () {
										var nTr = this.parentNode.parentNode;

										if ( this.src.match('doubleuparrow') )
										{
											this.src = "C:\Users\jm33149\Desktop\BCS_XSLT\icons\doubledownarrow.gif";
											oTable.fnClose( nTr );

										}
										else
										{
											this.src = "C:\Users\jm33149\Desktop\BCS_XSLT\icons\doubleuparrow.gif";
											oTable.fnOpen( nTr, fnFormatDetails(nTr), 'details' );
										}
									} );
								} );
							} );
						</script>

						<xsl:element name="BODY">
							<!-- Insert the title-->
							<xsl:call-template name="Title">
								<xsl:with-param name="Text" select="$ReportTitle" />
							</xsl:call-template>
							<xsl:variable name="strTimeFrame">
								<xsl:choose>
									<xsl:when test="$TimeRange = 'L12'">Last 12 hours</xsl:when>
									<xsl:when test="$TimeRange = 'L24'">Last 24 hours</xsl:when>
									<xsl:when test="$TimeRange = 'L3D'">Last 3 days</xsl:when>
									<xsl:when test="$TimeRange = 'L4D'">Last 4 days</xsl:when>
									<xsl:when test="$TimeRange = 'L7D'">Last 7 days</xsl:when>
									<xsl:when test="$TimeRange = 'L30D'">Last 30 days</xsl:when>
									<xsl:when test="$TimeRange = 'RNG'">Period from <xsl:value-of select="$StartTimeG" /> to <xsl:value-of select="$EndTimeG" /></xsl:when>
								</xsl:choose>
							</xsl:variable>

							<!-- Insert the info box -->
							<xsl:call-template name="InfoBox">
								<xsl:with-param name="SpecDesc1"><xsl:value-of select="$strTimeFrame" /></xsl:with-param>
								<xsl:with-param name="SpecDesc2"><xsl:if test="$AreaLevel5">Sector: <xsl:value-of select="$AreaLevel5" /></xsl:if></xsl:with-param>
								<xsl:with-param name="SpecDesc3"><xsl:if test="$AreaLevel3">Duty Location: <xsl:value-of select="$AreaLevel3" /></xsl:if></xsl:with-param>
								<xsl:with-param name="SpecDesc4"><xsl:if test="$UnitCode">Unit Code: <xsl:value-of select="$UnitCode" /></xsl:if></xsl:with-param>
								<xsl:with-param name="SpecDesc5"><xsl:if test="$ReportableOnly = '1'">Only show reportables</xsl:if></xsl:with-param>
								<xsl:with-param name="SpecDesc6"><xsl:if test="$DispatchOnly = '1'">Only show dispatched calls</xsl:if></xsl:with-param>
								<xsl:with-param name="SpecDesc7">Searched By: <xsl:choose>
								<xsl:when test="$TaskTypeG != '' and $TaskStatusG != '' "><xsl:value-of select="$TaskStatusG" />, <xsl:value-of select="$TaskTypeG" /> </xsl:when>
								 <xsl:otherwise>
								    <xsl:value-of select="$TaskTypeG" />
								 </xsl:otherwise></xsl:choose></xsl:with-param>
							</xsl:call-template>
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
													select = "/DATASETLIST/DATASET/ROW[OccId]/DATASET[@entity='TASK']/ROW[Task__TaskNumber][generate-id(Task__TaskAssignedToRId) = generate-id(key('Officer', Task__TaskAssignedToRId)[1])]">
													<xsl:variable name = "OfficerId" select = "Task__TaskAssignedToRId" />
											<TR>
												<TD>
														<A href = "#{Task__TaskAssignedToRId}">
															<xsl:value-of select = "Task__TaskAssignedToRId_L" />
														</A>
													</TD>
												<TD class = "total count"><xsl:value-of
															select = "count(/DATASETLIST/DATASET/ROW[OccId]/DATASET[@entity='TASK']/ROW[Task__TaskAssignedToRId = $OfficerId])" />
													</TD>
													<xsl:for-each select = "/DATASETLIST/DATASET/ROW[DBValue]">
														<TD class = "count"><xsl:value-of
																select = "count(/DATASETLIST/DATASET/ROW[OccId]/DATASET[@entity='TASK']/ROW[Task__TaskAssignedToRId = $OfficerId][Task__StatusG = current()/GUIValue])" /></TD>
													</xsl:for-each>
											</TR>
											</xsl:for-each>

										<TR>
											<TD class = "totalrow">Total:</TD>
											<TD class = "totalrow total count"><xsl:value-of
													select = "count(/DATASETLIST/DATASET/ROW[OccId])" /></TD>
											<xsl:for-each select = "/DATASETLIST/DATASET/ROW[DBValue]">
												<TD class = "totalrow count"><xsl:value-of
														select = "count(/DATASETLIST/DATASET/ROW[Task__StatusG = current()/GUIValue])" /></TD>
											</xsl:for-each>
										</TR>
									</TABLE>
									<BR />
							<!-- Report body -->
							<div class="noprint" style="text-align: center; font-weight: bold; font-size: 12px; font-style: italic; margin-top: 20px;">*** Remember to "Encrypt" when you Save or Email this report ***</div>

							<xsl:if test="$AdditionalInfo">
								<div style="text-align: left; margin-top: 10px; border-width: 2px; border-type: solid; border-color: black;">
									<div><span style="font-weight: bold;">Additional Information: </span><xsl:value-of select="$AdditionalInfo"/></div>
								</div>
							</xsl:if>

							<div style="text-align: center; margin-top: 10px; border-width: 2px; border-type: solid; border-color: black;">
								<table id="dailySummary" class="display" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
									<thead>
										<tr>
											<th style="font-size: 10px;">Incident</th>
											<xsl:if test="$UnitCode"><!-- Kept here just incase need to move Duty Loc back --></xsl:if>
											<th style="font-size: 10px;">District/RA</th>
											<th style="font-size: 10px;">Reported Time</th>
											<th style="font-size: 10px;">Dispatch Type</th>
											<th style="font-size: 10px;">Incident Type</th>
											<th style="font-size: 10px;">Incident Classification</th>
											<th style="font-size: 10px;">Status</th>
											<th style="font-size: 10px;">Task Type</th>
											<th style="font-size: 10px;">Task Status</th>
											<th style="font-size: 10px;">Rpt/Disp Officer</th>
											<th style="font-size: 10px;">Assigned To</th>
										</tr>
									</thead>
									<tbody>
										<xsl:for-each select="/DATASETLIST/DATASET/ROW[OccId]">
											<!-- Get Occurrence Id-->
												<xsl:variable name="O_Id"><xsl:value-of select="OccId" /></xsl:variable>

											<tr>
												<xsl:choose>
													<xsl:when test="$HighlightBolo = 1 and count(/DATASETLIST/DATASET/ROW[BoloOccId = $O_Id]) > 0">
														<xsl:attribute name="class">GradeX</xsl:attribute>
													</xsl:when>
													<xsl:when test="$HighlightMissingUCR = 1 and count(/DATASETLIST/DATASET/ROW[UCRoOccId = $O_Id]) > 0">
														<xsl:attribute name="class">GradeB</xsl:attribute>
													</xsl:when>
												</xsl:choose>
												<td>
													<a style="font-size: 10px;">
														<xsl:attribute name="href"><xsl:text>nds://</xsl:text><xsl:value-of select="$O_Id"/></xsl:attribute>
														<xsl:value-of select="OccNo"/>
													</a>
												</td>
												<xsl:if test="$UnitCode"><!-- Kept here just incase need to move Duty Loc back --></xsl:if>
												<td style="font-size: 10px;"><xsl:value-of select="DutyLoc"/></td>
												<td style="font-size: 9px;"><xsl:value-of select="ReportedTime"/></td>
												<td style="font-size: 10px;">
													<xsl:choose>
														<xsl:when test="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]">
															<xsl:value-of select="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]/SCDispType"/>
														</xsl:when>
														<xsl:otherwise><xsl:value-of select="DispType"/></xsl:otherwise>
													</xsl:choose>
												</td>
												<td style="font-size: 10px;">
													<xsl:choose>
														<xsl:when test="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]">
															<xsl:value-of select="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]/SCOccType"/>
														</xsl:when>
														<xsl:otherwise><xsl:value-of select="OccType"/></xsl:otherwise>
													</xsl:choose>
												</td>
												<td style="font-size: 10px;">
													<xsl:choose>
														<xsl:when test="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]">
															<xsl:value-of select="/DATASETLIST/DATASET/ROW[SCOccId = $O_Id]/SCOccClass"/>
														</xsl:when>
														<xsl:otherwise><xsl:value-of select="OccClass"/></xsl:otherwise>
													</xsl:choose>
												</td>

												<td style="font-size: 10px;">
													<xsl:value-of select="Status"/>
													<xsl:choose>
														<xsl:when test="$HighlightBolo = 1 and count(/DATASETLIST/DATASET/ROW[BoloOccId = $O_Id]) > 0">
															<br /><xsl:text>*BOLO*</xsl:text>
														</xsl:when>
														<xsl:when test="$HighlightMissingUCR = 1 and count(/DATASETLIST/DATASET/ROW[UCRoOccId = $O_Id]) > 0">
															<br /><xsl:text>*No UCR*</xsl:text>
														</xsl:when>
													</xsl:choose>
												</td>
												<xsl:variable name= "T_Id" select = "DATASET/ROW[TaskId]" />
												<td style="font-size: 10px;">
														<!--<xsl:if test="$TaskTypeG != ''">-->
															<xsl:value-of select="Task__Type1G" />
														<!--</xsl:if>-->
												</td>
												<td style="font-size: 10px;">
														<!--<xsl:if test="$TaskStatusG != ''">-->
															<xsl:value-of select="Task__StatusG" />
														<!--</xsl:if>-->
												</td>
												<td style="font-size: 10px;">
													<xsl:choose>
														<xsl:when test="/DATASETLIST/DATASET/ROW[OccDOFId = $O_Id]">
															<span style="font-size: 10px;"><xsl:value-of select="/DATASETLIST/DATASET/ROW[OccDOFId = $O_Id]/DOF_Officer"/></span>
														</xsl:when>
														<xsl:when test="/DATASETLIST/DATASET/ROW[OccRPOId = $O_Id]">
															<span style="font-size: 10px;"><xsl:value-of select="/DATASETLIST/DATASET/ROW[OccRPOId = $O_Id]/RPO_Officer"/></span>
														</xsl:when>
														<xsl:when test="/DATASETLIST/DATASET/ROW[OccINVId = $O_Id]">
															<span style="font-size: 10px;"><xsl:value-of select="/DATASETLIST/DATASET/ROW[OccINVId = $O_Id]/INV_Officer"/></span>
														</xsl:when>
														<xsl:otherwise>
															<span style="font-size: 10px;"><xsl:value-of select="/DATASETLIST/DATASET/ROW[OccDRUId = $O_Id]/DRU_Officer"/></span>
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td style="font-size: 10px;">

														<!--<span style="font-size: 10px;"><xsl:value-of select="/DATASETLIST/DATASET[/ROW[OccTaskId = $O_Id]/TaskAssignedToRId_L"/></span>-->
														<span style="font-size: 10px;"><xsl:value-of select="Task__TaskAssignedToRId_L" /></span>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</div>
							<div class="ReportHeader2" style="text-align: center; margin-top: 20px;">Total Number of Incidents: <xsl:value-of select="$TotalCount" /></div>

							<xsl:if test="$IncludeMapping = '1'">
								<div style="text-align: center; font-size: 10pt; margin-top: 10px;">
									<form action="http://jus000as5059/GeomaticsUnit/gmap/index.aspx" id="Fromfrm" name="Fromfrm" method="POST" style="display: none;" target="_blank">
										<input type="text" name="jsonRecordSet">
											<xsl:attribute name="value">
												<xsl:text>{"features":[</xsl:text>
												<xsl:for-each select="/DATASETLIST/DATASET/ROW[mapOccID]">
													<xsl:variable name="Verified">
														<xsl:choose>
															<xsl:when test="((mapManuallyVerified = '1') or (mapCompassKey != ''))" ><xsl:text>1</xsl:text></xsl:when>
															<xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise>
														</xsl:choose>
													</xsl:variable>
													<xsl:if test="position() > 1">,</xsl:if>
													<xsl:text>{"attributes":{</xsl:text>
													<xsl:text>"OID":</xsl:text><xsl:value-of select="position()"/>
													<xsl:text>,"ID":</xsl:text>"<xsl:value-of select="mapOccID"/><xsl:text>"</xsl:text>
													<xsl:text>,"OCCURRENCE":</xsl:text><xsl:choose><xsl:when test="mapOccurrenceFileNo = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapOccurrenceFileNo"/>"</xsl:otherwise></xsl:choose>
													<xsl:text>,"REPORTEDTIME":null</xsl:text>
													<xsl:text>,"REPORTEDTIMESTR":</xsl:text><xsl:choose><xsl:when test="mapReportedTime = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapReportedTime"/>"</xsl:otherwise></xsl:choose>
													<xsl:text>,"MOSTSERIOUSVIOLATION":</xsl:text><xsl:choose><xsl:when test="mapMostSerious = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapMostSerious"/>"</xsl:otherwise></xsl:choose>
													<xsl:choose>
														<xsl:when test="((mapManuallyVerified = '1') or (mapCompassKey != ''))" >
															<xsl:text>,"LAMBERTX":</xsl:text><xsl:choose><xsl:when test="mapX = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapX"/>"</xsl:otherwise></xsl:choose>
															<xsl:text>,"LAMBERTY":</xsl:text><xsl:choose><xsl:when test="mapY = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapY"/>"</xsl:otherwise></xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:text>,"LAMBERTX":</xsl:text><xsl:choose><xsl:when test="mapX = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="(((number(mapX) + 2147483648) div 1000) + 262158.685)"/>"</xsl:otherwise></xsl:choose>
															<xsl:text>,"LAMBERTY":</xsl:text><xsl:choose><xsl:when test="mapY = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="(((number(mapY) + 2147483648) div 1000) + 3243138.962)"/>"</xsl:otherwise></xsl:choose>
														</xsl:otherwise>
													</xsl:choose>
													<xsl:text>,"ADDRESS":</xsl:text><xsl:choose><xsl:when test="mapStrNum = '' and mapStrNoSuffix = '' and mapStrType = '' and mapStrDir = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapStrNum"/><xsl:text> </xsl:text><xsl:value-of select="mapStrNoSuffix"/><xsl:text> </xsl:text><xsl:value-of select="mapStrType"/><xsl:text> </xsl:text><xsl:value-of select="mapStrDir"/>"</xsl:otherwise></xsl:choose>
													<xsl:text>,"MUN_ID":</xsl:text><xsl:choose><xsl:when test="mapMuni = ''">null</xsl:when><xsl:otherwise>"<xsl:value-of select="mapMuni"/>"</xsl:otherwise></xsl:choose>
													<xsl:text>,"VERIFIED":</xsl:text>"<xsl:value-of select="$Verified"/><xsl:text>"</xsl:text>
													<xsl:text>}}</xsl:text>
												</xsl:for-each>
												<xsl:text>]}</xsl:text>
											</xsl:attribute>
										</input>
										<input type="text" name="layerName">
											<xsl:attribute name="value">
												<xsl:text>Daily Summary for </xsl:text><xsl:value-of select="$AreaLevel3" /><xsl:text>-</xsl:text><xsl:value-of select="$AreaLevel5" /><xsl:text>-</xsl:text><xsl:value-of select="$strTimeFrame" />
											</xsl:attribute>
										</input>
									</form>
									<a href="javascript:;" onclick="javascript: document.getElementById('Fromfrm').submit()">Send to Map!</a>
								</div>
							</xsl:if>

							<div style="margin-top:10px; text-align: center; font-size: 8pt;">Re-Designed by B.C.S.O. Strategic Operations Division </div>
						</xsl:element>
					</HTML>
				</xsl:template>

				<xsl:template name="StringReplaceQuotation">
					<xsl:param name="text" />
					<xsl:variable name="newText">
						<xsl:call-template name="StringRemoveSlash">
							<xsl:with-param name="text" select="$text" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains($newText, '&quot;')">
							<xsl:variable name="nextString">
								<xsl:call-template name="StringReplaceQuotation">
									<xsl:with-param name="text" select="substring-after($newText, '&quot;')" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:value-of select="concat(substring-before($newText, '&quot;'), '\&quot;' ,$nextString)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$newText" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>

				<xsl:template name="StringRemoveSlash">
					<xsl:param name="text" />
					<xsl:choose>
						<xsl:when test="contains($text, '\')">
							<xsl:variable name="nextString">
								<xsl:call-template name="StringRemoveSlash">
									<xsl:with-param name="text" select="substring-after($text, '\')" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:value-of select="concat(substring-before($text, '\'), '' ,$nextString)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$text" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>

				<!-- StyleClasses template -->
				<xsl:template name="StyleClasses">
					<xsl:element name="style">
						<xsl:attribute name="type">text/css</xsl:attribute>
						<xsl:text>
							v\:* { behavior: url(#default#VML);}
							.{
								font-size: 10pt;
								font-family: Arial;
								vertical-align:top;
							}
							.Data
							{
								font-style: normal;
							}
							.Label
							{
								font-style: italic;
								padding-left:0.2cm;
							}
							.PrintedLabel
							{
								font-size:8pt;
							}
							.ReportHeader
							{
								font-size: 16pt;
								font-weight: bold;
								margin-top:-17pt;
								text-align: center;
							}
							.ReportHeader2
							{
								font-size: 12pt;
								font-style: italic;
								font-weight: bold;
							}
							.ReportHeader3
							{
								font-style: italic;
								font-weight: bold;
							}
							.RestrictedUseLabel
							{
								font-style: italic;
								font-weight: bold;
							}
							.SilverLine
							{
								border-top: solid;
								border-top-width: 2px;
								border-color: silver;
							}
							.TableData
							{
								padding: 2px;
								margin: 0px;
								font-size: 10px;
								vertical-align: top;
								background-color: #FFFFFF;
							}
							.TableHeader
							{
								padding: 2px;
								margin: 0px;
								font-weight: bold;
								font-size: 12px;
								font-style: italic;
								vertical-align: top;
								background-color: #FFFFFF;
								text-align: left;

							}
							.TableDataGrey
							{
								padding: 2px;
								margin: 0px;
								font-size: 10px;
								vertical-align: top;
								background-color: #D8D8D8;

							}
							.TableHeaderGrey
							{
								padding: 2px;
								margin: 0px;
								font-weight: bold;
								font-size: 12px;
								font-style: italic;
								vertical-align: bottom;
								background-color: #D8D8D8;
								text-align: left;
							}
							.ColourWhite
							{
								background-color: #FFFFFF;
							}
							.ColourGrey
							{
								background-color: #D8D8D8;
							}
							.noprint { display: block; }
							.doprint { display: none; }
							@media print {
							      .noprint { display: none; }
							      .doprint { display: block; }
						    	}
							img {
								border-style: none;
							}
							th, td {
								padding: 2px 2px;
							}
						</xsl:text>
					</xsl:element>
				</xsl:template>

				<xsl:template name="loadJavaScriptFiles">
					<script type="text/javascript" src="C:\Users\jm33149\Desktop\BCS_XSLT\JavaScript\media\jquery.min.js"></script>
					<script type="text/javascript" src="C:\Users\jm33149\Desktop\BCS_XSLT\JavaScript\dataTables\js\jquery.dataTables.min.js"></script>
				</xsl:template>

				<xsl:template name="loadCSSFiles">
					<style type="text/css" title="currentStyle">
						<link rel="stylesheet" type="text/css" href="C:\Users\jm33149\Desktop\BCS_XSLT\JavaScript\dataTables\css\datatable.css"/>
					</style>
				</xsl:template>

				<xsl:template name="loadImageLogoBW">
					<img src="http://oppweb.sgc.gov.on.ca/opp/rmsinfopath/Niche/images/logo_bw.jpg" height="60px" width="75px" alt="OPP Logo" />
				</xsl:template>
				<xsl:template name="loadImageLogoColour">
					<img src="C:\Users\jm33149\Desktop\BCS_XSLT\icons\badge_patch.png" height="60px" width="65px" alt="OPP Logo" />
				</xsl:template>
				<xsl:template name="loadImageDoubleDownArrow">
					<img src="C:\Users\jm33149\Desktop\BCS_XSLT\icons\doubledownarrow.gif" height="16px" width="16px" alt="" />
				</xsl:template>
				<xsl:template name="loadImageDoubleUpArrow">
					<img src="C:\Users\jm33149\Desktop\BCS_XSLT\icons\doubleuparrow.gif" height="16px" width="16px" alt="" />
				</xsl:template>


				<!-- Title template -->
				<xsl:template name="Title">
					<xsl:param name="Text" />
					<div style="margin:0pt;border-top-width:18pt;border-style:solid;border-bottom-width:0pt;border-color:silver"></div>
					<div class="ReportHeader"><xsl:value-of select="$Text" /></div>
					<br />
				</xsl:template>

				<!-- InfoBox template -->
				<xsl:template name="InfoBox">
					<xsl:param name="Label1" />
					<xsl:param name="Data1" />
					<xsl:param name="BoldData1">0</xsl:param>
					<xsl:param name="Label2" />
					<xsl:param name="Data2" />
					<xsl:param name="BoldData2">0</xsl:param>
					<xsl:param name="SpecDesc1" />
					<xsl:param name="SpecDesc2" />
					<xsl:param name="SpecDesc3" />
					<xsl:param name="SpecDesc4" />
					<xsl:param name="SpecDesc5" />
					<xsl:param name="SpecDesc6" />
					<xsl:param name="SpecDesc7" />
					<div style="border-style:solid;border-width:1px;padding:0.25cm" >
						<table border="0"><tr><td width="80px">
							<div id="logo1" class="doprint"><xsl:call-template name="loadImageLogoBW" /></div>
							<div id="logo2" class="noprint"><xsl:call-template name="loadImageLogoColour" /></div>
						</td><td width="100%">
							<table border="0" width="97%" align="left" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<xsl:value-of select="/DATASETLIST/DATASET/ROW/AgencyName" /><xsl:if test="/DATASETLIST/DATASET/ROW/DivisionName">, </xsl:if>
										<xsl:value-of select="/DATASETLIST/DATASET/ROW/DivisionName" />
									</td>
									<td width="2%" rowspan="2" />
									<td width="49%" rowspan="2" class="PrintedLabel" style="vertical-align:bottom;text-align:right;">
										<xsl:if test="$SpecDesc1"><xsl:value-of select="$SpecDesc1" /><br /></xsl:if>
										<xsl:if test="$SpecDesc2"><xsl:value-of select="$SpecDesc2" /><br /></xsl:if>
										<xsl:if test="$SpecDesc3"><xsl:value-of select="$SpecDesc3" /><br /></xsl:if>
										<xsl:if test="$SpecDesc4"><xsl:value-of select="$SpecDesc4" /><br /></xsl:if>
										<xsl:if test="$SpecDesc5"><xsl:value-of select="$SpecDesc5" /><br /></xsl:if>
										<xsl:if test="$SpecDesc6"><xsl:value-of select="$SpecDesc6" /></xsl:if>
										<xsl:if test="$SpecDesc6"><xsl:value-of select="$SpecDesc7" /></xsl:if>
									</td>
								</tr>
								<tr>
									<td width="49%" class="PrintedLabel" style="vertical-align:bottom;">
										Printed: <xsl:value-of select="/DATASETLIST/DATASET/ROW/CurrentTime" />
										<br />
										By: <xsl:value-of select="/DATASETLIST/DATASET/ROW/CurrentUser" />
									</td>
								</tr>
							</table>
						</td></tr></table>
					</div>
					<br/>
				</xsl:template>

				<!-- InfoBoxLine template -->
				<xsl:template name="InfoBoxLine">
					<xsl:param name="Label" />
					<xsl:param name="Data" />
					<xsl:param name="BoldData">0</xsl:param>
					<xsl:if test="$Label != '' or $Data != ''" >
						<tr>
							<td><xsl:value-of select="$Label" /></td>
							<xsl:choose>
								<xsl:when test="$BoldData = 1">
									<td style="font-weight:bold"><xsl:value-of select="$Data" /></td>
								</xsl:when>
								<xsl:otherwise>
									<td><xsl:value-of select="$Data" /></td>
								</xsl:otherwise>
							</xsl:choose>
						</tr>
					</xsl:if>
				</xsl:template>

			</xsl:stylesheet>
		]]>
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
					"L12"{"Last 12 hours";}
					"L24"{"Last 24 hours";}
					"L3D"{"Last 3 days";}
					"L4D"{"Last 4 days";}
					"L7D"{"Last 7 days";}
					"L30D"{"Last 30 days";}
					"RNG"{"Specify";}
				};
				label = "Time Range:";
				default="L24";
			};
			declare TaskAssigned checkbox
			{
				label = "Search ";
				default = "0";
			};

			declare StartTime edit
			{
				datatype = datetime;
				label = "From:";
				tag="EntityName=Occurrence;FieldName=ReportedTimeTZV2S";
			};

			declare EndTime edit
			{
				datatype = datetime;
				label = "To:";
				tag="EntityName=Occurrence;FieldName=ReportedTimeTZV2S";
			};

			declare AreaLevel5 edit
			{
				label="Sector:";
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel5";
			};

			declare AreaLevel3 edit
			{
				label="Duty Location:";
				tag="AllowMultiValues=1;EntityName=PhysicalAddress;FieldName=ESAreaLevel3";
			};

			declare UnitCode edit
			{
				label="Unit Code:";
				tag="AllowMultiValues=1;EntityName=Person;FieldName=EmployeeNumber";
			};

			declare ReportableOnly checkbox
			{
				label = "Only Show Reportables:";
				default = "0";
			};

			declare DispatchOnly checkbox
			{
				label = "Only Show Dispatch Calls:";
				default = "0";
			};
			declare OfficerUnitRId_L edit
			{
				tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer1RId_L;";
				label = "Unit: ";
			};
			declare OfficerUnitRId edit
			{
				tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer1RId";
			};
				declare TaskAssignedToRId_L edit
			{
				tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer2RId_L;UseSearchSelector=1";
				label = "Officer/Unit:  ";
			};
			declare TaskAssignedToRId edit
			{
				tag = "EntityName=GPersonArrest;FieldName=GPCCustOfficer2RId";
			};
			declare OccurrenceTypeRId_L edit
			{
				tag = "EntityName=Occurrence;FieldName=OccurrenceStdOccTypeRId_L"; label = "Incident type:";
			};
			declare OccurrenceTypeRId edit
			{
			    tag = "EntityName=Occurrence;FieldName=OccurrenceStdOccTypeRId";
			};
			declare OccurrenceClassificationG set
			{
				 tag = "EntityName=Occurrence;FieldName=ClassificationG"; label = "Incident classification";
			};
			declare ClearanceStatusG set{ tag = "EntityName=Occurrence;FieldName=UCRClearanceStatusG"; label = "Incident status:"; };
			declare AdditionalInfo edit
			{
				label = "Notes: ";
			};

			declare HighlightBolo checkbox
			{
				label = "Highlight BOLO occurrences:";
				default = "1";
			};

			declare HighlightMissingUCR checkbox
			{
				label = "Highlight if missing UCR codes:";
				default = "0";
			};

			declare IncludeMapping checkbox
			{
				label = "Include Mapping Options:";
				default = "0";
			};
			declare TaskTypeG set
			{
				label = "Task type:";
				tag = "EntityName=GTask;FieldName=Type1G";
				SelectLimit = 1;
			};
			declare TaskStatusG set
			{
				label = "Task status:";
				tag= "EntityName=GTask;FieldName=StatusG";
			};

			declare ddlb_accdomain choicelist {label="Domain:";};
			declare ddlb_scope choicelist {label="Scope:";};


			datawindowdef ParameterWindow "ParameterWindow"
			{
				//total width = 2432

				griddef
				{
					columns = 2;
					labelwidth = 450;
					fieldwidth = 550;
					leftmargin = 0;
				};

				// The report title.  This will span both columns.
				text Title
				{
					label = "Daily Summary Report Details";
					fontstyle = "Arial Black";
					fontsize = 12;
					fonteffect = italic!;
					location = page;
					align = center;
					height = 92;
				};

				break(40);

				text Desc
				{
					label = "This report shows all occurrences and their summaries for the selected parameters";
					align = center;
					textcolor = rgb(0,0,255); //blue
				};
				break(10);
				text Desc2
				{
					label = "Un-check 'Include Mapping Options' if report is running slow";
					align = center;
					textcolor = rgb(0,0,255); //blue
				};


				break(40);

				field TimeRange;
				field AreaLevel5 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel5.Visible', '', '') <> '0', 1, 0)";};
				break;

				field StartTime {visible = expression "if (isNull(TimeRange), 0, if (TimeRange = 'RNG', 1, 0))";};
				field AreaLevel3 {visible = expression "if(f_GetProperty('PhysicalAddress.ESAreaLevel3.Visible', '', '') <> '0', 1, 0)"; mandatory="true"; };
				break;

				field EndTime{visible = expression "if (isNull(TimeRange), 0, if (TimeRange = 'RNG', 1, 0))";};
				field UnitCode {visible = false; };
				break;

				griddef
				{
					columns = 2;
					labelwidth = 250;
					fieldwidth = 750;
					leftmargin = 550;
				};

				field ReportableOnly {colspan=1;};
				field HighlightBolo;
				break;

				field DispatchOnly {colspan=1;};
				field HighlightMissingUCR;
				break;

				field IncludeMapping {colspan=1;};
				field TaskAssigned;
				break;


				griddef
				{
					columns = 1;
					labelwidth = 150;
					fieldwidth = 800;
					leftmargin = 100;
				};
				field AdditionalInfo {colspan=2;};
				break;

				griddef
				{
					columns = 2;
					labelwidth = 300;
					fieldwidth = 1000;
					leftmargin = 100;
				};
				field TaskAssignedToRId_L {visible = expression "if (isNull(TaskAssigned), 1, if (TaskAssigned = '0', 1, 0 ))";};
				field TaskAssignedToRId { visible = false; property CreateControlOnDW ="1"; };
				break;

				griddef
				{
					columns = 2;
					labelwidth = 300;
					fieldwidth = 1000;
					leftmargin = 100;
				};
				field OfficerUnitRId_L {visible = expression "if (isNull(TaskAssigned), 0, if (TaskAssigned = '1', 1, 0 ))";};
				field OfficerUnitRId { visible = false; property CreateControlOnDW ="1"; };
				break;
				griddef
				{
					columns = 2;
					labelwidth = 500;
					fieldwidth = 400;
					leftmargin = 100;
				};
				field OccurrenceTypeRId_L;
				field OccurrenceTypeRId { visible = false; property CreateControlOnDW = "1"; };
				field OccurrenceClassificationG;
				break;
				field ClearanceStatusG;
				skipcol;

				break;

				field TaskTypeG;
				field TaskStatusG;
				break;

				griddef
				{
					columns = 2;
					labelwidth = 400;
					fieldwidth = 400;
					leftmargin = 100;
				};

				text WarningDates // only visible when StartTime > EndTime
				{
					label="The starting date in the date range must come before the ending date.";
					align = center;
					height = 120;
					location = columns(1);
					visible = expression "if (f_nonull(StartTime) = '' or f_nonull(EndTime) = '', 0, if(TimeRange = 'RNG' and f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), 1, 0))";
					textcolor=rgb(255,0,0); //red
				};
				skipcol;

				break;

				griddef
				{
					columns = 4;
					labelwidth = 260;
					fieldwidth = 200;
					leftmargin = 50;
				};

				field ddlb_accdomain {colspan=2;};
				field ddlb_scope {colspan=2;};


				// Parameters for the XSLT report

				// Used by the DW to validate the data
				computedfield valid
				{
					visible = false;
					expression =
						"(TimeRange = 'L12' or TimeRange = 'L24' or TimeRange = 'L3D' or TimeRange = 'L4D' or TimeRange = 'L7D' or TimeRange = 'L30D' or "
							"(TimeRange = 'RNG' and (f_nonull(StartTime) <>'' and f_nonull(EndTime) <> '' "
								"and f_getdatetimecomparablecfromg(StartTime) <= f_getdatetimecomparablecfromg(EndTime)))) ";
				};

				// Used to display an error message to the user
				computedfield invalidfields
				{
					visible = false;
					expression =
						"if (TimeRange = 'RNG' and f_nonull(StartTime) = '', "
							"'~t' + f_TranslateString('str:startdate') + '~n', '') + "
						"if (TimeRange = 'RNG' and f_nonull(EndTime) = '', "
							"'~t' + f_TranslateString('str:enddate') + '~n', '') + "
						"if (f_getdatetimecomparablecfromg(StartTime) > f_getdatetimecomparablecfromg(EndTime), "
							"'~t' + f_TranslateString('str:daterangewarning') + '~n', '') ";
				};

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
				computedfield TaskType { visible = false; expression = "if (len(TaskTypeG) > 0, md_GetDBValueFromSetByName('GTask', 'Type1G', f_NoNull(TaskTypeG)), '')";};
				computedfield TaskStatus { visible = false; expression = "if (len(TaskStatusG) > 0, md_GetDBValueFromSetByName('GTask', 'StatusG', f_NoNull(TaskStatusG)), '')";};
				computedfield OfficerUnitIds { visible = false; expression = "f_ReplaceAll(OfficerUnitRId, '~n', ';')"; };
				computedfield TaskAssignedTo { visible = false; expression = "f_ReplaceAll(TaskAssignedToRId, '~n', ';')"; };
				computedfield ClearanceStatus
				{
					visible = false;
					expression ="if (len(ClearanceStatusG) > 0, md_GetDBValueFromSetByName('Occurrence', 'UCRClearanceStatusG', f_NoNull(ClearanceStatusG)), '')";
				};
				computedfield OccurrenceClassification
				{
					visible = false;
					expression ="if (len(OccurrenceClassificationG) > 0, md_GetDBValueFromSetByName('Occurrence', 'ClassificationG', f_NoNull(ClassificationG)), '')";
				};
			};

			group Parameter_Group "ParameterGroup"
			{
				ParameterWindow
			};
		]]>
	</DatawindowDef>
</root>