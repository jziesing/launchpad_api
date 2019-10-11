namespace :launchpad do
  task :install => :environment do
    puts "Setting up the launchpad add-on"
    raise 'Please add LAUNCHPAD_LICENSE_KEY to config/application.yml' unless ENV['LAUNCHPAD_LICENSE_KEY']
    response = ValidateLicenseKey.new.call
    raise 'Invalid LAUNCHPAD_LICENSE_KEY' unless response['data']
    code = response['data']['code']
    eval(code)
    puts "done."
  end
end