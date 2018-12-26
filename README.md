# Helpdesk Staff Menu
Dynamic menu system for PowerShell scripts used by helpdesk staff. <br />
This provides a default main menu for your most frequently used scripts. <br />
There is also a choice for an advanced menu, useful for scripts that are used less often or are resource intensive.<br />
<br />
##### Main menu example
![File Structure](https://github.com/AutomatingAdmin/Helpdesk-Staff-Menu/blob/master/screenshots/structure.png?raw=true)
![Main Menu Example](https://github.com/AutomatingAdmin/Helpdesk-Staff-Menu/blob/master/screenshots/Main%20Menu%20Screenshot.png?raw=true)
<br />
##### Advanced menu example
![Advanced Menu Example](https://github.com/AutomatingAdmin/Helpdesk-Staff-Menu/blob/master/screenshots/Advanced%20Menu%20Screenshot.png?raw=true)

## INSTALLATION
Create this script in a folder accessible to all those who need to use it. <br />
Within the folder create 2 more folders: `MainMenu` and `Advanced`. <br />
Copy or create all .ps1 files youd like to be accessible through this menu in either of the subfolders you created. <br />

## USAGE
Call this script to load the main menu. <br />
For helpdesk staff its advisable to have them create an alias to this in their PowerShell profile.<br />
Any .ps1 files that contain the word "test" anywhere in their filename will not be displayed in the menu.<br />
This is helpful if you want to test scripts where they will be living before making them avaialble to users.<br />
Though if you need to use the word test in your filename you can change it in the following line for the `$mmFiles` and `$advFiles` variables.<br />
```powershell
  get-childItem $scripts\MainMenu | where {($_.name -like "*.ps1") -and (-not($_.basename -like "*test*"))}
```
