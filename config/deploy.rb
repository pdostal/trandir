# lock '3.1.0'

set :stages, %w(sorrel)
set :default_stage, 'sorrel'
set :scm, :git
set :format, :pretty
set :log_level, :info

namespace :deploy do
  after :publishing, :uptime do
    on roles(:web), in: :groups do
      uptime = capture(:uptime)
      "#{host.hostname} reports: #{uptime}"
    end
  end
end
