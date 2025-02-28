# Dotfiles
- To clone:
    1. Attempt to clone the bare repo and setup working tree for dotfiles
        ```bash
        # Clones the bare repo
        git clone --bare https://github.com/brandongevat/dotfiles $HOME/.dotfiles
        # Sets up dotfiles alias for interacting with git for this repository & seperate working tree 
        alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
        # Attempts to take the files tracked in Git and places them in the working tree
        dotfiles checkout
        ```
        - If you run into conflicts:
            ```bash
            mkdir -p ~/.dotfiles-backup
            # Move the files that get replaced by git to backup location
            dotfiles checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv ~/{} ~/.dotfiles-backup/{}
            # Take the files tracked in Git and places them in the working tree
            dotfiles checkout
            ```
    2. Hide untracked files
        ```bash
        # Necessary if you don't want to blow up your git with more than you would like to show everyone
        dotfiles config --local status.showUntrackedFiles no
        ```

- To update:
    ```bash
    # Updates the commit referenced in this dotfiles repo
    git pull --recurse-submodules
    # Fetch the latest commits from the upstream submodule repo
    git submodule update --remote --recursive
    ```
