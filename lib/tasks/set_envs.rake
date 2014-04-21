namespace :set do
  desc "Sets environment variables on Heroku from config/application.yml"
  task :envs do
    vars = YAML.load(File.read('config/application.yml'))
    vars.each do |name, value|
      puts "Setting #{name}=#{value}..."
      `heroku config:set #{name}=#{value}`
    end
  end
end