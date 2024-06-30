#!/bin/bash

if [[ "$(tmux display-message -p -F "#{session_name}")" = *"popup"* ]];then
    tmux detach-client
else
  current_path=$(tmux display-message -p -F "#{pane_current_path}")
  sanitized_path=${current_path//./_}
  tmux popup -d "$current_path" -xW -yW -w100% -h50% -B -E "tmux attach -t popup-${sanitized_path} || tmux new -s popup-${sanitized_path} \; set status off"
fi
