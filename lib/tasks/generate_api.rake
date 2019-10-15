task :generate_api => :environment do
  raise 'database not found' unless ENV['DATABASE_URL'].present?
  BuildModels.new.call
end
