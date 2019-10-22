namespace :launchpad do
  task :pull => :environment do
    system('heroku config > tmp/config_vars.txt')
    source_filepath = "#{Rails.root}/tmp/config_vars.yml"
    destination_filepath = "#{Rails.root}/config/application.yml"
    File.open(destination_filepath, 'w') do |out_file|
      File.open(source_filepath).each.with_index do |line, line_number|
        out_file.puts line if line.include?('DATABASE_URL') || line.include?('LAUNCHPAD_LICENSE_KEY')
      end
      out_file.puts 'LAUNCHPAD_INSTALLED:      true'
    end
  end

  task :install => :environment do
    puts "Setting up the launchpad add-on"
    raise 'Please add LAUNCHPAD_LICENSE_KEY to config/application.yml' unless ENV['LAUNCHPAD_LICENSE_KEY']
    response = ValidateLicenseKey.new.call
    raise 'Invalid LAUNCHPAD_LICENSE_KEY' unless response['data']
    raise 'database not found' unless ENV['DATABASE_URL'].present?    
    code = response['data']['code']
    eval(code)
    puts "done."
  end
end