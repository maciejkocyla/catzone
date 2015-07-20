namespace :cats do
  
  task :add_100 => :environment do
    Cat.save_new_100
  end
    
end