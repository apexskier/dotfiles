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

It adds a `dotfiles` command to your `PATH` to manage your dotfiles.

Run `dotfiles` periodically to keep everything up to date.

Run `dotfiles --install` to run system-level installers for various tools. This
will take a while, so it's not automatic.

Run `dotfiles --edit` to open your dotfiles for editing.

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
- **\*.symlink**: Any file ending in `*.symlink` gets symlinked into your
  `$HOME`. This keeps these versioned in your dotfiles while letting them be
  autoloaded by various programs from your home directory. These are symlinked
  when you run `script/bootstrap`.
- **\*.bash**: Files ending in `*.bash` gets sourced into bash (I use bash 5).
  This lets you split up your bash configuration into more logical, topic based
  chunks.
- **appsupport**: This is a map of files that should be linked to macOS's
  application support directory. This is useful for programs like VSCode that
  use this config location.
  
## macOS configuration

I've got most of my must-have applications auto-installed through homebrew and
have some utilities to automatically update the config. See
[`./homebrew`](./homebrew).

I also have a system for automatically syncing macOS system and application
configuration. See [`./macos/defaults`](./macos/defaults/README.md).

## Bash prompt

My bash prompt attempts to balance between minimalism, information, and aesthetics.

The prompt adapts to the context of the current environment and directory. Along with the standard user, hostname, and directory information the prompt also indicates:

* connected over ssh
* git branch
* go version
* in docker container
* kubernetes context
* nodejs version
* readonly cwd
* root user

I use some concurrency to improve the speed of collecting this information.

The prompt is prefixed with the ❯ character, which I feel makes it less likely that a copy/paste will lead to running something unexpectedly.

The informational and input parts of the prompt are split between two lines. This makes the current command and command history easier to read and copy, since commands are less likely to wrap.

```
username@hostname:/current/working/directory (extra) (information)
❯ 
```

I make heavy use of readline's [`.inputrc`](./bash/inputrc.symlink) to make it easier to edit and rerun commands.

## Docker image

A github action maintains a
[docker image](https://github.com/apexskier/dotfiles/packages/158802) I use to
quickly debug docker and kubernetes with a familiar shell and debugging tools.

On `dotfiles --install`, it's tagged locally as `toolbox` and can be started with
`docker run --rm -it toolbox`.

To run in a docker network named `my_network`:

```sh
docker run --rm -it --network=my_network toolbox
```

To try it somewhere else, run

```sh
docker run --rm -it ghcr.io/apexskier/dotfiles/toolbox:latest
```
