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
  @projects = @division.projects
  erb(:division)
end

patch('/rename_division/:id') do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({name: name})
  @employees = @division.employees
  @projects = @division.projects
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
  employee = Employee.create({name: name, division_id: @division.id, project_id: nil})
  @employees = @division.employees
  @projects = @division.projects
  erb(:division)
end

get('/employee/:id') do
  @employee = Employee.find(params.fetch('id').to_i)
  erb(:employee)
end

patch('/rename_employee/:id') do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @division = @employee.division
  @employee.update({name: name})
  @employees = @division.employees
  @projects = @division.projects
  erb(:division)
end

delete('/delete_employee/:id') do
  @employee = Employee.find(params.fetch("id").to_i())
  @division = @employee.division
  @employee.delete
  @employees = @division.employees
  @projects = @division.projects
  erb(:division)
end

post('/add_project/:id') do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @employees = @division.employees
  @project = Project.create({name: name, division_id: @division.id})
  erb(:project)
end

patch('/rename_project/:id') do
  name = params.fetch("name")
  @project = Project.find(params.fetch("id").to_i())
  @division = @project.division
  @project.update({name: name})
  @employees = @division.employees
  @projects = @division.projects
  erb(:project)
end

delete('/delete_project/:id') do
  @project = Project.find(params.fetch("id").to_i())
  @division = @project.division
  @project.delete
  @employees = @division.employees
  @projects = @division.projects
  erb(:division)
end

get('/project/:id') do
  @project = Project.find(params.fetch("id").to_i())
  @division = @project.division
  @employees = @division.employees
  @projects = @division.projects
  erb(:project)
end

# add a person to a project. Status: broken.
post('/add_to_project') do
  name = params.fetch("name")
  @project = Project.find(params.fetch("id").to_i())
  @project = Project.create({name: name, division_id: @division.id})
  @division = @project.division #need
  @employees = @division.employees #need
  @projects = @division.projects #need
  erb(:project)
end

# this is example of adding an employee to a division and may help with the above problem

# post('/add_employee/:id') do
#   @division = Division.find(params.fetch("id").to_i())
#   name = params.fetch('name')
#   employee = Employee.create({name: name, division_id: @division.id, project_id: nil})
#   @employees = @division.employees
#   @projects = @division.projects
#   erb(:division)
# end
