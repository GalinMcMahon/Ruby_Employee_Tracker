ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("./lib/division")
require("./lib/employee")
require("pry")

RSpec.configure do |config|
  config.after(:each) do
    Employee.all.each do |employee|
      employee.destroy
    end
    Division.all.each do |division|
      division.destroy
    end
  end
end
