{ ... }:

{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };

    shellAliases = {
      ll = "ls -l";
    };

    initExtra = ''
      source ${ ./config/p10k.zsh }
      export KEYTIMEOUT=1
      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""

      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down

      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char
    '';
  };
}
