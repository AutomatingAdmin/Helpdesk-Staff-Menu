cls
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')
$Host.PrivateData.ErrorBackgroundColor = $bckgrnd
$Host.PrivateData.WarningBackgroundColor = $bckgrnd
$Host.PrivateData.DebugBackgroundColor = $bckgrnd
$Host.PrivateData.VerboseBackgroundColor = $bckgrnd
$Host.PrivateData.ProgressBackgroundColor = $bckgrnd

# Title for your menu system
$title = "Helpdesk Menu"

$scripts = Split-Path -parent $PSCommandPath
# Path to subfolder which contains scripts to go under the "Main Menu"
$mmFiles = get-childItem $scripts\MainMenu | ? {($_.name -like "*.ps1") -and (-not($_.basename -like "*test*"))}
# Path to subfolder which contains scripts to go under the "Advanced Menu" - less used, or more resource intensive scripts
$advFiles = get-childItem $scripts\AdvancedMenu | ? {($_.name -like "*.ps1") -and (-not($_.basename -like "*test*"))}

# The main menu - most frequently used scripts
Function mainMenu {
	cls
	# Main Menu Header
	Write-Host `n`t -backgroundcolor $bckgrnd -nonewline
	Write-Host "------------------------ $title ------------------------"`n -foregroundcolor green -backgroundcolor darkgray

	# Build the menu choices based on all .ps1 files found in $mmFiles
	for ($i=0; $i -le $mmFiles.GetUpperBound(0); $i++){
		Write-Host `t$($i+1)"."($mmFiles[$i].basename) -foregroundcolor blue
	}
	# Add the advanced menu option as the last choice
	Write-Host `t$(($mmFiles | measure).count +1)". Advanced Menu"`n -foregroundcolor red
	# Promt for a choice 
	Write-Host "Please enter a number... " -nonewline

	$choice = Read-Host
	while(1..(($mmFiles | measure).count +1) -Notcontains $choice){
		$choice = Read-Host "Enter a number...Or else"
	}
	if (1..(($mmFiles | measure).count) -contains $choice){
		& ("$scripts\MainMenu\"+$mmFiles[[int]$choice-1].name) ### Run the chosen script
	}
	elseif ($choice -eq ($mmFiles | measure).count +1){
		advancedMenu
	}
}

Function advancedMenu {
	cls
	# Advanced Menu Header
	Write-Host `n`t -backgroundcolor $bckgrnd -nonewline
	Write-Host "------------------------ $title ------------------------" -foregroundcolor green -backgroundcolor darkgray
	Write-Host `t -backgroundcolor $bckgrnd -nonewline
	Write-Host "--------------------------- Advanced  Menu ---------------------------" -foregroundcolor gray -backgroundcolor red
	
	# Build the menu choices based on all .ps1 files found in $advFiles
	for ($i=0; $i -le $advFiles.GetUpperBound(0); $i++){
		Write-Host `t$($i+1)"."($advFiles[$i].basename) -foregroundcolor cyan 
	}
	# Add the Main Menu option as the last choice
	Write-Host `t$(($advFiles | measure).count +1)". Main Menu"`n -foregroundcolor blue
	# Promt for a choice 
	Write-Host "Please enter a number... " -nonewline 

	$choice = Read-Host
	while(1..(($advFiles | measure).count +1) -Notcontains $choice){
		$choice = Read-Host "Enter a number...Or else"
	}
	if (1..(($advFiles | measure).count) -contains $choice){
		& ("$scripts\AdvancedMenu\"+$advFiles[[int]$choice-1].name) ### Run the chosen script
	}
	elseif ($choice -eq ($advFiles | measure).count +1){
		mainMenu
	}

}

# Call the main menu
mainMenu
