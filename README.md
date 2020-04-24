# Cameron Little's dotfiles

This was original forked from [@holman's dotfiles](https://github.com/holman/dotfiles),
but due to some limitations of forked repositories on GitHub I've unforked.

I'm using a variation of his system to organize and propagate my configurations
across machines. The actual contents were inspired from a multitude of sources
which I've tried to attribute inline.

## Setup

Run this:

```sh
git clone https://github.com/apexskier/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory
and configure your machine, which may require your input. Everything is
configured and tweaked within that `~/.dotfiles` folder.

It adds a `dot` command to your `PATH` to manage your dotfiles.

Run `dot` periodically to keep everything up to date.

Run `dot --install` to run system-level installers for various tools. This
will take a while, so it's not automatic.

Run `dot --edit` to open your dotfiles for editing.

## What's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/apexskier/dotfiles/fork), remove what you don't
use, and build on what you do use.

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "SNOBOL" — you can simply add a `snobol` directory and
put files in there.

There's a few special files and file types in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **\*.bash**: Files ending in `*.bash` gets sourced into bash. This lets
  you split up your bash configuration into more logical, topic based chunks.
- **appsupport**: This is a map of files that should be linked to macOS's
  application support directory. This is useful for programs like VSCode that
  use this config location.

