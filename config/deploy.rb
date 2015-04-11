# lock '3.1.0'

set :stages, %w(production)
set :default_stage, 'production'
set :scm, :git
set :format, :pretty
set :log_level, :info

# set :pty, true
# set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :keep_releases, 3

desc "Run rake task on server"
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      as :deploy do
        with rails_env: :production do
          execute :rake, "assetpack:build", "RAILS_ENV=production"
        end
      end
    end
  end
end

namespace :git do
  desc 'Copy repo to releases'
  task create_release: :'git:update' do
    on roles(:all) do
      with fetch(:git_environmental_variables) do
        within repo_path do
          execute :git, :clone, '-b', fetch(:branch), '--recursive', '.', release_path
        end
      end
    end
  end
end

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
