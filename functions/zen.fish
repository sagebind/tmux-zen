function zen -d "Manages your tmux zen environment" -a command
  set -e argv[1]

  switch "$command"
    case '' help -h --help
      zen.help

    case notify
      if not count $argv > /dev/null
        cat 2>/dev/null | read -l line
        set argv[1] "$line"
      end

      zen tmux display-message "$argv[1]"

    # Configure tmux zen.
    case config
      config tmux-zen $argv

    # Pass through commands to tmux.
    case tmux
      set -l tmux_bin (config tmux-zen --get tmux-bin --default tmux)
      eval $tmux_bin "$argv"

    case '*'
      echo "Unknown command `$command'." >&2
      return 1
  end
end
