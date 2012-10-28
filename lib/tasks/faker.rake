namespace :db do
  desc "Create fake records in database."

  task :faker => :environment do
    require 'faker'
    
    categories = Category.all

    categories.each do |c|
      100.times do 
        p = Product.new
        p.author = Faker::Name.name
        p.title = Faker::Lorem.sentence
        p.price = rand(50) + 10
        p.description = Faker::Lorem.paragraph
        p.category = c
        p.save
      end
    end

  end
end