This is a tool for sharing macOS preferences between computers.

## Usage

Per-domain (~application) settings files are stored as xml formatted plist files in the [`plists`](./plists) directory.

[`write.sh`](./write.sh) runs through plist files and generates and executes defaults commands to apply the settings to your computer.

[`read.sh`](./write.sh) runs through plist files and updates any currently defined preferences in the file with what's on your computer. After running, verify changes in git before committing.

[`clean.sh`](./clean.sh) runs through plist files and formats them (so `read.sh` generates clean diffs).

These commands accept a filepath to run on a single file.

[`import.sh`](./import.sh) takes a domain or a path to an app and generates a full plist file for you. Verify _everything_ in it before committing—most applications store time-specific, computer-specific, or binary data that you probably don't want to store or overwrite.

Add the xml attribute `eval="true"` to `<string>` nodes in the plist files to expand bash variables.

## Notes

In macOS preferences internally are stored in binary plist files, and the `defaults` command writes them. My original `config.sh` script using manual defaults commands, but is hard to keep organized. I'm now storing these as xml plist files. They're more diffable, human readable, and domains provide an organization system.

This _attempts_ to only use builtin macOS tools to have compatibility with your system. Please file an issue if a command it uses is not preinstalled on your computer.

I can't just `defaults export` because they often contain timestamps or commonly changing lists of recently accessed items.

### Exploring defaults

Defaults can be difficult to discover, here are some tips:
- https://macos-defaults.com/
- https://www.defaults-write.com/
- `NSGlobalDomain` are global settings
- `defaults domains | splitlines ', '`
  Show possible setting domains
- `defaults read $DOMAIN`
  Show what's set in a domain
- `defaults read -app $APP`
  Show what's set for an app
- `defaults find "search term"`
- Many of these won't apply until a restart of some process or the full machine

I often will `import.sh`, tweak preferences in a UI, then `read.sh` and `git diff` to see what changes and if I can save it. See https://github.com/zcutlip/prefsniff for a tool that tries to do this automatically.

I'd like to explore snapshotting defaults and seeing what changes over time to know what I _shouldn't_ change. 

### plutil

`plutil` commands will fully reformat (reorder + strip comments) (so will editing in XCode).

`/usr/libexec/PlistBuddy` is also an option, but it doesn't support piping from stdin and is not as similar to `defaults`.

- `plutil -insert Key -type value -- defaults/plists/Domain.plist`
- `plutil -replace Key -type value -- defaults/plists/Domain.plist`
- `plutil -remove Key -- defaults/plists/Domain.plist`

### Other reading

- `man defaults`
- `man plutil`
- https://scriptingosx.com/2018/02/defaults-the-plist-killer/
- https://shadowfile.inode.link/blog/2018/06/advanced-defaults1-usage/
- Found this after doing the bulk of my own exploration - https://github.com/zcutlip/prefsniff
