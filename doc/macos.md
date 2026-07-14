# MacOS-Specific Notes/Docs

## Annoying Settings to Change

Mac gives some....interesting defaults sometimes.

### Enable Normal Key Repeat

macOS now opens a key palette when you hold down a key rather than repeating it.
To stop that behavior:

```bash
defaults write -g ApplePressAndHoldEnabled -bool false
```

## Super Special MacOS Configuration

MacOS has a weird `${ZDOTDIR}/.zsh_sessions/` directory it creates when starting
a default Apple Terminal instance. As far as I can tell, it is used for storing
history per terminal session, which isn't a feature I want even if I did use the
default terminal. However, some commands, such as `react-native`, may trigger a
new instance of the Apple Terminal to open and that will still generate the
`.zsh_sessions` directory.

The only way you can disable it is to add the your `/etc/zprofile`:

```bash
# Disable Apple Terminal's session files.
export SHELL_SESSIONS_DISABLE=1
```

## launchd

macOS service manager. `launchd` is the daemon; `launchctl` is the CLI.

### Concepts

- **Agent**: runs in the user session (`~/Library/LaunchAgents/`)
- **Daemon**: runs system-wide (`/Library/LaunchDaemons/`), requires root
- **Label**: unique identifier for the service (e.g. `com.example.myapp`)
- **Domain**: `gui/<uid>` for user agents, `system` for daemons

### Plist location

| Type          | Path                      |
| ------------- | ------------------------- |
| User agent    | `~/Library/LaunchAgents/` |
| Global agent  | `/Library/LaunchAgents/`  |
| System daemon | `/Library/LaunchDaemons/` |

### Lifecycle commands

```bash
# Load and start (persists across reboots with -w)
launchctl load -w ~/Library/LaunchAgents/com.example.myapp.plist

# Unload (stop + remove from launchd)
launchctl unload ~/Library/LaunchAgents/com.example.myapp.plist

# Unload and disable across reboots
launchctl unload -w ~/Library/LaunchAgents/com.example.myapp.plist

# Restart (kill + relaunch in place, no unload/load cycle)
launchctl kickstart -k "gui/$(id -u)/com.example.myapp"

# Check if loaded (exit 0 = yes)
launchctl list com.example.myapp
```

### Modern API (macOS 10.10+)

The `load`/`unload` commands are legacy but still work. The modern equivalents:

```bash
# Load
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.example.myapp.plist

# Unload
launchctl bootout "gui/$(id -u)/com.example.myapp"

# Restart
launchctl kickstart -k "gui/$(id -u)/com.example.myapp"

# Print service details
launchctl print "gui/$(id -u)/com.example.myapp"

# List all disabled services
launchctl print-disabled "gui/$(id -u)"
```

### Minimal plist template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.example.myapp</string>

  <key>ProgramArguments</key>
  <array>
    <string>/path/to/executable</string>
    <string>--flag</string>
  </array>

  <key>RunAtLoad</key>
  <true/>

  <key>KeepAlive</key>
  <dict>
    <key>SuccessfulExit</key>
    <false/>
  </dict>

  <key>StandardOutPath</key>
  <string>/path/to/stdout.log</string>

  <key>StandardErrorPath</key>
  <string>/path/to/stderr.log</string>

  <key>WorkingDirectory</key>
  <string>/path/to/workdir</string>

  <key>ThrottleInterval</key>
  <integer>5</integer>
</dict>
</plist>
```

### Common plist keys

| Key                     | Purpose                                   |
| ----------------------- | ----------------------------------------- |
| `Label`                 | Unique service identifier (required)      |
| `ProgramArguments`      | Command + args as array (required)        |
| `RunAtLoad`             | Start immediately when loaded             |
| `KeepAlive`             | Restart policy (bool or dict)             |
| `ThrottleInterval`      | Min seconds between restarts (default 10) |
| `WorkingDirectory`      | cwd for the process                       |
| `StandardOutPath`       | Redirect stdout to file                   |
| `StandardErrorPath`     | Redirect stderr to file                   |
| `EnvironmentVariables`  | Dict of env vars                          |
| `WatchPaths`            | Start when these paths change             |
| `StartInterval`         | Run every N seconds                       |
| `StartCalendarInterval` | Cron-like schedule                        |

### KeepAlive options

```xml
<!-- Restart on crash only (not clean exit) -->
<key>KeepAlive</key>
<dict>
  <key>SuccessfulExit</key>
  <false/>
