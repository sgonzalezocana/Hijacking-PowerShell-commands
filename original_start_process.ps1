[CmdletBinding(DefaultParameterSetName='Default', HelpUri='https://go.microsoft.com/fwlink/?LinkID=135261')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Alias('PSPath')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${FilePath},

    [Parameter(Position=1)]
    [Alias('Args')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ArgumentList},

    [Parameter(ParameterSetName='Default')]
    [Alias('RunAs')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [ValidateNotNullOrEmpty()]
    [string]
    ${WorkingDirectory},

    [Parameter(ParameterSetName='Default')]
    [Alias('Lup')]
    [switch]
    ${LoadUserProfile},

    [Parameter(ParameterSetName='Default')]
    [Alias('nnw')]
    [switch]
    ${NoNewWindow},

    [switch]
    ${PassThru},

    [Parameter(ParameterSetName='Default')]
    [Alias('RSE')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RedirectStandardError},

    [Parameter(ParameterSetName='Default')]
    [Alias('RSI')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RedirectStandardInput},

    [Parameter(ParameterSetName='Default')]
    [Alias('RSO')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RedirectStandardOutput},

    [Parameter(ParameterSetName='UseShellExecute')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Verb},

    [ValidateNotNullOrEmpty()]
    [System.Diagnostics.ProcessWindowStyle]
    ${WindowStyle},

    [switch]
    ${Wait},

    [Parameter(ParameterSetName='Default')]
    [switch]
    ${UseNewEnvironment})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Start-Process',
        [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Management\Start-Process
.ForwardHelpCategory Cmdlet

#>

