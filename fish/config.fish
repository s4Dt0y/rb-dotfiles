set -U fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x CARGO_TARGET_DIR $HOME/.cargo/shared_target
end
