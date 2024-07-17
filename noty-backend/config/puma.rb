# config/puma.rb
environment ENV.fetch('RACK_ENV', 'development')

port ENV.fetch('PORT', 9292)

# Specifies the number of workers to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together,
# the concurrency of the application would be max `threads` * `workers`.
workers ENV.fetch('WEB_CONCURRENCY', 2)

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot` block.
preload_app!

# Specifies the number of `threads` to use to handle requests.
# This value must be greater than or equal to `min_threads`.
threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
threads threads_count, threads_count

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
