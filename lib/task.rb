class Task
  attr_reader(:description, :list_id, :due_date)


  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @list_id = attributes[:list_id]
    @due_date = attributes[:due_date]
  end


  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}',  #{@list_id});")
  end

  def self.sort_tasks_by_date_asc (task_key)
    DB.exec("SELECT * FROM taks WHERE list_id -= '#{task_key}' ORDER BY due_date ASC;")
  end

  # define_singleton_method(:clear) do
  #   @@all_tasks = []
  # end

  define_method(:==) do |another_task|
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end
end
