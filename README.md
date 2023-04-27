# Simple LAPS GUI  

<!-- Name des Repositories muss immer klein geschrieben werden. -->
<a href="https://github.com/htcfreek/SimpleLapsGui/releases"><img src="https://img.shields.io/github/release/htcfreek/SimpleLapsGui?label=stable+release"/></a> <a href="https://github.com/htcfreek/SimpleLapsGui/releases/latest"><img src="https://img.shields.io/github/release/htcfreek/SimpleLapsGui?include_prereleases&label=latest+release"/></a> <a href="LICENSE.md"><img src="https://img.shields.io/github/license/htcfreek/SimpleLapsGui" /></a>

<a href="https://github.com/htcfreek/SimpleLapsGui/releases"><img src="https://img.shields.io/github/downloads/htcfreek/SimpleLapsGui/total?label=Downloads"/></a> <a href="https://github.com/htcfreek/SimpleLapsGui/stargazers"><img src="https://img.shields.io/github/stars/htcfreek/SimpleLapsGui" /></a> <a href="https://github.com/htcfreek/SimpleLapsGui/watchers"><img src="https://img.shields.io/github/watchers/htcfreek/SimpleLapsGui" /></a> <a href="https://github.com/htcfreek/SimpleLapsGui/network/members"><img src="https://img.shields.io/github/forks/htcfreek/SimpleLapsGui" /></a>

A simple and fast GUI for Microsoft LAPS (legacy) and Windows LAPS. With this tool you can query passwords and change the expiration timestamp.

![Hero image for Simple LAPS GUI](/images/github-social-preview.png)

## Features

- Simple and fast: Run the executable, type the computer name and press the ENTER key.
- Supports Microsoft LAPS (legacy) and Windows LAPS on Active Directory environments.
- Read current password, current expiration timestamp and password history (Windows LAPS only) from the Computer objects in your local Active Directory.
- Copy the passwords (current and history) using the context menu.
- Change the expiration timestamp.
- Close the window by pressing the ESCAPE key.


## Download and Usage

1. Download the archive from [here](http://github.com/htcfreek/SimpleLapsGui/releases).
   - `SimpleLapsGui_v<Version>_Exe.zip`: Exe wrapper version. :exclamation: May produce false-positive virus alerts :exclamation:
   - `SimpleLapsGui_v<Version>_PowerShell.zip`: PowerShell script only version.
2. Extract the downloaded archive to your preferred place.
3. Run the tool using the executable or the PowerShell file.

### System requirements
- PowerShell 5.1
- Windows LAPS PowerShell module
- Optional for changing the timestamp of Microsoft LAPS (legacy) passwords:
  - Microsoft LAPS PowerShell module (AdmPwd module)

### Permissions
The user who uses the tool needs the following permissions:
- Read LAPS password attribute(s).
- Decrypt the Windows LAPS password.
- [Optional:] Change expiration time attribute.

> **Warning**
> As always when granting permissions, you should be careful who you grant them to. You should grant permissions only to those who need them (e.g., use administration tiering).

> **Information**
> For more information please read the docs provided by Microsoft:
> - [Windows LAPS permission concept](https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-concepts#user-group-permissions)
> - [Windows LAPS attributes and rights](https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-technical-reference#extended-rights)
> - [Windows LAPS decryption principal](https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-management-policy-settings#adpasswordencryptionprincipal)
> - [Microsoft LAPS attribute permissions](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-guide-how-to-configure-microsoft-local/ba-p/2806185)

### Limitations
- Currently search works only in computer's domain. ([#3](https://github.com/htcfreek/SimpleLapsGui/issues/3))
- Requires an Active Directory joined machine to work properly.
- Azure AD is not supported.

## FAQ

**Why did you create another LAPS (G)UI?**

1. The existing standalone LAPS UI doesn't support Windows LAPS and the Windows LAPS password history.
2. There is a built-in Windows LAPS tab in the RSAT (Active Directory Users and Computers). But to use this you have to install the RSAT for everyone who should use it. My GUI is small and portable.
3. The LAPS tab in the RSAT (Active Directory Users and Computers) doesn't show the Windows LAPS password history.
4. When using my GUI you don't have to learn the PowerShell modules.

**Does the exe version contains viruses? It is reported on "virustotal.com".**

No it doesn't. This happens because of the AutoIT v3 executable used as wrapper. You can download the PowerShell version instead. (Please note that the PowerShell script doesn't hide its window.)

**Can you support Windows Server 2016?**

No. As long as Microsoft doesn't provide the PowerShell cmdlets on Server 2016, I can't support this OS.

> **Warning**
> You can find instructions on how to change my script to run on Windows Server 2016. But this is not supported by me. All manipulations of the script happens at your own risk!!!

**Why don't you allow side-loading the LAPS module?**

I know that such a feature would make my script usable on Windows Server 2016. But loading PowerShell modules from unknown locations is a potential security risk. And it requires to lower the execution policy level which is a security risk too.

**What notations are supported for the computer name?**

All notations that are supported by the PowerShell module:

- Distinguished Name (begins with a CN=)
- Sam Account Name (begins with a '$")
- DNS Hostname (contains at least one '.' character)
- Name (for all other inputs)

<!--Source: https://learn.microsoft.com/de-de/powershell/module/laps/get-lapsadpassword?view=windowsserver2022-ps#-identity -->

**Why are no passwords found?**

Either you don't have the permission to read them or there are no passwords stored for this computer.

**Why do some computers have no history?**

To have a history it must be enabled and the computer must use Windows LAPS.

**Why is the password not decrypted?**

This happens if you don't have the required permission.

## Support and contributions

If you have any problems or want to suggest a new feature please [fill a bug in this repository](/issues/new).

If you want to report a security vulnerability, please use the form on the [SECURITY](/security) page.

Before contributing to this repository please read the [contributing guidelines](/CONTRIBUTING.md)!!

## Credits

This repository includes scripts (and other files) that where created while my day to day job work. I want to say thank you to my employer who allows me to share them with you (the community).

## Disclaimer

Product names and company names are trademarks (™) or registered (®) trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.

## License

This Repository is licensed to you under the MIT license.<br />
See the [LICENSE](LICENSE.md) file in the project root for more information.
