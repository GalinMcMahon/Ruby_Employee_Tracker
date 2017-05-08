require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/division")
require("./lib/employee")
require("pg")

get('/') do
  @divisions = Division.all
  erb(:index)
end

post('/add_division') do
  name = params.fetch('name')
  division = Division.create({name: name})
  @divisions = Division.all
  erb(:index)
end

get('/division/:id') do
  @division = Division.find(params.fetch("id").to_i())
  @employees = Employee.all # check this code if error
  erb(:division)
end
