#define MyAppName "Simple LAPS GUI"
#define MyAppVersion "2.5"
#define MyAppPublisher "htcfreek"
#define MyAppURL "https://github.com/htcfreek/SimpleLapsGui"
#define EscapeConstArgument(Value) StringChange(StringChange(StringChange(Value, "%", "%25"), ",", "%2c"), "}", "%7d")

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{ACAFC3E6-C03C-43F9-8D30-C964F9074B1E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppMutex=SimpleLAPSGUIApp,Global\SimpleLAPSGUIApp
SetupMutex=SimpleLAPSGUISetup,Global\SimpleLAPSGUISetup
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=..\..\LICENSE.txt
SetupIconFile=..\images\appIcon.ico
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=
SolidCompression=yes
WizardStyle=modern windows11
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\..\Release
OutputBaseFilename=Simple LAPS GUI


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "main"; Description: "Main Files"; Types: full custom; Flags: fixed
Name: "pwsh7"; Description: "PowerShell 7 support"; Types: full
Name: "policy"; Description: "Extract ADMX files"; Types: full

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "eventlog"; Description: "Register event log category"

[Files]
Source: "..\SimpleLapsGui.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Start_SimpleLapsGui.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Start_PS7_SimpleLapsGui.bat"; DestDir: "{app}"; Flags: ignoreversion; Components: pwsh7
Source: "..\images\appIcon.ico"; DestDir: "{app}"; DestName: "SimpleLapsGui.ico"; Flags: ignoreversion
Source: "..\policy\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: policy
Source: "..\..\LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files.

[Run]
Filename: powershell.exe; StatusMsg: "Register event log category ..."; Tasks: eventlog

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"
Name: "{group}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; Components: pwsh7
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"; Tasks: desktopicon
Name: "{autodesktop}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; Components: pwsh7; Tasks: desktopicon

