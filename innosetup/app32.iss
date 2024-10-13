[Setup]
AppName=Sosrs Launcher
AppPublisher=Sosrs
UninstallDisplayName=Sosrs
AppVersion=${project.version}
AppSupportURL=https://www.solairers.com/
DefaultDirName={localappdata}\Sosrs

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/app_small.bmp
WizardImageFile=${basedir}/innosetup/left.bmp
SetupIconFile=${basedir}/innosetup/app.ico
UninstallDisplayIcon={app}\Sosrs.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=SosrsSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x86\Sosrs.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\Sosrs.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Sosrs\Sosrs"; Filename: "{app}\Sosrs.exe"
Name: "{userprograms}\Sosrs\Sosrs (configure)"; Filename: "{app}\Sosrs.exe"; Parameters: "--configure"
Name: "{userprograms}\Sosrs\Sosrs (safe mode)"; Filename: "{app}\Sosrs.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Sosrs"; Filename: "{app}\Sosrs.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Sosrs.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Sosrs.exe"; Description: "&Open Sosrs"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Sosrs.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.sosrs\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"