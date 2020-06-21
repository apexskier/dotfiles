This is some mucking around with sharing macOS preferences between computers.

The original idea (and a couple settings) were grabbed from:
https://github.com/mathiasbynens/dotfiles/blob/master/.macos

Preferences internally are stored in plist files, and the `defaults` command writes them. My original `config.sh` script using manual defaults commands, but is hard to keep organized. I'm now storing these as real plist files. They're more diffable, human readable, and domains provide an organization system.

I can't just `defaults export` because they often contain timestamps or commonly changing lists of recently accessed items.

[`write.sh`](./write.sh) runs through (a) plist file(s) and generates and executes defaults commands for it to merge it into the system settings.

Add the xml attribute `eval="true"` to `<string>` nodes to expand bash variables.
  
## Tips

### Defaults

Defaults can be difficult to discover, here are some tips:
- https://www.defaults-write.com/
- `defaults read NSGlobalDomain`
  Show global settings (settable with `defaults write -g`)
- `defaults domains | splitlines ', '`
  Show possible setting domains
- `defaults read $DOMAIN`
  Show what's set in a domain
- `defaults read -app $APP`
  Show what's set for an app
- `defaults find "search term"`
- Many of these won't apply until a restart of some process or the full machine

I often will `defaults read $DOMAIN > old.defaults` and diff that after tweaking
preferences in the UI to see what changes and if I can save it.

I'd also like to explore snapshotting defaults and seeing what changes over time
to know what I _shouldn't_ change.

### Plutil

See `man plutil`. It lists valid types. 

Note that these will fully reformat (reorder + strip comments) (so will editing in XCode).

`/usr/libexec/PlistBuddy` is also an option, but it doesn't support piping from stdin and is not as similar to `defaults`.

Initial creation of a dotfiles plist file

```
plutil -insert Key -type value -o defaults/plists/Domain.plist -- defaults/base.plist
```

Later modification of a dotfiles plist file

- `plutil -insert Key -type value -- defaults/plists/Domain.plist`
- `plutil -replace Key -type value -- defaults/plists/Domain.plist`
- `plutil -remove Key -- defaults/plists/Domain.plist`

### Other reading

- `man defaults`
- `man plutil`
- https://scriptingosx.com/2018/02/defaults-the-plist-killer/
- https://shadowfile.inode.link/blog/2018/06/advanced-defaults1-usage/
- Found this after doing the bulk of my own exploration - https://github.com/zcutlip/prefsniff

## Notes

Get domain for an app
```
mdls -name kMDItemCFBundleIdentifier -r App.app
```