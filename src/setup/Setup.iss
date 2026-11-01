#define MyAppName "Simple LAPS GUI"
#define MyAppVersion "2.5"
#define MyAppPublisher "htcfreek"
#define MyAppURL "https://github.com/htcfreek/SimpleLapsGui"
#define MyAppPublisherURL "https://github.com/htcfreek"
#define MyAppUpdateURL "https://github.com/htcfreek/SimpleLapsGui/releases/latest"

#define PowerShellExe "WindowsPowerShell\v1.0\powershell.exe"
#define PowerShellCommandParam "-ExecutionPolicy Bypass -Command"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications. 
; Do not change the guid on new app versions!!
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{ACAFC3E6-C03C-43F9-8D30-C964F9074B1E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppUpdateURL}
UninstallDisplayIcon={app}\SimpleLapsGui.ico
AppMutex=SimpleLAPSGUIApp,Global\SimpleLAPSGUIApp
SetupMutex=SimpleLAPSGUISetup,Global\SimpleLAPSGUISetup
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=..\..\LICENSE.txt
;SetupLogging=yes
;UninstallLogging=yes
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SolidCompression=yes
WizardStyle=modern windows11
OutputDir=..\..\Release
OutputBaseFilename={#MyAppName} {#MyAppVersion}


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Components]
Name: "main"; Description: "Main files"; Types: full custom; Flags: fixed
Name: "pwsh7"; Description: "PowerShell 7 support"; Types: full
Name: "policy"; Description: "Extract ADMX files"; Types: full

[Tasks]
Name: "registerEventlog"; Description: "Register Windows Event Log on this computer"; GroupDescription: "Additional install tasks:"; Flags: checkedonce
Name: "installPolicy"; Description: "Install the ADMX files on this computer after extraction"; GroupDescription: "Additional install tasks:"; Components: policy; Flags: unchecked
Name: "desktopicon"; Description: "Create desktop shortcuts"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files.
Source: "..\SimpleLapsGui.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Start_SimpleLapsGui.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Start_PS7_SimpleLapsGui.bat"; DestDir: "{app}"; Flags: ignoreversion; Components: pwsh7
Source: "..\images\appIcon.ico"; DestDir: "{app}"; DestName: "SimpleLapsGui.ico"; Flags: ignoreversion
Source: "..\..\LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\policy\*"; DestDir: "{app}\Administrative Templates"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: policy
Source: "..\policy\*"; DestDir: "{win}\PolicyDefinitions"; Flags: ignoreversion; Components: policy; Tasks: installPolicy
Source: "..\policy\en-us\*"; DestDir: "{win}\PolicyDefinitions\en-us"; Flags: ignoreversion; Components: policy; Tasks: installPolicy

[Run]
Filename: "{sys}\{#PowerShellExe}"; Parameters: "{#PowerShellCommandParam} \
  ""if ((Get-EventLog -LogName *).Log -notcontains 'Simple LAPS GUI') {{ \
  try {{ New-EventLog -LogName 'Simple LAPS GUI' -Source 'Simple LAPS GUI' -ErrorAction Stop -WarningAction Stop } \
  catch {{ Write-Host 'Failed to initialize logging! Please restart with administrative permissions.'  exit 501 } } exit 5"""; \
  StatusMsg: "Register event log category ..."; Flags: runhidden logoutput dontlogparameters; Tasks: registerEventlog

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"; IconFilename: "{app}\SimpleLapsGui.ico"
Name: "{group}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; IconFilename: "{app}\SimpleLapsGui.ico"; Components: pwsh7
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"; IconFilename: "{app}\SimpleLapsGui.ico"; Tasks: desktopicon
Name: "{autodesktop}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; IconFilename: "{app}\SimpleLapsGui.ico"; Components: pwsh7; Tasks: desktopicon

