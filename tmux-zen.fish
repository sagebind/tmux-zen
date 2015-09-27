# Initialize the current fish session and connect to the tmux session.
function init --on-event init_tmux-zen
    if not set -q __tmux_session_name
        set -U __tmux_session_name local
    end

    # Connect to the TMUX session if it exists, or create it if it doesn't.
    if begin; [ "$TERM" = "screen" ]; not set -q TMUX; end
        if tmux has-session -t $__tmux_session_name
            exec tmux new-session -t $__tmux_session_name \; set destroy-unattached on \; new-window
        else
            exec tmux new-session -s $__tmux_session_name
        end
    else
        # Set useful tmux variables.
        set -g TMUX_WINDOW (tmux display-message -p '#I')

        # Initialize the session if we didn't already.
        if not set -q __tmux_is_initialized
            __tmux_init
        end
    end
end

function __tmux_set -d "Sets a variable for all tmux windows"
    if not set -q argv[2]
        set argv[2] ""
    end

    # Set the variable for the current window as well as all future windows.
    set -g $argv[1] $argv[2]
    tmux setenv -g -t $__tmux_session_name $argv[1] $argv[2]
end

function __tmux_init -d "Initializes the tmux session and applies user customization"
    # Set a global variable to make sure we only get called once per session.
    __tmux_set __tmux_is_initialized

    if functions -q tmux_init
        tmux_init
    end
end
