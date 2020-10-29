php:
  fpm:
    pools:
      'www-pterodactyl.conf':
        enabled: True
        settings:
          pterodactyl:
            user: nginx
            group: nginx
            listen: /var/run/php-fpm/pterodactyl.sock
            listen.owner: nginx
            listen.group: nginx
            listen.mode: '0750'
            pm: ondemand
            pm.max_children: 9
            pm.process_idle_timeout: 10s
            pm.max_requests: 200
  ini:
    defaults:
      PHP:
        disable_functions:
          - pcntl_fork
          - pcntl_waitpid
          - pcntl_wait
          - pcntl_wifexited
          - pcntl_wifstopped
          - pcntl_wifsignaled
          - pcntl_wexitstatus
          - pcntl_wtermsig
          - pcntl_wstopsig
          - pcntl_signal_dispatch
          - pcntl_get_last_error
          - pcntl_strerror
          - pcntl_sigprocmask
          - pcntl_sigwaitinfo
          - pcntl_sigtimedwait
          - pcntl_exec
          - pcntl_getpriority
          - pcntl_setpriority