</dict>

<!-- Always restart -->
<key>KeepAlive</key>
<true/>

<!-- Only while network is up -->
<key>KeepAlive</key>
<dict>
  <key>NetworkState</key>
  <true/>
</dict>
```

### Logs

launchd itself doesn't rotate logs. Options:

- `newsyslog`: add entry to `/etc/newsyslog.d/`
- Redirect to `/dev/null` and log internally
- Truncate in the startup script before exec

### Troubleshooting

```bash
# Validate plist syntax
plutil -lint ~/Library/LaunchAgents/com.example.myapp.plist

# Check extended attributes (provenance blocks loading)
xattr ~/Library/LaunchAgents/com.example.myapp.plist

# Clear provenance (must run from Terminal.app, not sandboxed shells)
xattr -c ~/Library/LaunchAgents/com.example.myapp.plist

# "Input/output error" on load = provenance or broken symlink
# "Operation not permitted" = SIP or TCC restriction
```

### Provenance (macOS Sequoia+)

Files created by sandboxed or "untrusted" processes get stamped with
`com.apple.provenance`. launchd refuses to load plists with this attribute. The
attribute is inherited from the creating process and cannot be stripped by the
same process tree.

Fix: run `xattr -c <plist>` from Terminal.app (a trusted process). Once loaded,
the service persists across reboots; this is a one-time issue.

### Comparison with systemd

| launchd                   | systemd                   |
| ------------------------- | ------------------------- |
| `launchctl load -w`       | `systemctl enable --now`  |
| `launchctl unload -w`     | `systemctl disable --now` |
| `launchctl kickstart -k`  | `systemctl restart`       |
| `launchctl list <label>`  | `systemctl status`        |
| `~/Library/LaunchAgents/` | `~/.config/systemd/user/` |
| `plutil -lint`            | `systemd-analyze verify`  |
| stdout goes to file       | stdout goes to journal    |

## Coding Setup

### Setup Xcode for iOS Simulator

1. Install Xcode through the
   [Mac AppStore](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
2. Install Xcode Command Line Tools (CLT) with `xcode-select --install`
3. Run Xcode once to 'Install additional required components'

#### Manual CLT Installation

Sometimes `xcode-select --install` doesn't work so it has to be done manually.

1. Go to the
   [Apple App Developer Website](https://developer.apple.com/download/more/) and
   sign in with your Apple ID.
2. Download the CLT `.dmg` that corresponds to your installed Xcode version
3. Once it finishes downloading, double-click the .dmg. You should see a window
   like this appear:
4. Double-click the `.pkg` file and let the installer run.

#### Install Additional Simulators

Xcode only comes with simulators for recent versions of iOS, if you need
additional ones go to `Preferences` then `Components` and select the simulator
versions you want to install.

#### [ios-sim](https://github.com/ios-control/ios-sim)

This step isn’t necessary because Xcode provides the `xcrun` command line tool
that allows you to fully manipulate the simulator. However, it is strongly
recommended because the `xcrun` command, while powerful, is also cumbersome for
basic tasks. Compare these two workflows:

**xcrun:**

```sh
> xcrun simctl boot "iPhone 11"
> xcrun simctl install booted ~/path/to/app/to/install
> open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app
```

**ios-sim:**

```sh
> ios-sim launch ~/path/to/app/to/install --devicetypeid "iPhone-11, 15.5"
```

`ios-sim` creates its own device ID map, which is why the names are different.
These would both boot an `iPhone 11` on `iOS 15.5`.
