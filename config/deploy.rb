# lock '3.1.0'

set :stages, %w(production)
set :default_stage, 'production'
set :scm, :git
set :format, :pretty
set :log_level, :info

# set :pty, true
set :rvm1_ruby_version, "2.1.2"
fetch(:default_env).merge!( rvm_path: "/usr/local/rvm" )
set :keep_releases, 3

# desc "Run rake task on server"
# task :rake do
#   on roles(:app), in: :sequence, wait: 5 do
#     within release_path do
#       as :deploy do
#         with rails_env: :production do
#           execute :rake, "assetpack:build", "RAILS_ENV=production"
#         end
#       end
#     end
#   end
# end

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
  after :publishing, :assetpack do
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          rake 'assetpack:build'
        end
      end
    end
  end

  before :assetpack, 'rvm1:hook'

  after :assetpack, :restart do
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
