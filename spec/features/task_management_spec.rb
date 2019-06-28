require 'rails_helper'

def login_via_form(email, password)
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

def login_user
  user = FactoryBot.create(:random_user)
  visit '/users/sign_in'
  login_via_form(user.email, user.password)
  return user
end

def login_with_user(user)
  visit '/users/sign_in'
  login_via_form(user.email, user.password)
end

def create_task
  click_link 'Create task'
  fill_in 'task[description]', with: 'Example task'
  click_button 'Create task'
end

RSpec.feature "TaskManagements", type: :feature do
  describe 'User self-management' do
    it 'registers a new user' do
      valid_attributes = FactoryBot.attributes_for(:random_user)
      visit '/users/sign_up'
      fill_in 'Email', with: valid_attributes[:email]
      fill_in 'Password', with: valid_attributes[:password]
      fill_in 'Password confirmation', with: valid_attributes[:password]
      click_button 'Sign up'
      expect(page).to have_current_path('/tasks')
    end

    it 'log in session' do
      user = FactoryBot.create(:random_user)
      visit '/users/sign_in'
      login_via_form(user.email, user.password)
      expect(page).to have_current_path('/tasks')
    end

    it 'log out session' do
      login_user
      click_link 'Log out'
      expect(page).to have_current_path('/users/sign_in')
    end

    it 'create a task' do
      login_user
      click_link 'Create task'
      fill_in 'task[description]', with: 'Example task'
      click_button 'Create task'
      expect(page).to have_current_path('/tasks')
      expect(page).to have_content('Example task')
    end

    it 'show a task' do
      user = FactoryBot.create(:random_user)
      task = FactoryBot.create(:task)
      assignment = FactoryBot.create(:assignment, ownership: true, user: user, task: task)
      user.assignments << assignment
      task.assignments << assignment

      login_with_user(user)
      click_link '+'
      expect(page).to have_current_path(task_path(task.id))
      expect(page).to have_content(/Task selected/i)
    end

    it 'complete a task' do
      user = FactoryBot.create(:random_user)
      task = FactoryBot.create(:task)
      assignment = FactoryBot.create(:assignment, ownership: true, user: user, task: task)
      user.assignments << assignment
      task.assignments << assignment

      login_with_user(user)
      #page.check('check-' + task.id.to_s)
      #check('check-' + task.id.to_s)
      #expect(page).to have_checked_field('check-' + task.id.to_s)

      #task = Task.find(task.id)
      #expect(task.completed).to eq true
    end

    it 'mark a task as incomplete' do
      user = FactoryBot.create(:random_user)
      task = FactoryBot.create(:task, completed: true, completed_date: Date.current)
      assignment = FactoryBot.create(:assignment, ownership: true, user: user, task: task)
      user.assignments << assignment
      task.assignments << assignment

      login_with_user(user)
      expect(page).to have_current_path('/tasks')
      #page.uncheck('check-' + task.id.to_s)
      #uncheck('check-' + task.id.to_s)
      #expect(page).not_to have_checked_field('check-' + task.id.to_s)

      #task = Task.find(task.id)
      #expect(task.completed).to eq false
    end

    it 'add a collaborator' do
      user = FactoryBot.create(:random_user)
      collaborator = FactoryBot.create(:random_user)
      task = FactoryBot.create(:task)
      assignment = FactoryBot.create(:assignment, ownership: true, user: user, task: task)
      user.assignments << assignment
      task.assignments << assignment
      expect(task.assignments.length).to eq 1

      login_with_user(user)
      click_link '+'
      click_button (collaborator.id).to_s
      expect(page).to have_current_path(task_path(task.id))

      task = Task.find(task.id)
      expect(task.assignments.length).to eq 2

      collaborator_assignment = task.assignments[1]
      expect(collaborator_assignment.user).to eql collaborator
      expect(collaborator_assignment.task).to eql task
      expect(collaborator_assignment.ownership).to eq false
    end

    it 'delete a task' do
      login_user
      create_task
      click_link 'Delete task'
      expect(page).to have_current_path('/tasks')
      expect(page).to have_no_content('Example task')
    end
  end
end
