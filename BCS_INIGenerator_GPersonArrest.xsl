<?xml version="1.0" encoding="Windows-1252"?>
<root>
	<VersionInfo>
		<Filename>INIGenerator_GPersonArrest.xml</Filename>
		<Revision>1.12</Revision>
		<NMLVersion>5.04.11.02.18</NMLVersion>
		<Developer>Niche</Developer>
		<NicheBuildName>BexarCounty</NicheBuildName>
		<BuildTime>2018/07/21 22:08:16</BuildTime>
		<BuildTime>2020/02/06 14:00:00</BuildTime>
	</VersionInfo>
	<!-- $Id: 03c9a79ead9a3423e03164094b67a3d9b88833e9 $ -->

	<ReportName>INIGenerator_GPersonArrest</ReportName>
	<SQLParameter>CurrentLanguage</SQLParameter>
	<XSLTParameter>RestrictedUse</XSLTParameter>
	<SQLSelectXSLT><![CDATA[<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
		<xsl:param name="EntityName" />
		<xsl:param name="PARAM_ID" />

		<xsl:template match="/">
		----------------------------------------------------------
		--  XML filename: INIGenerator_GPersonArrest.xml
		--  File revision: 1.12
		--  NML version: 5.04.11.02.18
		--  Developer: Niche
		--  Niche build name: BexarCounty
		--  Build time: 2018/07/21 22:08:16
		----------------------------------------------------------
				SELECT



				GPA__Id,
				GPA__GPPEventGOccNLOccurrenceFileNoG as 'NLOccurrenceFileNo-I',
				GPA__PROTECTIVEMARKINGG as ProtectiveMarking,
				GPAPA__labeladdressonly as 'CustAddress_FullAddress',
				GPAPA__LabelUSFullAddressINIGen as 'CustAddress_FullAddressUS',
				GPAPA__LabelUSFullAddressPostalINIGen as 'CustAddress_FullAddressUSPostal',
				GPPEGOCC__OccurrenceFileNo as 'OccurrenceFileNo--I',
				GPPC__CustodyNumberG__0 as 'CustodyNumber',
				@CustOffId1 = GPPC__GPCCustOfficer1RId__0,
				@CustodyId = GPPC__Id__0,
				Unit__Label__0__0 as 'CustodyOfficer1_UnitName',
				GPNPri__Given1G__0 as 'Given1',
				GPNPri__Given1G__0 as 'Given1_Initial-S1',
				GPNPri__Given2G__0 as 'Given2',
				GPNPri__Given2G__0 as 'Given2_Initial-S1',
				GPNPri__Given3G__0 as 'Given3',
				GPNPri__Given3G__0 as 'Given3_Initial-S1',
				GPNPri__SurnameG__0 as 'Surname',
				GPNPri__DateOfBirthG__0 as 'DateOfBirth',
				GPNPri__Age__0 as 'Age',
				GPNPri__GenderG__0 as 'Gender',
				GPNPri__Gender__0 as 'GenderAbbr',
				PDesc__EyeColorG__0__0 as 'EyeColor',
				PDesc__HairColorG__0__0 as 'HairColor',
				PDesc__HeightG__0__0 as 'Height',
				PDesc__MassG__0__0 as 'Mass',
				PDesc__RaceG__0__0 as 'Race',
				PDesc__EthnicityG__0__0 as 'Ethnicity',

				PInfo__BirthPlaceG__0 as 'BirthPlace-CFSCBirthPlaceProvStateCountry',
				PInfo__BirthCountryG__0 as 'BirthPlace-CFCCBirthPlaceProvStateCountry',
				PInfo__BirthProvStateG__0 as 'BirthPlace-CFCCBirthPlaceProvStateCountry',

				DL__IDNumberG__0 as 'DriversLicenseNumber',
				DL__ProvinceStateG__0 as 'DriversLicenseProvinceState',
				DL__ProvinceState__0 as 'DriversLicenseProvinceStateCode',
				FPS__IDNumberG__0 as 'FPS',
				PA__LabelAddressOnly__0__0 as 'FullAddress',
				PA__LabelUSFullAddressINIGen__0__0 as 'FullAddressPostal',
				PA__LabelUSFullAddressPostalINIGen__0__0 as 'FullAddressUSPostal',
				TRes__CommAddressG__0__0 as 'Telephone',
				TBus__CommAddressG__0__0 as 'BusinessTelephone',
				GOcc__StartTimeF(Format="%Y") as 'OccurrenceStartTimeYear',
				GOcc__StartTimeF(Format="%Y") as 'OccurrencStartTimeYear',
				P__DistinctTitle_cacheG__0 as 'Title',
				SSN__IdNumberG__0 as 'SSN',
				PoliceID2__IdNumberG__0 as 'PoliceId2',
				FBI__IdNumberG__0 as 'FBI',
				GPA__CustodyNumberG as 'Custody_No'
				FROM GPersonArrest GPA
				left join (GPCCustAddress
 					left join (physicaladdress GPAPA)
				)
				left join (GPPCustodyEvent GPPCE
					left join(GPersonPolCustody GPPC
						left join(GPCCustOfficer1 GPCCustOfficer
							left join (GPerson CustOfficer
								left join (GPersonEmploy GPEMP)
								left join (GPersonOrgMemberGPerson GPOMGP
									left join (OrgPoliceUnit Unit) on GPOMGP.Lid=Unit.id
								) on GPOMGP.RId = CustOfficer.Id and GPOMGP.IsEffectiveAssignment = 1
							)
						)



						left join(GPerson
							left join(Person P
								left join(GPersonName GPNPri) on ChoiceHasProperty(GPNPri.Type1,"cl_GPersonNameType","clvIsPrimary","1") = 1
								left join(PersonDesc PDesc)
								left join(PersonInfo PInfo)
								left join(GPIDDL DL)
								left join(GPIDFPS FPS)
								left join(GPIDUSSSN SSN)
								left join(GPIDPoliceID2 PoliceID2)
								left join(GPIDUSFBI FBI)
								left join(GPersonAssocGAddress GPAGA1
									left join(PhysicalAddress PA)
								) on IsSpecialization(GPAGA1.RId, "PhysicalAddress") = 1 and GPAGA1.EffectiveToTimeTZV2I IS NULL and ChoiceHasProperty(GPAGA1.Type1, "cl_GPersonAssocGAddressType", "NotRanked", "1") = 0 and OrderBy(GPAGA1.Rank, "Asc", GPAGA1.cretime, "Desc") = 1

								left join(GPersonAssocGAddress GPAGA2
									left join(Telephone TRes)
								) on ChoiceHasProperty(GPAGA2.Type1, "cl_GPersonAssocGAddressType", "clvIsResidence", "1") = 1 AND IsSpecialization(GPAGA2.RId, "Telephone") = 1 and GPAGA2.EffectiveToTimeTZV2I IS NULL and OrderBy(GPAGA2.cretime, "Desc") = 1

								left join(GPersonAssocGAddress GPAGA3
									left join(Telephone TBus)
								) on ChoiceHasProperty(GPAGA3.Type1, "cl_GPersonAssocGAddressType", "clvIsBusiness", "1") = 1 AND IsSpecialization(GPAGA3.RId, "Telephone") = 1 and GPAGA3.EffectiveToTimeTZV2I IS NULL and OrderBy(GPAGA3.cretime, "Desc") = 1
							)
						)
					)
				)on orderby(gppce.closed, 'asc', gppce.cretime, 'desc') = 1
				left join (GPPEventGOcc GPPEGOCC
					left join (GOccurrence GOcc)
				)



				where GPersonArrest.id  = <xsl:value-of select="$PARAM_ID" />




			select
			ChargeWordingEx as 'GPerson_Charge-P0_ShortWording',
			SectionMergedEx as 'GPerson_Charge-P0_Section',
			OffenseDate1F(Format="TF5") as 'GPerson_Charge-P0_OffenseDateRangeTF6-TF61OffenseDateRangeTF6',
			OffenseDate2F(Format="TF5") as 'GPerons_Charge-P0_OffenseDateRangeTF6-TF62OffenseDateRangeTF6'
			from GPChargeGPArrest
			left join (GPersonCharge Charge)
			where GPChargeGPArrest.RId = @CustodyId order by charge.cretime desc

			exec pr_getnow '%H:%M', 'TimeNow'
			exec pr_getnow 'GWithoutTime', 'sp_todaysdate'
			exec pr_getnow 'GWithoutOffset', 'sp_todaysdatetime'


			SELECT Id as 'Logo_Id-I', Id as 'BlobData_DocData_ExternalDocumentTemplate_Id-I' from ExternalDocumentTemplate WHERE TitleG = 'logo.jpg' AND ACCDomain = 'Current-' ORDER BY ACCDomain DESC

		</xsl:template>

	</xsl:stylesheet>]]></SQLSelectXSLT>



	<ReportXSL><![CDATA[<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dt="urn:schemas-microsoft-com:datatypes">
<xsl:param name="RestrictedUse" />
<xsl:output method="xml" encoding="UTF-8" />

	<xsl:template match="/">
		<xsl:element name="root">
			<xsl:call-template name="OutputFlatXML"></xsl:call-template>
			<xsl:element name="RestrictedUse"><xsl:value-of select="$RestrictedUse" /></xsl:element>

			<!--Special processing for inigenerator-->

			<!-- Logo -->
			<xsl:element name="Logo">
				<xsl:if test="string-length(/DATASETLIST/DATASET/ROW/Logo_Id-I) &gt; 0">
					<xsl:element name="narrative">
						<xsl:attribute name="column">DocData</xsl:attribute>
						<xsl:value-of select="/DATASETLIST/DATASET/ROW/BlobData_DocData_ExternalDocumentTemplate_Id-I"></xsl:value-of>
					</xsl:element>
				</xsl:if>
			</xsl:element>


			<xsl:element name="OccurrenceFileNo">
				<xsl:choose>
					<xsl:when test="/DATASETLIST/DATASET/ROW/OccurrenceFileNo-I = ''">
						<xsl:value-of select="/DATASETLIST/DATASET/ROW/NLOccurrenceFileNo-I" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/DATASETLIST/DATASET/ROW/OccurrenceFileNo-I" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!--End of special processing for inigenerator-->


		</xsl:element>
	</xsl:template>


			<xsl:template name="OutputFlatXML">
				<xsl:for-each select="/*">
					<xsl:call-template name="MatchNode">
						<xsl:with-param name="DepthPositionMap" />
						<xsl:with-param name="Depth">0</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:template>


			<xsl:template name="MatchNode">
				<xsl:param name="DepthPositionMap" />
				<xsl:param name="Depth" />
				<xsl:variable name="ParentPosition" select="concat(string(number(position())), name())" />
				<xsl:variable name="ParentPositionString">
					<xsl:value-of select="string($ParentPosition)" />
				</xsl:variable>

				<xsl:for-each select="child::*">
					<xsl:choose>
						<!-- nothing but text nodes underneath this child node -->
						<!--<xsl:when test="self::*[count(node()) - count(text()) = 0 and name() != 'DATASET']">-->
						<xsl:when test="name() != 'ROW' and name() != 'DATASET'">
							<xsl:call-template name="MatchLeafNode">
								<xsl:with-param name="DepthPositionMap"><xsl:value-of select="$DepthPositionMap" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="name() = 'ROW'">
							<xsl:call-template name="MatchNode">
								<xsl:with-param name="DepthPositionMap">
									<xsl:choose>
										<xsl:when test="string-length($DepthPositionMap) = 0">
											<xsl:value-of select="concat($Depth, '-', string(position()))" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat($DepthPositionMap, '_', $Depth, '-', string(position()))" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>

								<xsl:with-param name="Depth"><xsl:value-of select="$Depth + 1" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="name() = 'DATASET' and child::*">
							<xsl:call-template name="MatchNode">
								<xsl:with-param name="DepthPositionMap"><xsl:value-of select="$DepthPositionMap" /></xsl:with-param>
								<xsl:with-param name="Depth"><xsl:value-of select="$Depth" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:template>



			<xsl:template name="MatchLeafNode">
				<xsl:param name="DepthPositionMap" />
				<xsl:if test="not(contains(name(), '-I'))">
					<xsl:variable name="PositionFilledName">
						<xsl:call-template name="AddPositionToName">
							<xsl:with-param name="OriginalName" select="name()" />
							<xsl:with-param name="DepthPositionMap" select="$DepthPositionMap" />
						</xsl:call-template>
					</xsl:variable>

					<xsl:choose>
						<!--Alternate name used for headings -->
						<xsl:when test="contains($PositionFilledName, '-UseAlternateName')">
							<xsl:element name="{$PositionFilledName}">
								<xsl:attribute name="AlternateName"><xsl:value-of select="substring-before(text(), ';')" /></xsl:attribute>
								<xsl:value-of select="normalize-space(substring-after(text(), ';'))" />
							</xsl:element>
						</xsl:when>

						<!--Substring -->
						<xsl:when test="contains($PositionFilledName, '-S')">
							<xsl:element name="{substring-before($PositionFilledName,'-S')}">
								<xsl:variable name="SubstringLength" select="number(substring-after($PositionFilledName,'-S'))" />
								<xsl:value-of select="substring(text(),1,$SubstringLength)" />
							</xsl:element>
						</xsl:when>

						<!--Replace with Counter -->
						<xsl:when test="contains($PositionFilledName, '-N')">
							<xsl:element name="{substring-before($PositionFilledName,'-N')}">
								<xsl:variable name="Counter" select="number(substring-after($PositionFilledName,'-N'))" />
								<xsl:call-template name="AddPositionToName">
									<xsl:with-param name="OriginalName" select="concat('-P', $Counter)" />
									<xsl:with-param name="DepthPositionMap" select="$DepthPositionMap" />
								</xsl:call-template>
							</xsl:element>
						</xsl:when>

						<!-- Boolean exported as 1 or 0 -->
						<xsl:when test="@dt:type='boolean'">
							<xsl:element name="{$PositionFilledName}">
								<xsl:choose>
									<xsl:when test="text()='True'">1</xsl:when>
									<xsl:when test="text()='False'">0</xsl:when>
								</xsl:choose>
							</xsl:element>
						</xsl:when>

						<!-- Combine fields -->
						<xsl:when test="contains($PositionFilledName, '-CFS')">
							<xsl:element name="{substring(substring-after($PositionFilledName,'-CFS'),2)}">
								<xsl:variable name="CFSName" select="substring(substring-after(name(),'-CFS'),2)" />
								<xsl:value-of select="normalize-space(text())" />
								<xsl:for-each select="../*[contains(name(),'-CFC') and  substring(substring-after(name(), '-CFC'),2) = $CFSName]">
									<xsl:if test="text()!=''">
										<xsl:variable name="Separator" select="substring(substring-after(name(), '-CFC'),1,1)" />
										<xsl:text />
										<xsl:call-template name="GetSeparatorCharacter">
											<xsl:with-param name="Separator"><xsl:value-of select="$Separator" /></xsl:with-param>
										</xsl:call-template>
										<xsl:value-of select="normalize-space(text())" />
									</xsl:if>
								</xsl:for-each>
							</xsl:element>
						</xsl:when>
						<xsl:when test="contains($PositionFilledName, '-CFC')">
							<!-- Do nothing -->
						</xsl:when>

						<!-- Combine row -->
						<xsl:when test="contains($PositionFilledName, '-CR1X')">
							<xsl:value-of select="normalize-space($PositionFilledName)" />
							<xsl:element name="{substring(substring-after($PositionFilledName,'-CR1X'),2)}">
								<xsl:variable name="CFSName" select="substring(substring-after($PositionFilledName,'-CR1X'),2)" />
								<!-- <xsl:value-of select="normalize-space(text())" /> -->
								<xsl:for-each select="../../ROW/*[contains(name(),'-CR') and substring(substring-after(name(), '-CR'),6) = $CFSName and text()]">
									<xsl:if test="text()!=''">
										<xsl:variable name="Separator" select="substring(substring-after(name(), '-CR'),5,1)" />
										<xsl:text />
										<xsl:if test="position()!=1">
											<xsl:call-template name="GetSeparatorCharacter">
												<xsl:with-param name="Separator"><xsl:value-of select="$Separator" /></xsl:with-param>
											</xsl:call-template>
										</xsl:if>
										<xsl:value-of select="normalize-space(text())" />
									</xsl:if>
								</xsl:for-each>
							</xsl:element>
						</xsl:when>
						<xsl:when test="contains($PositionFilledName, '-CR') and not (substring(substring-after($PositionFilledName, '-CR'),1,1)=1)">
							<!-- Do nothing -->
						</xsl:when>

						<!--TF3 Date values -->
						<xsl:when test="contains($PositionFilledName, '-TF3')">
							<xsl:variable name="Index" select="number(substring(substring-after($PositionFilledName,'-TF3'),2,1))" />
							<xsl:variable name="Language" select="substring(substring-after($PositionFilledName,'-TF3'),1,1)" />
							<xsl:variable name="BaseName" select="substring(substring-after($PositionFilledName,'-TF3'),3)" />
							<xsl:if test="$Index=1">
								<xsl:element name="{substring-before($PositionFilledName,'-TF3')}">
									<xsl:if test="text()">

									<!-- Check the for the TF32 value with name-->
									<xsl:variable name="SecondValue" select="../*[contains(name(),concat(concat(concat('-TF3', $Language), '2'), $BaseName))]" />
									<xsl:variable name="RangePart1" select="/DATASETLIST/DATASET/ROW/*[concat(concat('TF3RangePart1',$Language),'-I')=name()]" />
									<xsl:variable name="RangePart2" select="/DATASETLIST/DATASET/ROW/*[concat(concat('TF3RangePart2',$Language),'-I')=name()]" />
									<xsl:variable name="Single" select="/DATASETLIST/DATASET/ROW/*[concat(concat('TF3Single',$Language),'-I')=name()]" />


										<xsl:choose>
											<xsl:when test="$SecondValue=''">
												<xsl:choose>
													<xsl:when test="contains(text(),'le ')">
														<xsl:value-of select="$Single" /><xsl:value-of select="substring-after(text(),'le ')" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="$Single" /><xsl:value-of select="text()" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$RangePart1" /><xsl:value-of select="text()" /><xsl:value-of select="$RangePart2" /><xsl:value-of select="$SecondValue" />
											</xsl:otherwise>
										</xsl:choose>

									</xsl:if>
								</xsl:element>
							</xsl:if>
						</xsl:when>

						<!--TF6 Date values -->
						<xsl:when test="contains($PositionFilledName, '-TF6')">
							<xsl:variable name="Index" select="number(substring(substring-after($PositionFilledName,'-TF6'),1,1))" />
							<xsl:variable name="BaseName" select="substring(substring-after($PositionFilledName,'-TF6'),2)" />
							<xsl:if test="$Index=1">
								<xsl:element name="{substring-before($PositionFilledName,'-TF6')}">
									<xsl:if test="text()">

									<!-- Check the for the TF62 value with basename-->
									<xsl:variable name="SecondValue" select="../*[contains(name(),concat(concat('-TF6', '2'), $BaseName))]" />

										<xsl:choose>
											<xsl:when test="$SecondValue=''">
												<xsl:value-of select="text()" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="text()" /> - <xsl:value-of select="$SecondValue" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
								</xsl:element>
							</xsl:if>
						</xsl:when>


						<!-- No special handling -->
						<xsl:otherwise>
							<xsl:element name="{$PositionFilledName}">
								<xsl:value-of select="normalize-space(text())" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:text>
</xsl:text>
				</xsl:if>
			</xsl:template>



			<xsl:template name="GetSeparatorCharacter">
				<xsl:param name="Separator" />
				<xsl:choose>
					<xsl:when test="$Separator='C'">, </xsl:when>
					<xsl:when test="$Separator='S'"><xsl:text> </xsl:text></xsl:when>
					<xsl:when test="$Separator='H'"> - </xsl:when>
					<xsl:when test="$Separator='B'">&lt;/br&gt;</xsl:when>
					<xsl:when test="$Separator='L'">&lt;/lf&gt;</xsl:when>
					<xsl:when test="$Separator='N'">; </xsl:when>
				</xsl:choose>
			</xsl:template>



			<xsl:template name="AddPositionToName">
				<xsl:param name="OriginalName" />
				<xsl:param name="DepthPositionMap" />

				<xsl:choose>
					<xsl:when test="string-length($DepthPositionMap) &gt; 0 and contains($OriginalName, '-P')">
						<xsl:variable name="FirstDepthPositionPair">
							<xsl:choose>
								<xsl:when test="contains($DepthPositionMap, '_')">
									<xsl:value-of select="substring-before($DepthPositionMap, '_')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$DepthPositionMap" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:variable name="Depth" select="substring-before($FirstDepthPositionPair, '-')" />
						<xsl:variable name="Position" select="substring-after($FirstDepthPositionPair, '-')" />

						<xsl:choose>
							<xsl:when test="contains($OriginalName, concat('-P', $Depth))">
								<xsl:call-template name="AddPositionToName">
									<xsl:with-param name="OriginalName" select="concat(substring-before($OriginalName, concat('-P', $Depth)), $Position, substring-after($OriginalName, concat('-P', $Depth)))" />
									<xsl:with-param name="DepthPositionMap" select="substring-after($DepthPositionMap, '_')" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="AddPositionToName">
									<xsl:with-param name="OriginalName" select="$OriginalName" />
									<xsl:with-param name="DepthPositionMap" select="substring-after($DepthPositionMap, '_')" />
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$OriginalName" /><!--xsl:value-of select="$DepthPositionMap"/-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:template>


			<xsl:template match="*" mode="EscapeSpecialCharacters">
				<xsl:call-template name="StringReplace">
					<xsl:with-param name="InitialString">
						<xsl:call-template name="StringReplace">
							<xsl:with-param name="InitialString" select="." />
							<xsl:with-param name="ToReplace"><xsl:text>&amp;</xsl:text></xsl:with-param>
							<xsl:with-param name="ReplaceWith"><xsl:text>&amp;amp;</xsl:text></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="ToReplace"><xsl:text>&lt;</xsl:text></xsl:with-param>
					<xsl:with-param name="ReplaceWith"><xsl:text>&amp;lt;</xsl:text></xsl:with-param>
				</xsl:call-template>
			</xsl:template>


				<xsl:template name="StringReplace">
					<xsl:param name="InitialString" />
					<xsl:param name="ToReplace" />
					<xsl:param name="ReplaceWith" />

					<xsl:choose>
						<xsl:when test="contains($InitialString, $ToReplace)">
							<xsl:value-of select="substring-before($InitialString, $ToReplace)" />
							<xsl:value-of select="$ReplaceWith" />
							<xsl:call-template name="StringReplace">
								<xsl:with-param name="InitialString" select="substring-after($InitialString, $ToReplace)" />
								<xsl:with-param name="ToReplace" select="$ToReplace" />
								<xsl:with-param name="ReplaceWith" select="$ReplaceWith" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$InitialString" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>



			<xsl:template match="*" mode="EscapeSpecialCharactersNonBlank">
				<xsl:choose>
					<xsl:when test="string-length(./text()) &gt; 0 or ./text() !=''">
						<xsl:apply-templates select="." mode="EscapeSpecialCharacters" />
					</xsl:when>
					<xsl:otherwise><xsl:text> -- 	</xsl:text></xsl:otherwise>
				</xsl:choose>
			</xsl:template>


				<xsl:template name="ReplaceCarriageReturnsWithINIBRTags">
					<xsl:param name="String" />

					<xsl:if test="string-length($String) &gt; 0">
						<xsl:choose>
							<xsl:when test="substring($String, 1, 1) = '&#xD;'"><xsl:text>&lt;/br&gt;</xsl:text></xsl:when>
							<xsl:otherwise><xsl:value-of select="substring($String, 1, 1)" /></xsl:otherwise>
						</xsl:choose>

						<xsl:call-template name="ReplaceCarriageReturnsWithINIBRTags">
							<xsl:with-param name="String" select="substring($String, 2)" />
						</xsl:call-template>
					</xsl:if>
				</xsl:template>



</xsl:stylesheet>]]></ReportXSL>
	<OutputType>XML</OutputType>
</root>