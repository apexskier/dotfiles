if test $(which brew)
then
    echo "Installing command line tools"
    brew bundle `git rev-parse --show-cdup`osx/Brewfile
    echo "Installing apps"
    brew bundle `git rev-parse --show-cdup`osx/Caskfile
fi

