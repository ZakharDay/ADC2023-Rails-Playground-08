set :output, "log/cron.log"
# job_type :rake, "cd :path && ./bin/bundle exec rake :task :environment_variable=:environment :output"

every 2.minute do
  rake "sitemap:refresh"
end
