bundle check || bundle install
# creating a database
bundle exec rails db:create && rails db:migrate
# run tests
bundle exec rspec
# Run our server
bundle exec puma -C config/puma.rb