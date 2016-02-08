# Initialize the current fish session and connect to the tmux session.
function init --on-event init_tmux-zen
  # If we're running in a superuser shell, do nothing.
  if test $USER = root
    return 0
  end

  # Connect to the TMUX session if it exists, or create it if it doesn't.
  if not set -q TMUX
    set -l tmux_bin (config tmux-zen --get tmux-bin --default tmux)
    set -l session_name (config tmux-zen --get session-name --default local)

    if eval "$tmux_bin has-session -t $session_name"
      eval "exec $tmux_bin -2 new-session -t $session_name \\; set destroy-unattached on \\; new-window"
    else
      eval "exec $tmux_bin -2 new-session -s $session_name"
    end
  end

  # Initialize the session if we didn't already.
  if not set -q ZEN_SESSION_INITIALIZED
    # Set a global variable to make sure we only get called once per session.
    set -g ZEN_SESSION_INITIALIZED true
    zen tmux setenv -g ZEN_SESSION_INITIALIZED true

    # Emit the init event. This by default triggers the default init code, but
    # can also be captured by the user.
    emit zen.init
  end
end

function zen.init --on-event zen.init
  config tmux-zen --query events.init
    and eval (config tmux-zen --get events.init)
end
