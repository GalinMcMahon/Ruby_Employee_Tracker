require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/division")
require("./lib/employee")
require("pg")
require "pry"

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
  @employees = @division.employees
  erb(:division)
end

patch('/rename_division/:id') do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({name: name})
  @employees = @division.employees
  erb(:division)
end

delete('/delete_division/:id') do
  @division = Division.find(params.fetch('id').to_i)
  @division.delete
  @divisions = Division.all
  erb(:index)
end

post('/add_employee/:id') do
  @division = Division.find(params.fetch("id").to_i())
  name = params.fetch('name')
  employee = Employee.create({name: name, division_id: @division.id})
  @employees = @division.employees
  erb(:division)
end

get('/employee/:id') do
  @employee = Employee.find(params.fetch('id').to_i)
  erb(:employee)
end

patch('/rename_employee/:id') do
  name = params.fetch("name")
  # @division = Employee.find(params.fetch("division_id").to_i())
  @employee = Employee.find(params.fetch("id").to_i())
  @division = @employee.division
  @employee.update({name: name})
  @employees = @division.employees
  erb(:division)
end


delete('/delete_employee/:id') do
  @employee = Employee.find(params.fetch("id").to_i())
  @division = @employee.division
  @employee.delete
  @employees = @division.employees
  erb(:division)
end
