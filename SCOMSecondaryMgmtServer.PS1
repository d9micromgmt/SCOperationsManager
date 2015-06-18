configuration SCOMSecondaryMgmtServer
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
        xSCOMManagementServerSetup SCOMPrimaryMgmtServer
        {
            Ensure = "Present"
            SourcePath = $PackagePath
            SetupCredential = $InstallerServiceAccount
            ProductKey = $ProductKey
            ManagementGroupName = $MgmtGroup
            FirstManagementServer = $false
            ActionAccount = $SCOMActionAccount
            DASAccount = $SCOMDASAccount
            DataReader = $SCOMDataReader
            DataWriter = $SCOMDataWriter
            SqlServerInstance = ($SCOMDatabaseServer + "\" + $SCOMDatabaseInstance)
            DwSqlServerInstance = ($SCOMDatawarehouseServer + "\" + $SCOMDatawarehouseInstance)
        }
    }
}
