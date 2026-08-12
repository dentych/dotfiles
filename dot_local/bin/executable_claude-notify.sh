#!/bin/bash
# Claude Code Notification/Stop hook -> desktop notification.
#
# Stays quiet when the Claude pane is already on screen in a focused terminal.
# That check needs 'focus-events on' in tmux.conf: with it off tmux never asks
# the terminal for focus reports, so every client reports itself as focused.

set -u

payload=$(cat)

field() { printf '%s' "$payload" | jq -r "$1 // empty" 2>/dev/null; }

event=$(field '.hook_event_name')
ntype=$(field '.notification_type')
message=$(field '.message')
cwd=$(field '.cwd')
session_id=$(field '.session_id')

case "$ntype" in
	auth_success | elicitation_complete | elicitation_response) exit 0 ;;
esac

tsession=
twindow=

pane=${TMUX_PANE:-}
if [[ -n ${TMUX:-} && -n $pane ]]; then
	info=$(tmux display-message -p -t "$pane" \
		'#{window_active}|#{pane_active}|#{window_zoomed_flag}|#{session_name}|#{window_index}|#{pane_tty}' \
		2>/dev/null) || info=
	IFS='|' read -r win_active pane_act zoomed tsession twindow pane_tty <<<"$info"

	# On screen = its window is the session's current one, and it isn't hidden
	# behind some other pane that has been zoomed.
	if [[ ${win_active:-0} == 1 ]] &&
		{ [[ ${pane_act:-0} == 1 ]] || [[ ${zoomed:-0} != 1 ]]; } &&
		tmux list-clients -t "$tsession" -F '#{client_flags}' 2>/dev/null | grep -q focused; then
		exit 0
	fi

	# Ring the pane ourselves so monitor-bell flags the window in the status bar.
	# Claude Code's own bell stays quiet whenever it sees the pane focused, which
	# is now most of the time — focus-events on means it actually gets told.
	[[ -n ${pane_tty:-} ]] && printf '\a' >"$pane_tty" 2>/dev/null
fi

title="claude"
[[ -n $cwd ]] && title="claude · $(basename "$cwd")"

body=$message
if [[ -z $body ]]; then
	case "$event" in
		Stop) body="Turn finished" ;;
		*) body="Claude needs you" ;;
	esac
fi

where=
[[ -n $tsession && -n $twindow ]] && where="tmux ${tsession}:${twindow}"

if [[ $(uname) == Darwin ]]; then
	if command -v terminal-notifier >/dev/null 2>&1; then
		click="open -b org.alacritty"
		tmux_bin=$(command -v tmux || true)
		[[ -n $tmux_bin && -n $tsession ]] &&
			click="$tmux_bin select-window -t '${tsession}:${twindow}' 2>/dev/null; $click"

		args=(-title "$title" -message "$body" -execute "$click")
		[[ -n $where ]] && args+=(-subtitle "$where")
		# One slot per session, so a later ping replaces the stale one.
		args+=(-group "claude-${session_id:-default}")

		terminal-notifier "${args[@]}" >/dev/null 2>&1
	else
		esc() { printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'; }
		script="display notification \"$(esc "$body")\" with title \"$(esc "$title")\""
		[[ -n $where ]] && script="$script subtitle \"$(esc "$where")\""
		osascript -e "$script" >/dev/null 2>&1
	fi
elif command -v notify-send >/dev/null 2>&1; then
	[[ -n $where ]] && body="$body — $where"
	notify-send -a claude \
		-h "string:x-canonical-private-synchronous:claude-${session_id:-default}" \
		"$title" "$body" >/dev/null 2>&1
fi

exit 0
