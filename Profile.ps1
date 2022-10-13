Import-Module posh-git
Import-Module idle
Import-Module setjdk

# git posh settings
$GitPromptSettings.DefaultPromptPath.ForegroundColor = 'Orange'
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
$GitPromptSettings.DefaultPromptPrefix.Text = '[$(Get-Date -f "HH:mm")] '
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'