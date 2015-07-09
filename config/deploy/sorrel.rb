role :app, %w{www@sorrel.pdostal.cz}
role :web, %w{www@sorrel.pdostal.cz}
role :db,  %w{www@sorrel.pdostal.cz}

set :stage, 'sorrel'
set :application, 'web'
set :repo_url, 'git@github.com:pdostal/trandir.git'

set :branch, "master"
set :deploy_to, '/home/www/trandir.pdostal.cz'
set :tmp_dir, "/home/www/tmp"

server 'sorrel.pdostal.cz', port: 63022, user: 'www', roles: %w{web app}
