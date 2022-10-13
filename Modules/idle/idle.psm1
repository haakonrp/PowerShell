# simple idle script to prevent system going to sleep
function idle {
	$wshell = New-Object -ComObject wscript.shell;
	"Press CTRL+C to cancel."
	while ($true) {
		$wshell.SendKeys('+')
		Sleep 60
	}
}

Export-ModuleMember -Function idle