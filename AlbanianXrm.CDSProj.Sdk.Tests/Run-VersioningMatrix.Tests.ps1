param(
    [string]$Configuration = "Debug"
)

$ErrorActionPreference = "Stop"

$cases = @(
    @{
        Name = "NoGit_NoBuildVersion"
        Project = "albx_TestSolutionMatrix_NoGit_NoBuildVersion/albx_TestSolutionMatrix_NoGit_NoBuildVersion.cdsproj"
        EnableGitVersioning = $false
        BuildVersion = $null
        InitialSolutionVersion = "2.0.0.0"
    },
    @{
        Name = "NoGit_WithBuildVersion"
        Project = "albx_TestSolutionMatrix_NoGit_WithBuildVersion/albx_TestSolutionMatrix_NoGit_WithBuildVersion.cdsproj"
        EnableGitVersioning = $false
        BuildVersion = "8.8.8.8"
        InitialSolutionVersion = "2.1.0.0"
    },
    @{
        Name = "Git_NoBuildVersion"
        Project = "albx_TestSolutionMatrix_Git_NoBuildVersion/albx_TestSolutionMatrix_Git_NoBuildVersion.cdsproj"
        EnableGitVersioning = $true
        BuildVersion = $null
        InitialSolutionVersion = "2.2.0.0"
    },
    @{
        Name = "Git_WithBuildVersion"
        Project = "albx_TestSolutionMatrix_Git_WithBuildVersion/albx_TestSolutionMatrix_Git_WithBuildVersion.cdsproj"
        EnableGitVersioning = $true
        BuildVersion = "9.9.9.9"
        InitialSolutionVersion = "2.3.0.0"
    }
)

$pluginPackageFolders = @(
    "albx_AlbanianXrm.PluginPackage",
    "albx_AlbanianXrm.OtherPluginPackage",
    "albx_AlbanianXrm.YetAnotherPluginPackage"
)

function Assert-Equal {
    param(
        [string]$Expected,
        [string]$Actual,
        [string]$Message
    )

    if ($Expected -ne $Actual) {
        throw "$Message. Expected '$Expected' but found '$Actual'."
    }
}

function Get-SolutionVersion {
    param([string]$SolutionXmlPath)
    [xml]$xml = Get-Content -Path $SolutionXmlPath -Raw
    return $xml.ImportExportXml.SolutionManifest.Version
}

function Set-SolutionVersion {
    param(
        [string]$SolutionXmlPath,
        [string]$Version
    )

    [xml]$xml = Get-Content -Path $SolutionXmlPath -Raw
    $xml.ImportExportXml.SolutionManifest.Version = $Version
    $xml.Save($SolutionXmlPath)
}

function Get-PluginPackageVersion {
    param([string]$PluginPackageXmlPath)
    [xml]$xml = Get-Content -Path $PluginPackageXmlPath -Raw
    return $xml.pluginpackage.version
}

function Get-MsbuildPropertyValue {
    param(
        [string]$ProjectPath,
        [string]$PropertyName,
        [string]$TargetName = ""
    )

    $arguments = @(
        "msbuild",
        $ProjectPath,
        "-nologo",
        "-getProperty:$PropertyName"
    )

    if ($TargetName) {
        $arguments += "-t:$TargetName"
    }

    $output = dotnet @arguments
    return ($output | Select-Object -Last 1).Trim()
}

foreach ($case in $cases) {
    $projectPath = Join-Path $PSScriptRoot $case.Project
    $projectDirectory = Split-Path -Parent $projectPath
    $solutionXmlPath = Join-Path $projectDirectory "src/Other/Solution.xml"

    Set-SolutionVersion -SolutionXmlPath $solutionXmlPath -Version $case.InitialSolutionVersion

    $expectedVersion = $case.BuildVersion
    if (-not $expectedVersion) {
        if ($case.EnableGitVersioning) {
            $assemblyFileVersion = Get-MsbuildPropertyValue -ProjectPath $projectPath -PropertyName "AssemblyFileVersion" -TargetName "GetBuildVersion"
            if (-not $assemblyFileVersion) {
                throw "Case '$($case.Name)' could not evaluate AssemblyFileVersion from GetBuildVersion target."
            }
            $expectedVersion = $assemblyFileVersion
        }
        else {
            $expectedVersion = $case.InitialSolutionVersion
        }
    }

    $buildArguments = @(
        "build",
        $projectPath,
        "/p:Configuration=$Configuration",
        "/p:EnableGitVersioning=$($case.EnableGitVersioning.ToString().ToLowerInvariant())"
    )

    if ($case.BuildVersion) {
        $buildArguments += "/p:FileVersion=$($case.BuildVersion)"
    }

    dotnet @buildArguments

    $actualSolutionVersion = Get-SolutionVersion -SolutionXmlPath $solutionXmlPath
    Assert-Equal -Expected $expectedVersion -Actual $actualSolutionVersion -Message "Case '$($case.Name)' failed solution version assertion"

    foreach ($pluginPackageFolder in $pluginPackageFolders) {
        $pluginPackageXmlPath = Join-Path $projectDirectory "src/pluginpackages/$pluginPackageFolder/pluginpackage.xml"
        $actualPluginPackageVersion = Get-PluginPackageVersion -PluginPackageXmlPath $pluginPackageXmlPath
        Assert-Equal -Expected $expectedVersion -Actual $actualPluginPackageVersion -Message "Case '$($case.Name)' failed plugin package version assertion for '$pluginPackageFolder'"
    }

    $doublePrefixFolder = Join-Path $projectDirectory "src/pluginpackages/albx_albx_AlbanianXrm.OtherPluginPackage"
    if (Test-Path $doublePrefixFolder) {
        throw "Case '$($case.Name)' generated an unexpected double-prefixed plugin package folder: $doublePrefixFolder"
    }
}

Write-Host "Versioning matrix verification completed successfully." -ForegroundColor Green