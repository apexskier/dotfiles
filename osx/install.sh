if test $(which brew)
then
    echo "Installing command line tools"
    brew install vim
    brew install mercurial
    brew install tmux
    brew install wget
    brew install bash-completion
    brew install cmake
    brew install git bash-completion

    echo "Installing cask"
    brew tap caskroom/cask
    brew install caskroom/cask/brew-cask

    echo "Installing apps"
    brew cask install dropbox
    brew cask install handbrake
    brew cask install iterm2
    brew cask install coda
    brew cask install transmit
    brew cask install utorrent
    brew cask install minecraft
    brew cask install caffeine
    brew cask install onepassword
    brew cask install colloquy
fi

