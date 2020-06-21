This is some mucking around with sharing macOS preferences

The original idea (and a couple settings) were grabbed from:
https://github.com/mathiasbynens/dotfiles/blob/master/.macos

Preferences internally are stored in plist files, and the `defaults` command writes them. My original `config.sh` script using manual defaults commands, but is hard to keep organized. I'm now storing these as real plist files. They're more diffable, human readable, and domains provide an organization system.

I can't just `defaults –import` because system prefs often contain timestamps or commonly changing lists of recently accessed items.

[`write.sh`](./write.sh) runs through (a) plist file(s) and generates and executes defaults commands for it to merge it into the system settings.

Add the xml attribute `eval=true` to `<string>` nodes to expand bash variables.
  
## Tips

`man defaults` and `man plutil` are very useful.

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

### Plutil

See `man plutil`. It lists valid types. 

Note that these will fully reformat (reorder + strip comments).

Initial creation of a dotfiles plist file

```
plutil -insert Key -type value -o defaults/plists/Domain.plist -- defaults/base.plist
```

Later modification of a dotfiles plist file

- `plutil -insert Key -type value -- defaults/plists/Domain.plist`
- `plutil -replace Key -type value -- defaults/plists/Domain.plist`
- `plutil -remove Key -- defaults/plists/Domain.plist`
