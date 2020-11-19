function zen -d "Manages your tmux zen environment" -a command
  set -e argv[1]

  switch "$command"
    case '' help -h --help
      zen.help

    case notify
      if not count $argv > /dev/null
        cat ^/dev/null | read -l line
        set argv[1] "$line"
      end

      zen tmux display-message "$argv[1]"

    # Configure tmux zen.
    case config
      config tmux-zen $argv

    # Pass through commands to tmux.
    case tmux
      set -l tmux_bin (config tmux-zen --get tmux-bin --default tmux)
      set -l tmux_conf (config tmux-zen --get tmux-conf --default "$HOME/.tmux.conf")
      eval $tmux_bin -f $tmux_conf "$argv"

    case '*'
      echo "Unknown command `$command'." >&2
      return 1
  end
end
