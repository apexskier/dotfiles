if test $(which brew)
then
    echo "Installing command line tools"
    brew bundle `git rev-parse --show-cdup`osx/Brewfile
    echo "Installing apps"
    brew bundle `git rev-parse --show-cdup`osx/Caskfile
    for f in $HOME/Applications/*; do sudo ln -sf "$f" /Applications/; done

    echo "you may want to install xQuartz -> http://xquartz.macosforge.org/landing/"
fi

