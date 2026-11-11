#include <.\Code.iss>

// Custom uninstall parameter: /RemoveEventLog

#define MyAppName "Simple LAPS GUI"
#define MyAppVersion "1.0"
#define MyAppURL "https://github.com/htcfreek/SimpleLapsGui"
#define MyAppPublisher "htcfreek"
#define MyAppPublisherURL "https://github.com/htcfreek"
#define MyAppUpdateURL "https://github.com/htcfreek/SimpleLapsGui/releases/latest"

#define CurrentYear        GetDateTimeString('yyyy','','')
#define MyAppCopyright     "(c) " + CurrentYear + " " + MyAppPublisher


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
AppMutex=SimpleLAPSGUIApp,Global\SimpleLAPSGUIApp

SetupMutex=SimpleLAPSGUISetup,Global\SimpleLAPSGUISetup
LicenseFile=..\..\LICENSE.txt
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
UninstallDisplayIcon={app}\SimpleLapsGui.ico

; Setup version info
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoCompany={#MyAppPublisher}

; Setup behavior and layout
;SetupLogging=yes
;UninstallLogging=yes
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SolidCompression=yes
WizardStyle=windows11
DisableWelcomePage=no
WizardImageFile=setup-large.bmp
WizardSmallImageFile=setup-small.bmp

OutputDir=..\..\Release
OutputBaseFilename={#MyAppName} {#MyAppVersion}


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Components]
Name: "main"; Description: "Main files"; Types: full custom; Flags: fixed
Name: "pwsh7"; Description: "PowerShell 7 support"; Types: full
Name: "policy"; Description: "Extract ADMX files"; Types: full

[Tasks]
Name: "registerEventlog"; Description: "Register Windows Event Log on this computer"; GroupDescription: "Additional install tasks:"; Check: IsEventLogRegistered
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
Filename: "{#MyAppURL}/blob/main/README.md"; Description: "View the README on GitHub"; Flags: shellexec postinstall nowait runasoriginaluser skipifsilent
Filename: "{#MyAppURL}/releases/{#MyAppVersion}"; Description: "See what's new on GitHub"; Flags: shellexec postinstall nowait runasoriginaluser skipifsilent

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"; IconFilename: "{app}\SimpleLapsGui.ico"
Name: "{group}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; IconFilename: "{app}\SimpleLapsGui.ico"; Components: pwsh7
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Start_SimpleLapsGui.bat"; IconFilename: "{app}\SimpleLapsGui.ico"; Tasks: desktopicon
Name: "{autodesktop}\{#MyAppName} (PowerShell 7)"; Filename: "{app}\Start_PS7_SimpleLapsGui"; IconFilename: "{app}\SimpleLapsGui.ico"; Components: pwsh7; Tasks: desktopicon

