# Steve Polito's dotfiles

## Installation

The following is extracted from [this article][].

1. Prior to the installation make sure you have committed the alias to `.vshrc` 

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

[this article]: https://www.atlassian.com/git/tutorials/dotfiles
[bare repository]: https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server.html#_getting_git_on_a_server

## Prerequisites

- https://formulae.brew.sh/formula/ctags#default
- https://formulae.brew.sh/formula/fzf#default

## Terminal

- https://starship.rs
- https://draculatheme.com/iterm
- https://formulae.brew.sh/cask/font-hack-nerd-font#default

## Modifiers

Map <kbd>CAPS</kbd> to <kbd>ESC</kbd>
