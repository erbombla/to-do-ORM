require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type =>:feature}) do
  it ('allows a user to click a list ot see the tasks and details for it') do
    visit ('/')
    click_link('Add New List')
    fill_in('name', :with => 'Epicodus Work')
    click_button('Add List')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the lists', {:type => :feature}) do
  it('allows a user to see all of the lists that have been created') do
    list = List.new({:name => 'Epicodus Homework'})
    list.save()
    visit('/')
    click_link('View All Lists')
    expect(page).to have_content(list.name)
  end
end

# describe('to do list', {:type => :feature}) do
  # it('processes the users input and return a to do list') do
  #   visit('/')
  #   fill_in('task', :with => 'clean')
  #   click_button('Submit your Task')
  #   expect(page).to have_content('Your task has been submitted')
  # end
