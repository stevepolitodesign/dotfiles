# Steve Polito's dotfiles

## Prerequisites

### System related

1. Install Xcode Command Line Tools

    ```
    xcode-select --install
    ```

2. Install [Homebrew][homebrew] and dependencies

    ```
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    brew install openssl@3 libyaml gmp rust gh mise fzf bat ripgrep the_silver_searcher perl universal-ctags
    ```

3. Install Ruby and Node globally with Mise

    ```
    mise use -g node@latest
    mise use -g ruby@latest
    ```

4. Install [yarn][yarn]

    ```
    npm install -g corepack
    ```

### Vim related

-   https://github.com/junegunn/vim-plug?tab=readme-ov-file#installation
-   https://formulae.brew.sh/formula/the_silver_searcher
-   https://formulae.brew.sh/formula/ctags#default
-   https://formulae.brew.sh/formula/fzf#default
-   https://github.com/neoclide/coc.nvim

    ```
    :CocInstall coc-json coc-tsserver
    ```

### Terminal related

-   https://starship.rs
-   https://draculatheme.com/iterm
-   https://formulae.brew.sh/cask/font-hack-nerd-font#default

In order to copy from the terminal during a Vim session in Terminal mode, you'll
need to disable "Mouse Reporting" in iTerm2.

Session -> Terminal State -> Mouse Reporting

### Modifiers

Map <kbd>CAPS</kbd> to <kbd>ESC</kbd>

## Installation

The following is extracted from [this article][].

1. Prior to the installation make sure you have committed the alias to `.zshrc`

    ```
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```

2. And that your source repository ignores the folder where you'll clone it, so
   that you don't create weird recursion problems:

    ```
    echo ".dotfiles" >> .gitignore
    ```

3. Now clone your dotfiles into a [bare repository][] in `.dotfiles` in your `$HOME`:

    ```
    git clone --bare  https://github.com/stevepolitodesign/dotfiles.git $HOME/.dotfiles
    ```

4. Define the alias in the current shell scope:

    ```
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```

5. Checkout the actual content from the bare repository to your `$HOME`:

    ```
    config checkout
    ```

6. Set the flag `showUntrackedFiles` to `no` on this specific (local) repository:

    ```
    config config --local status.showUntrackedFiles no
    ```

From now on you can now type `config` commands to add and update your dotfiles:

```
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

If you run into the following error, follow these steps:

```
Username for 'https://github.com': <username>
Password for 'https://stevepolito@hey.com@github.com': <password>
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for 'https://github.com/stevepolitodesign/dotfiles.git/'
```

1. Create a [Personal access token (classic)][token].
2. When prompted for credentials, enter your username and token.

[this article]: https://www.atlassian.com/git/tutorials/dotfiles
[bare repository]: https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server.html#_getting_git_on_a_server
[homebrew]: https://brew.sh
[token]: https://github.com/settings/tokens
[yarn]: https://yarnpkg.com/getting-started/install
