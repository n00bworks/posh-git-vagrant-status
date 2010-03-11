Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Git utils
. ./GitUtils.ps1
. ./GitPrompt.ps1

Pop-Location

function prompt {
  Write-Host($pwd) -nonewline
    
	# Git Prompt
	$Global:GitStatus = Get-GitStatus
  Write-GitStatus $GitStatus
  
	return "> "
}

function TabExpansion($line, $lastWord) {
  $LineBlocks = [regex]::Split($line, '[|;]')
  $lastBlock = $LineBlocks[-1] 
  
  switch -regex ($lastBlock) {
    'git (.*)' { gitTabExpansion($lastBlock) }  # Execute git tab completion for all git-related commands
  }
}