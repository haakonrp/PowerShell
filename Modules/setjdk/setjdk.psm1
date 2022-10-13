# show list of installed jdks and let user set new jdk on path
function setjdk {

    $JavaHome = [Environment]::GetEnvironmentVariable('JAVA_HOME', [System.EnvironmentVariableTarget]::Machine)
    $CurrentJavaParent = $JavaHome | Split-Path -Parent
	$CurrentJavaVersion = $JavaHome | Split-Path -Leaf

	$JdkList = Get-ChildItem -Path $CurrentJavaParent -Name
	$Selection = Create-Menu -MenuTitle "Installed JDKs:" -MenuOptions $JdkList
	$SelectedJavaVersion = $JdkList[$Selection]
	$JavaHome = $CurrentJavaParent + "\" + $SelectedJavaVersion
		
	[Environment]::SetEnvironmentVariable('Path', "$JavaHome\bin;$path", [System.EnvironmentVariableTarget]::Process)
	Write-Host -BackgroundColor Green -ForegroundColor Black "`nNew JDK set: $CurrentJavaVersion -> $SelectedJavaVersion"

    try {
		[Environment]::SetEnvironmentVariable('JAVA_HOME', $JavaHome, [System.EnvironmentVariableTarget]::Machine)
    } catch {
        Write-Host -BackgroundColor Red -ForegroundColor Black "Unable to set JDK permanently, try running as admin..."
    }
	
	""
	java -version
	
}

# helper function to create user selectable list
function Create-Menu () {
	
	Param(
		[Parameter(Mandatory=$True)][String] $MenuTitle,
		[Parameter(Mandatory=$True)][array] $MenuOptions
	)

	$MaxValue = $MenuOptions.count - 1
	$Selection = 0
	$EnterPressed = $False
	
	Clear-Host
	
	while($EnterPressed -eq $False) {
		
		Write-Host "$MenuTitle"

		for ($i=0; $i -le $MaxValue; $i++) {
			
			If ($i -eq $Selection) {
				Write-Host -BackgroundColor Cyan -ForegroundColor Black "* $($MenuOptions[$i])  "
			} Else {
				Write-Host "  $($MenuOptions[$i])  "
			}

		}

		$KeyInput = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown").virtualkeycode

		switch($KeyInput) {
			13 {
				$EnterPressed = $True
				Return $Selection
			}

			38 {
				If ($Selection -eq 0) {
					$Selection = $MaxValue
				} Else {
					$Selection -= 1
				}
				Clear-Host
				break
			}

			40 {
				If ($Selection -eq $MaxValue) {
					$Selection = 0
				} Else {
					$Selection += 1
				}
				Clear-Host
				break
			}
			
			default {
				Clear-Host
			}
		}
	}
	
}

Export-ModuleMember -Function setjdk