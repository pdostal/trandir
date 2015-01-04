# lock '3.1.0'

set :stages, %w(production)
set :default_stage, 'production'
set :scm, :git
set :git_enable_submodules, 1
set :format, :pretty
set :log_level, :info

# set :pty, true
# set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :keep_releases, 3

namespace :bundle do

  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    execute "cd #{current_path} && bundle install  --without=test --no-update-sources"
  end

end

before "deploy:restart", "bundle:install"

namespace :deploy do

  after :publishing, :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :uptime do
    on roles(:web), in: :groups do
      uptime = capture(:uptime)
      "#{host.hostname} reports: #{uptime}"
    end
  end

end
