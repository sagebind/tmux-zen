function zen.help
  set -l b (set_color -o)
  set -l u (set_color -u)
  set -l n (set_color normal)

  echo "Manages your tmux zen environment.

Usage
  $b"zen"$n $u"command"$n [$u"options"$n]

Commands
  $b"config"$n [$u"options"$n]
    Gets or sets tmux zen options. To see detailed usage of `config`, check the
    output of `zen config --help`.

  $b"help"$n
    Displays this help message.

  $b"notify"$n $u"message"$n
    Flash a message in the tmux status bar.

  $b"tmux"$n [$b"-2CluvV"$n] [$b"-c"$n $u"shell-command"$n] [$b"-f"$n $u"file"$n] [$b"-L"$n $u"socket-name"$n] [$b"-S"$n $u"socket-path"$n] [$u"command"$n [$u"flags"$n]]
    Runs the configured tmux application along with any other arguments. The
    binary that is executed is determined by the `tmux-bin` config option. The
    config to use is determined by the `tmux-conf` config option.
"
end
