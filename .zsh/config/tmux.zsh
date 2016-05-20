# tmux load-buffer in tmux 2.2+ hangs on epoll_wait()
# https://github.com/tmux/tmux/pull/416
export EVENT_NOEPOLL=1
