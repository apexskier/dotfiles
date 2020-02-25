# Homebrew-based installs are separate, but there may still be updates and
# installables in the Mac App Store. There's a nifty command line interface to
# it that we can use to just install everything, so yeah, let's do that.

if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a
