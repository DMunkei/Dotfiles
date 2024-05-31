session="ZEW"
devenvironment='zew&&act'
# devUrls='vivaldi-stable Space http://127.0.0.1:8000/admin Space http://127.0.0.1:8000/timetracker'
cd ~/Development/zew_arbeitswelt_2023/ || exit
tmux new-session -d -s $session

window=0

tmux rename-window -t $session:$window 'code'
tmux send-keys -t $session:$window $devenvironment C-m
# tmux send-keys -t $session:$window $devUrls C-m
tmux send-keys -t $session:$window 'nvim .' C-m

window=1

tmux new-window -t $session:$window -n 'backend'
tmux send-keys -t $session:$window $devenvironment C-m
tmux send-keys -t $session:$window 'python manage.py runserver' C-m

window=2 
tmux new-window -t $session:$window -n 'shell'
tmux send-keys -t $session:$window $devenvironment C-m

window=3 
tmux new-window -t $session:$window -n 'Lazygit'
tmux send-keys -t $session:$window $devenvironment'&&lazygit' C-m

tmux attach-session -t $session
