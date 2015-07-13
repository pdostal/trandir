# lock '3.1.0'

set :stages, %w(sorrel)
set :default_stage, 'sorrel'
set :scm, :git
set :format, :pretty
set :log_level, :info

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

namespace :deploy do
  before :publishing, :build_site do
    on roles(:app) do
      within release_path do
        execute :bundle,  "exec jekyll build"
      end
    end
  end

  after :build_site, :uptime do
    on roles(:web), in: :groups do
      uptime = capture(:uptime)
      "#{host.hostname} reports: #{uptime}"
    end
  end
end
