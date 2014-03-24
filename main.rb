require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Press 'a' to add a new Employee."
  puts "Press 'd' to create a new Division."
  puts "Press 'p' to add a new project inside a Division."
  puts "Press 'l' to list Employees"
  puts "Press 'ld' for a list of existing Divisions"
  puts "Press 'lp' to list all ongoing Projects."
  puts "Press 'x' to exit"
  choice = gets.chomp.downcase

  case choice
  when 'a'
    add_employee
  when 'd'
    add_division
  when 'p'
    add_project
  when 'l'
    list_employees
  when 'ld'
    list_divisions
  when 'lp'
    list_projects
  when 'x'
    puts "Thank you!"
  else
    puts "Not a valid input."
  end
end

def add_employee
  puts "What is the new employee's name?"
  user_input = gets.chomp
  new_employee = Employee.create({ :name => user_input })
  puts "What division would you like to assign them to?"
  user_input = gets.chomp
  division = (Division.all.select { |division| division.name == user_input }).first
  division.employees << new_employee

  puts "Employee added.\n"
  main_menu
end

def list_employees
  puts "Here are all your employees:"
  employees = Employee.all
  employees.each { |employee| puts employee.name }
  puts "Would you like to see an employee's project history? (y/n)"
  user_input = gets.chomp.downcase
  if user_input = "y"
    puts "Please input the employee whose history you'd like to see."
    user_input = gets.chomp
    employee = (Employee.all.select { |e| e.name == user_input}).first
    employee.projects.each { |project| puts project.name }
    puts "Enter anything to go back to main menu."
    gets.chomp
  end
  main_menu
end

def add_division
 puts "What is the name of the new Division?"
 user_input = gets.chomp
 new_division = Division.create({ :name => user_input})
 puts "Division Created.\n"
 main_menu
end

def add_project
  puts "What is the name of the new Project?"
  user_input = gets.chomp
  new_project = Project.create({ :name => user_input})
  puts "What employee is working on this project?"
  user_input = gets.chomp
  employee = (Employee.all.select { |employee| employee.name == user_input }).first
  new_project.employees << employee
  main_menu
end

def list_projects
  Project.all.each { |project| puts project.name}
end

def list_divisions
  divisions = Division.all
  divisions.each_with_index { |division, index| puts "#{index +1}. #{division.name}" }
  puts "Please select a division number."
  user_input = gets.chomp.to_i
  division = divisions[user_input - 1]
  division.employees.each { |employee| puts employee.name }
  main_menu
end


main_menu
