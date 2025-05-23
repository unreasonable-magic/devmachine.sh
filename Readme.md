> [!IMPORTANT]
> This project is under active development and I'd love to collab with you on it!
> If anything here tickles your fancy, email me devmachine@unreasonable-magic.email and I'll send you an invite to a private chat server I have.
> I also stream me working on this on Twitch here https://twitch.tv/magickeith
> <3 Keith


# devmachine.sh

`devmachine` is a new way of managing tools and dotfiles on your dev machine.

After a fresh install, there are 2 main tasks to get a machine ready for coding: 1) install stuff, then 2) configure stuff. #1 is easy and handled by tools like pacman and homebrew. But there's a real disconnect between installing and dotfile management. The "best practice" is to just throw all the dots up on GitHub, symlink some stuff, and call it a day (hell, that's what I used to do http://github.com/keithpitt/dotfiles/) but the issue is that after a while, that config starts to drift, you add things, remove things, and it eventually becomes the "junk drawer" for your stuff.

Keeping dotfiles in sync across machines is also a bit of a challenge (not a challenge that this project is taking on right way) but the main purpose here, is to provide a framework/layout of how to better organize the tools you "care about". Do I care about Postgres config? No. Redis? No. Vim? Yes. Ghostty? Yes. The tools I drive on a daily basis are highly tuned to my workflow, so they should be treated better, not just have their configs thrown in a repo.

## How it works

`devmachine` supports both zsh and bash (3.2+). devmachine takes over the entire bootstrap process of your shell. Each tool defines it's own `shellenv` that's injected into the shell boot process. This means instead of cluttering your `.bashrc` and `.zshrc` files with a bunch of random stuff, this is all you need:

```
export DEVMACHINE_PATH="/Users/keithpitt/Code/devmachine"
eval "$($DEVMACHINE_PATH/bin/devmachine +shellenv $(which ${0#-}))"
```

(The above can be automatically added by running `devmachine +init`, which will also take a backup of existing files if you have them)

This repo currently merges the tooling as well as my own dev configuration. At some point I'll split them, but this is the way it is for now.

Here's how it all works:

1) `devmachine` is the main control for all the tools
2) You create "devfiles" and pass them to `devmachine`

Running `devmachine` will list all the tools installed:

```
$ devmachine +installed
bash 5.2.37(1)-release
bat 0.25.0
btop btop
curl 8.7.1
delta 0.18.2
docker 28.1.1,
fastfetch 2.43.0
yazi 25.4.8
zip 3.0
zoxide 0.9.7
zsh 5.9
```

The tools I care about are listed in the `tools/` folder.

Each tool is a bash script that looks like this:

```
#!/usr/bin/env devmachine

GHOSTTY_CONFIG_PATH="${GHOSTTY_CONFIG_PATH:-$HOME/.config/ghostty}"

case "$1" in

  logo)
    ui::image "$DEVMACHINE_PATH/tools/ghostty/logo.png" 17 10
    ;;

  setup)
    os::install "ghostty"

    # https://github.com/ghostty-org/ghostty/pull/1102/files
    os::sh touch "$HOME/.hushlogin"

    os::linkfile "$DEVMACHINE_PATH/tools/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  config)
    "$EDITOR" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  --check-installed)
    command -v ghostty &> /dev/null && echo yes
    ;;

  --check-version)
    ghostty --version | head -n 1 | sed 's/Ghostty //'
    ;;

esac
```

It's basically a bash case statement with various actions against the tool. When you run `devmachine ghostty` on your machine, it shows this:

![devmachine ghostty](/docs/ghostty.png)

Prety cool!

That's all it does for now. I haven't run the tooling against my arch linux setup yet, so I'd like to get hyprland and waybar all in here. Then split out the tooling from my config, then I can ship it so everone can use it!

You can use it now if you want, but it's very custom to me.

Here's the CLI:

```
     _                                 _     _
  __| | _____   ___ __ ___   __ _  ___| |__ (_)_ __   ___
 / _` |/ _ \ \ / / '_ ` _ \ / _` |/ __| '_ \| | '_ \ / _ \
| (_| |  __/\ V /| | | | | | (_| | (__| | | | | | | |  __/
 \__,_|\___| \_/ |_| |_| |_|\__,_|\___|_| |_|_|_| |_|\___|

Devfiles:
  devmachine NAME|PATH [ACTION]
  devmachine +all [ACTION]
  devmachine +installed [ACTION]
  devmachine +notinstalled [ACTION]

Setup:
  devmachine +init
  devmachine +adopt PATH

Troubleshooting:
  devmachine +config [KEY]
  devmachine +help
  devmachine +version
```

## Caching

devmachine caches all the shell setup so subsequent runs are fast. On a cold start (for me at least) my shell takes around 100ms to start. From cached, it's about 10ms. If things get weird, run `devmachine cachebust`
