# MacOS-Specific Notes/Docs

## Annoying Settings to Change

Mac gives some....interesting defaults sometimes.

- TBD

## Super Special MacOS Configuration

MacOS has a weird `${ZDOTDIR}/.zsh_sessions/` directory it creates when
starting a default Apple Terminal instance. As far as I can tell, it is used
for storing history per terminal session, which isn't a feature I want even if
I did use the default terminal. However, some commands, such as
`react-native`, may trigger a new instance of the Apple Terminal to open
and that will still generate the `.zsh_sessions` directory.

The only way you can disable it is to add the your `/etc/zprofile`:

```bash
# Disable Apple Terminal's session files.
export SHELL_SESSIONS_DISABLE=1
```

## Setup Xcode for iOS Simulator

1. Install Xcode through the [Mac
   AppStore](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
2. Install Xcode Command Line Tools (CLT) with `xcode-select --install`
3. Run Xcode once to 'Install additional required components'

### Manual CLT Installation

Sometimes `xcode-select --install` doesn't work so it has to be done manually.

1. Go to the [Apple App Developer
   Website](https://developer.apple.com/download/more/) and sign in with your
   Apple ID.
2. Download the CLT `.dmg` that corresponds to your installed Xcode version
3. Once it finishes downloading, double-click the .dmg. You should see a window
   like this appear:
4. Double-click the `.pkg` file and let the installer run.

### Install Additional Simulators

Xcode only comes with simulators for recent versions of iOS, if you need
additional ones go to `Preferences` then `Components` and select the simulator
versions you want to install.

### [ios-sim](https://github.com/ios-control/ios-sim)

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
