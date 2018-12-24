Clear-Host

# Title for your menu system
$title = "Helpdesk Menu"

# Build paths
$scripts = Split-Path -parent $PSCommandPath
# Path to subfolder which contains scripts to go under the "Main Menu"
[array]$mmFiles = get-childItem $scripts\MainMenu | where {($_.name -like "*.ps1") -and (-not($_.basename -like "*test*"))}
# Path to subfolder which contains scripts to go under the "Advanced Menu" - less used, or more resource intensive scripts
[array]$advFiles = get-childItem $scripts\AdvancedMenu | where {($_.name -like "*.ps1") -and (-not($_.basename -like "*test*"))}

# The main menu - most frequently used scripts
Function mainMenu {
	Clear-Host
	# Main Menu Header
	Write-Host "------------------------ $title ------------------------"`n -foregroundcolor green -backgroundcolor darkgray
	# Check if the MainMenu folder contains any scripts
	If ($mmFiles) {
		# Build the menu choices based on all .ps1 files found in $mmFiles
		for ($i=0; $i -le $mmFiles.GetUpperBound(0); $i++){
			Write-Host `t$($i+1)"."($mmFiles[$i].basename) -foregroundcolor white
		}
		# Add the advanced menu option as the last choice
		Write-Host `t$(($mmFiles | measure).count +1)". Advanced Menu"`n -foregroundcolor cyan
		# Prompt for a choice 
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
}

Function advancedMenu {
	Clear-Host
	# Advanced Menu Header
	Write-Host "------------------------ $title ------------------------" -foregroundcolor green -backgroundcolor darkgray
	Write-Host "--------------------------- Advanced  Menu ---------------------------" -foregroundcolor gray -backgroundcolor red
	
	# Check if the advanced folder contains any scripts
	If ($advFiles) {
		# Build the menu choices based on all .ps1 files found in $advFiles
		for ($i=0; $i -le $advFiles.GetUpperBound(0); $i++){
			Write-Host `t$($i+1)"."($advFiles[$i].basename) -foregroundcolor white 
		}
		# Add the Main Menu option as the last choice
		Write-Host `t$(($advFiles | measure).count +1)". Main Menu"`n -foregroundcolor cyan
		# Prompt for a choice 
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
	Else {
		Write-Host `n`t"No scripts in the advanced folder"
		# Prompt to return
		Write-Host `n"Press Enter to return to the Main Menu or any other key to cancel" -foregroundcolor cyan 
		If (($Host.UI.RawUI.ReadKey()).VirtualKeyCode -eq 13){
			mainMenu
		}
		
	}
}

# Call the main menu
mainMenu
