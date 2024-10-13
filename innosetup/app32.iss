[Setup]
AppName=SolaireRS Launcher
AppPublisher=SolaireRS
UninstallDisplayName=SolaireRS
AppVersion=${project.version}
AppSupportURL=https://www.solairers.com/
DefaultDirName={localappdata}\SolaireRS

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/app_small.bmp
WizardImageFile=${basedir}/innosetup/left.bmp
SetupIconFile=${basedir}/innosetup/app.ico
UninstallDisplayIcon={app}\SolaireRS.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=SolaireRSSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x86\SolaireRS.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\SolaireRS.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\SolaireRS\SolaireRS"; Filename: "{app}\SolaireRS.exe"
Name: "{userprograms}\SolaireRS\SolaireRS (configure)"; Filename: "{app}\SolaireRS.exe"; Parameters: "--configure"
Name: "{userprograms}\SolaireRS\SolaireRS (safe mode)"; Filename: "{app}\SolaireRS.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\SolaireRS"; Filename: "{app}\SolaireRS.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\SolaireRS.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\SolaireRS.exe"; Description: "&Open SolaireRS"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\SolaireRS.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.SolaireRS\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"