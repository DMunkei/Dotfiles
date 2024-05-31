session="dev"

devenvironment='odev&&act'
# devUrls='firefox Space http://127.0.0.1:8000/api/ Space http://127.0.0.1:8000/admin Space http://127.0.0.1:8080'
cd ~/Development/oletv2/ || exit
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
tmux new-window -t $session:$window -n 'frontend'
tmux send-keys -t $session:$window $devenvironment'&&cd frontend_vue/&&npm run dev' C-m

window=3 
tmux new-window -t $session:$window -n 'misc'
tmux send-keys -t $session:$window $devenvironment C-m

tmux rename-session -t 0 OLET
tmux attach-session -t $session
