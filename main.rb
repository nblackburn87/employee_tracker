require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'
require './lib/contribution'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Press 'c' to create a new item."
  puts "Press 'l' to see a list."
  puts "Press 'd' to delete something."
  puts "Press 'u' to update something."
  puts "Press 'x' to exit"
  user_input = gets.chomp.downcase

  case user_input
  when 'c'
    create_menu
  when 'l'
    list_menu
  when 'd'
    delete_menu
  when 'u'
    edit_menu
  when 'x'
    puts "Thank you!"
    exit
  else
    puts "Not a valid input."
  end
end

def create_menu
  puts "Press 'e' to add a new employee."
  puts "Press 'd' to add a new division."
  puts "Press 'p' to add a new project."
  puts "Press 'a' to add a current employee to a division."
  puts "Press 'c' to add a contribution to a project."
  puts "Press 'u' to return to the previous menu."

  user_input = gets.chomp.downcase
  case user_input
  when 'e'
    add_employee
  when 'd'
    add_division
  when 'a'
    add_employee_to_division
  when 'p'
    add_project
  when 'c'
    add_contribution
  when 'u'
    main_menu
  else
    puts "Not a valid input."
  end
end

def add_employee
  puts "What is the new employee's name?"
  user_input = gets.chomp
  new_employee = Employee.create({ :name => user_input })
  puts "Employee added.\n"
  main_menu
end

def add_division
 puts "What is the name of the new Division?"
 user_input = gets.chomp
 new_division = Division.create({ :name => user_input})
 puts "Division Created.\n"
 main_menu
end

def add_employee_to_division
  puts "What employee do you want to assign?"
  Employee.all.each { |e| puts e.name }
  input = gets.chomp
  employee = Employee.find_by(:name => input)
  puts "What division do you want to assign them to?"
  Division.all.each { |d| puts d.name }
  input = gets.chomp
  division = Division.find_by(:name => input)
  division.employees << employee
  puts "#{employee.name} was assigned to #{division.name}."
  gets.chomp
  main_menu
end

def add_project
  puts "What is the name of the new Project?"
  user_input = gets.chomp
  new_project = Project.create({ :name => user_input})
  puts "What employee is working on this project?"
  user_input = gets.chomp
  employee = Employee.find_by(:name => user_input)
  new_project.employees << employee
  main_menu
end

def add_contribution
  puts "What project would you like to add a contribution to?"
  list_projects
  input = gets.chomp
  project = Project.find_by(:name => input)
  puts "What employee made the contribution?"
  Employee.all.each { |e| puts e.name }
  input = gets.chomp
  employee = Employee.find_by(name: input)
  puts "What is the description of this contribution?"
  desc_input = gets.chomp
  Contribution.create(:project_id => project.id, :employee_id => employee.id, :description => desc_input)
  puts "Contribution added.  Press any key to go back to main menu."
  gets.chomp
  main_menu
end
#**********************************************

def list_menu
  puts "Press 'e' to list employees."
  puts "Press 'd' to list divisions."
  puts "Press 'p' to list projects."
  puts "Press 'c' to list contributions."
  puts "Press 'pd' to list projects by divisions."
  puts "Press 'u' to go return to the previous menu."

  user_input = gets.chomp.downcase

  case user_input
  when 'e'
    list_employees
  when 'd'
    list_divisions
  when 'p'
    list_projects
    puts "Enter any key to continue."
    gets.chomp
    list_menu
  when 'c'
    list_contributions
  when 'pd'
    list_projects_by_divisions
  when 'u'
    main_menu
  else
    puts "Not a valid input."
  end
end

def list_employees
  puts "Here are all your employees:"
  employees = Employee.all
  employees.each { |employee| puts employee.name }
  puts "Would you like to see an employee's project history? (y/n)"
  user_input = gets.chomp.downcase
  if user_input == "y"
    puts "Please input the employee whose history you'd like to see."
    user_input = gets.chomp
    employee = (Employee.all.select { |e| e.name == user_input}).first
    employee.projects.each { |project| puts project.name }
    puts "Enter anything to go back to main menu."
    gets.chomp
  end
  main_menu
end

def list_projects_by_divisions
  puts "What division's projects do you want to list?"
  input = gets.chomp
  Division.find_by(:name => input).employees.projects.each {|p| puts p}
  "Enter any key to go back to main menu."
  gets.chomp
  main_menu
end

def list_divisions
  divisions = Division.all
  divisions.each_with_index { |division, index| puts "#{index +1}. #{division.name}" }
  puts "Please select a division number."
  user_input = gets.chomp.to_i
  if user_input.is_a? Integer
    division = divisions[user_input - 1]
    division.employees.each { |employee| puts employee.name }
  else
    puts "That is not a valid input!"
    main_menu
  end
  main_menu
end

def list_projects
  Project.all.each { |project| puts project.name}
end

def list_contributions
  puts "What project do you want to see contributions for?"
  list_projects
  input = gets.chomp
  project = Project.find_by(:name => input)
  project.contributions.each { |c| puts c.description }
  puts "Enter any key to go back to main menu."
  gets.chomp
  main_menu
end

#******************************************

def delete_menu
  puts "Press 'e' to delete an employee, 'd' to delete a division, 'p' to delete a project."
  user_input = gets.chomp.downcase

  case user_input
  when 'e'
    Employee.all.each_with_index do |employee, index|
      puts (index + 1).to_s + ": " + employee.name
    end
    puts "Which employee would you like to delete? Enter index number."
    user_input = gets.chomp.to_i
    Employee.all[user_input - 1].destroy
    puts "Employee deleted. Enter anything to go back to main_menu."
    gets.chomp
    main_menu
  when 'd'
    Division.all.each_with_index do |division, index|
      puts (index+1).to_s + ": " + division.name
    end
    puts "Which division would you like to delete? Enter index number."
    user_input = gets.chomp.to_i
    Division.all[user_input - 1].destroy
    puts "Division deleted. Enter anything to go back to main_menu."
    gets.chomp
    main_menu
  when 'p'
    Project.all.each_with_index do |project, index|
      puts (index+1).to_s + ": " + project.name
    end
    puts "Which project would you like to delete? Enter index number."
    user_input = gets.chomp.to_i
    Project.all[user_input-1].destroy
    puts "Project deleted. Enter anything to go back to main_menu."
    gets.chomp
    main_menu
  end
end

def edit_menu
  puts "Press 'e' to edit an employee name."
  puts "Press 'd' to edit a division title."
  puts "Press 'p' to edit something about a project."

  user_input = gets.chomp.downcase

  case user_input
  when 'e'
    thing
  when 'd'
    other thing
  when 'p'
    edit_project
  when 'u'
    main_menu
  else
    puts "Not a valid input."
  end
end

def edit_project
  puts "These projects are currently underway:"
  list_projects
  puts "\n"
  puts "Which project would you like to view?"
  user_input = gets.chomp.downcase
  project = (Projects.all.select { |project| project.name == user_input }).first
  project.employees.each { |employee| puts employee.name }
  puts "What employee's contribution would you like to edit?"
  user_input = gets.chomp
  employee = project.employees.select { |e| e.name == user_input }
  puts "What is the new description of the contribution?"
  user_input = gets.chomp
  cont = Contribution.find_by(:project_id => project.id, :employee_id => employee.id)
  cont.update(:description => user_input)
  puts "Enter any key to go back to main menu."
  gets.chomp
  main_menu
end

main_menu
