# Cameron Little's dotfiles

For the real readme, check out [@holman's
dotfiles](https://github.com/holman/dotfiles).

This was original forked from his repository, but due to some limitations of
forked repositories on github I've unforked.

I'm using a variation of his system to organize and propagate my configurations
across machines. The actual contents were inspired from a multitude of sources.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/apexskier/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files and file types in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **appsupport**: This is a map of files that should be linked to macOS's
  application support directory. This is useful for programs like VSCode that
  use this config location.

## install

Run this:

```sh
git clone https://github.com/apexskier/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.
