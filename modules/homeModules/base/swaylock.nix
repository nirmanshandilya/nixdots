{ config, pkgs, ... }: {

  xdg.configFile."swaylock/config".text = ''
    ignore-empty-password
    disable-caps-lock-text
    font=Maple Mono NF
    font-size=48

    # Clock
    clock
    timestr=%H:%M
    datestr=%a, %b %d

    # Indicator
    indicator
    indicator-radius=160
    indicator-thickness=12
    indicator-caps-lock

    # Wallpaper with blur
    image=${config.stylix.image}
    effect-blur=10x3
    effect-vignette=0.3:0.6
    #fade-in=0.2

    # Separator
    separator-color=#00000000

    # Layout
    layout-bg-color=#00000000
    layout-border-color=#00000000
    layout-text-color=#${config.lib.stylix.colors.base05}

    # Text
    text-color=#${config.lib.stylix.colors.base05}
    text-clear-color=#${config.lib.stylix.colors.base0B}
    text-caps-lock-color=#${config.lib.stylix.colors.base0A}
    text-ver-color=#${config.lib.stylix.colors.base0D}
    text-wrong-color=#${config.lib.stylix.colors.base08}

    # Key highlights
    key-hl-color=#ffffffff
    bs-hl-color=#ffffffff
    caps-lock-key-hl-color=#ffffffff
    caps-lock-bs-hl-color=#ffffffff

    # Inside of indicator
    inside-color=#${config.lib.stylix.colors.base00}cc
    inside-clear-color=#${config.lib.stylix.colors.base0B}33
    inside-caps-lock-color=#${config.lib.stylix.colors.base0A}33
    inside-ver-color=#${config.lib.stylix.colors.base0D}33
    inside-wrong-color=#${config.lib.stylix.colors.base08}33

    # Line between inside and ring
    line-color=#${config.lib.stylix.colors.base03}
    line-clear-color=#${config.lib.stylix.colors.base0B}
    line-caps-lock-color=#${config.lib.stylix.colors.base0A}
    line-ver-color=#${config.lib.stylix.colors.base0D}
    line-wrong-color=#${config.lib.stylix.colors.base08}

    # Ring
    ring-color=#${config.lib.stylix.colors.base0E}cc
    ring-clear-color=#${config.lib.stylix.colors.base0B}cc
    ring-caps-lock-color=#${config.lib.stylix.colors.base0A}cc
    ring-ver-color=#${config.lib.stylix.colors.base0D}cc
    ring-wrong-color=#${config.lib.stylix.colors.base08}cc
  '';
}
