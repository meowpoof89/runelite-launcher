[Setup]
AppName=DalorianScape Launcher
AppPublisher=DalorianScape
UninstallDisplayName=DalorianScape
AppVersion=${project.version}
AppSupportURL=https://dalorian-ceo.com
DefaultDirName={localappdata}\DalorianScape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\DalorianScape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=DalorianScapeSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\DalorianScape.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\DalorianScape.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\DalorianScape\DalorianScape"; Filename: "{app}\DalorianScape.exe"
Name: "{userprograms}\DalorianScape\DalorianScape (configure)"; Filename: "{app}\DalorianScape.exe"; Parameters: "--configure"
Name: "{userprograms}\DalorianScape\DalorianScape (safe mode)"; Filename: "{app}\DalorianScape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\DalorianScape"; Filename: "{app}\DalorianScape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\DalorianScape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\DalorianScape.exe"; Description: "&Open DalorianScape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\DalorianScape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.DalorianScape\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\DalorianScape.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"