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
2. Extract the downloaded archive to your preferred place.
3. Run the tool using the executable file.

### System requirements
- PowerShell 5.1
- Windows LAPS PowerShell module
- Optional for changing the timestamp of Microsoft LAPS (legacy) passwords:
  - Microsoft LAPS PowerShell module (AdmPwd module)

### Limitations
- Requires an Active Directory joined machine to work properly.
- Currently Azure AD is not supported.

## Support

If you have any problems or want to suggest a new feature please [fill a bug in this repository](https://github.com/htcfreek/SimpleLapsGui/issues/new).

## Credits

This repository includes scripts (and other files) that where created while my day to day job work. I want to say thank you to my employer who allows me to share them with you (the community).

## Disclaimer

Product names and company names are trademarks (™) or registered (®) trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.

## License

This Repository is licensed to you under the MIT license.<br />
See the [LICENSE](LICENSE.md) file in the project root for more information.