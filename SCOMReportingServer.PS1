configuration SCOMReportingServer
{
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $PackagePath
    )

    Import-DSCResource -modulename xSCOM

    Node localhost
    {
        xSCOMReportingServerSetup SCOMReportingServer
        {
            Ensure = "Present"
            SourcePath = $SourcePath
            SourceFolder = $PackagePath
            SetupCredential = $InstallerServiceAccount
            ManagementServer = $SCOMManagementServer
            SRSInstance = ($SCOMReportingServer + "\" + $SCOMReportingInstance)
            DataReader = $SCOMDataReader
        }
    }
}
