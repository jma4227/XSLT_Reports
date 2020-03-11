<root>
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
</root>