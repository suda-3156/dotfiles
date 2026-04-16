-- 1. Get the current path from Finder
tell application "Finder"
    if exists Finder window 1 then
        set targetDir to POSIX path of (target of Finder window 1 as alias)
    else
        set targetDir to POSIX path of (path to desktop folder as alias)
    end if
end tell

-- 2. Pass the path to Ghostty and handle tmux
tell application "Ghostty"
    activate

    -- Fallback: If Ghostty is open but has no windows, create one directly in the target directory.
    if (count of windows) is 0 then
        set cfg to new surface configuration
        set initial working directory of cfg to targetDir
        set win to new window with configuration cfg
        set currentTerm to focused terminal of selected tab of win

				-- Creates the session if missing, OR adds a new window if it exists.
        set shellCmd to "tmux new-session -d -s tmp -c " & quoted form of targetDir & " 2>/dev/null || tmux new-window -t tmp -c " & quoted form of targetDir & "; tmux attach-session -t tmp"
				send key "enter" to currentTerm
        return
    end if

    -- Target the active terminal pane in the frontmost window
    set currentTerm to focused terminal of selected tab of front window

		-- The following doesn't work as expected, it seems that we should send "d" key not to currentTerm but to tmux
		-- send key "space" modifiers "control" to currentTerm
		-- send key "d" to currentTerm
		-- Send current process to background and suspend it if exists
		-- ISSUE: When using Neovim outside of tmux in Ghostty, Ctrl+Z is not sent properly.
		send key "z" modifiers "control" to currentTerm
    delay 0.3

		-- Fix:
    -- 1. Try creating session 'tmp'. If it fails (exists), create a new window in 'tmp'.
    -- 2. Switch to it (if inside tmux) or attach (if outside).
    -- 3. The `fg` will trigger automatically when you eventually detach from tmux.
    set shellCmd to "tmux new-session -d -s tmp -c " & quoted form of targetDir & " 2>/dev/null || tmux new-window -t tmp -c " & quoted form of targetDir & "; tmux switch-client -t tmp 2>/dev/null && fg || tmux attach-session -t tmp"
		input text shellCmd to currentTerm
    send key "enter" to currentTerm
end tell

