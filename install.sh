if [ ! -f ~/.bash_profile ]; then
  echo "Creating ~/.bash_profile"
  touch ~/.bash_profile
fi

if [ -z "$(git config --global user.email)" ]; then
    echo "Git email not found."
    read -p "Enter your email address on Github: " github_email
    git config --global user.email "$github_email"
fi

if [ -z "$(git config --global user.name)" ]; then
    echo "Git name not found."
    read -p "Enter your name address on Github: " github_name
    git config --global user.name "$github_name"
fi

if [ -d ~/.dotfiles ]; then
  LAST_DIR=$(pwd)
  echo "Directory ~/.dotfiles found, rebasing..."
  cd ~/.dotfiles
  # git pull --rebase origin main
  cd $LAST_DIR
else
  echo "Cloning git@github.com:guivahl/dotfiles.git into ~/.dotfiles"
  git clone git@github.com:guivahl/dotfiles.git ~/.dotfiles
fi

export DOTFILES=~/.dotfiles

source $DOTFILES/macos/install
source $DOTFILES/git/setup
source $DOTFILES/terminal/setup

echo ""
echo "Git setup..."
git_setup

echo ""
echo "Terminal setup..."
terminal_setup


echo ""
echo "Installing homebrew..."
brew_setup

echo ""
echo "Installing MacOS software... "
macos_install

