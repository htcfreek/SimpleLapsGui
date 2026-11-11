[Code]
const PowerShellExe = '\system32\WindowsPowerShell\v1.0\powershell.exe';
const PowerShellCommandParam = '-NonInteractive -NoProfile -NoLogo -WindowStyle Hidden -ExecutionPolicy Bypass -Command';
const CheckEventLogParam = ' "if ((Get-EventLog -LogName *).Log -contains ''Simple LAPS GUI'') { \
     Exit 700 }"';
const RegisterEventLogParam = ' "if ((Get-EventLog -LogName *).Log -notcontains ''Simple LAPS GUI'') { \
    try { New-EventLog -LogName ''Simple LAPS GUI'' -Source ''Simple LAPS GUI'' -ErrorAction Stop -WarningAction Stop } \
    catch { exit 501 } }"';
const RemoveEventLogParam = ' "if ((Get-EventLog -LogName *).Log -contains ''Simple LAPS GUI'') { \
    try { Remove-EventLog -LogName ''Simple LAPS GUI'' -ErrorAction Stop -WarningAction Stop } \
    catch { exit 501 } }"';

var
  EvtLogChecked: Boolean;
  EvtLogCheckedResult: Boolean;

function IsEventLogRegistered: Boolean;
var
    CheckResult: Integer;
begin
  if not EvtLogChecked then begin
    Log('Check if Windows Event Log is registered...')
    Exec(GetEnv('Windir') + PowerShellExe, PowerShellCommandParam + CheckEventLogParam, '', SW_HIDE, ewWaitUntilTerminated, CheckResult)
    EvtLogChecked := True;
    if CheckResult = 700 then begin
      Log('Windows Event Log is registered.')
      EvtLogCheckedResult := False
    end
    else begin
      Log('Windows Event Log is not registered.')
      EvtLogCheckedResult := True
    end;
  end;
  Result := EvtLogCheckedResult;
end;


function PrepareToInstall(var NeedsRestart: Boolean): String;
  var
    ResultCode: Integer;
  begin
    NeedsRestart := False;
    // Detect if not selected
    if IsUninstaller() then begin
      Result := '';
      Exit
    end;
    if not WizardIsTaskSelected('registerEventlog') then begin
      Result := '';
      Exit
    end;
    // Execute command
    Log('Task *Register Windows Event Log on this computer* is selected. Executing registration...')
    if Exec(GetEnv('Windir') + PowerShellExe, PowerShellCommandParam + RegisterEventLogParam, '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    begin
      if ResultCode = 0 Then begin
        Log('Windows Event Log successfully registered.')
        Result := '';
        Exit
      end
      else begin
        Log('Failed to register Windows Event Log!')
        Log('PowerShell exit code: ' + IntToStr(ResultCode))
        Result := 'Failed to register Windows Event Log!'
        Exit
      end;
    end
    else begin
      Log('Failed to register Windows Event Log!')
      Log('ErrorCode: ' + IntToStr(ResultCode) + ' (' + SysErrorMessage(ResultCode) + ')')
      Result := 'Failed to register Windows Event Log!'
      Exit
    end;
  end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
    UninstallResultCode: Integer;
    DoRemoveEventLog: Boolean;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    // Evaluate
    if not UninstallSilent() then begin
      DoRemoveEventLog := MsgBox('Remove Windows Event Log of Simple LAPS GUI?', mbConfirmation, MB_YESNO) = IDYES
    end
    else begin
      DoRemoveEventLog := Pos('/RemoveEventLog', GetCmdTail()) > 0
    end;
    // Execute command
    if (DoRemoveEventLog) then begin
      Log('Task *Remove Windows Event Log on this computer* is selected. Executing...')
      Exec(GetEnv('Windir') + PowerShellExe, PowerShellCommandParam + RemoveEventLogParam, '', SW_HIDE, ewWaitUntilTerminated, UninstallResultCode)
      Log('Result of removing Windows Event Log on this computer: ' + IntToStr(UninstallResultCode))
    end;
  end;
end;