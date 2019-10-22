namespace :launchpad do
  def set_launchpad_config_vars
    source_filepath = "#{Rails.root}/tmp/config_vars.yml"
    destination_filepath = "#{Rails.root}/config/application.yml"
    File.open(destination_filepath, 'w') do |out_file|
      File.open(source_filepath).each.with_index do |line, line_number|
        out_file.puts line if line.include?('DATABASE_URL') || line.include?('LAUNCHPAD_LICENSE_KEY')
      end
    end
  end

  task :install => :environment do
    puts "Setting up the launchpad add-on"
    system('heroku config > tmp/config_vars.yml')
    set_launchpad_config_vars
    raise 'Please add LAUNCHPAD_LICENSE_KEY to config/application.yml' unless ENV['LAUNCHPAD_LICENSE_KEY']
    response = ValidateLicenseKey.new.call
    raise 'Invalid LAUNCHPAD_LICENSE_KEY' unless response['data']
    raise 'database not found' unless ENV['DATABASE_URL'].present?    
    code = response['data']['code']
    eval(code)
    puts "done."
  end
end