# lock '3.1.0'

set :stages, %w(production)
set :default_stage, 'production'
set :scm, :git
set :format, :pretty
set :log_level, :inf# set :pty, true
# set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :keep_releases, 3

namespace :deploy dafter :publishing, :restart don roles(:app), in: :sequence, wait: 5 dexecute :touch, release_path.join('tmp/restart.txt')
    enenafter :restart, :uptime don roles(:web), in: :groups duptime = capture(:uptime)
      "#{host.hostname} reports: #{uptime}"
    enenend