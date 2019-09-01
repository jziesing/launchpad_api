task :build_models => :environment do
  puts "building models based on Postgres tables"
  service = BuildModels.new
  service.call

  puts "done."
end