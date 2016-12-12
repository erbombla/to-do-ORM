require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require("sinatra/activerecord")
require('./lib/task')
require('./lib/list')
require('pg')

get('/') do
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:success)
 end

# post('/input') do
#   description = params.fetch('task')
#   test_task = Task.new(description)
#   test_task.save()
#   erb(:success)
# end
