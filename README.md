# ❄️ nixdots

Welcome to my declarative system configuration. This repository contains my personal NixOS and Home Manager setup that I use as my daily driver. Although I rarely use it, this setup has necessary gaming features enabled (thanks to https://github.com/aryanvedd)

## 🖥️ System Overview

* **OS:** NixOS
* **Window Manager:** Niri
* **Shell:** Zsh

## 📂 Repository Structure

I've organized my configurations using flakes to keep hardware-specific settings separated from user-specific environments. Here is how the repository is laid out:
```text
 .
├──  flake.lock
├──  flake.nix
├──  home.nix
├──  modules
│   ├──  homeModules
│   │   └──  base
│   │       ├──  bat.nix
│   │       ├──  git.nix
│   │       ├──  kitty.nix
│   │       ├──  niri
│   │       │   ├──  config
│   │       │   │   ├──  binds.kdl
│   │       │   │   ├──  config.kdl
│   │       │   │   ├──  environment.kdl
│   │       │   │   ├──  input.kdl
│   │       │   │   ├──  output.kdl
│   │       │   │   ├──  spawn-at-startup.kdl
│   │       │   │   └──  window-rule.kdl
│   │       │   └──  default.nix
│   │       ├──  nixTools.nix
│   │       ├──  noctalia
│   │       │   ├──  config.json
│   │       │   ├──  default.nix
│   │       │   └──  wallpapers.json
│   │       ├──  shell.nix
│   │       ├──  starship.nix
│   │       ├──  swaylock.nix
│   │       ├──  waybar.nix
│   │       └──  yazi.nix
│   └──  nixosModules
│       ├──  base
│       │   ├──  locale.nix
│       │   ├──  nix.nix
│       │   ├──  stylix.nix
│       │   └──  users.nix
│       ├──  features
│       │   ├──  gaming.nix
│       │   ├──  greeter.nix
│       │   └──  niri.nix
│       └── 󰀂 hosts
│           └──  nixos
│               ├──  configuration.nix
│               └──  hardware-configuration.nix
└──  README.md
```
