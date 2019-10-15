task :generate_api => :environment do
  raise 'database not found' unless ENV['DATABASE_URL'].present?
  Rake::Task["db:schema:dump"].invoke
  BuildModels.new.call
end