require('rspec')
require('task')
require('pg')

DB = PG.connect({:dbname => 'to_do_test'}) #DB is a constant

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  describe('.all') do
    it('is an empty at first ') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
      it("adds a task to the array of saved tasks") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
        test_task.save()
        expect(Task.all()).to(eq([test_task]))
      end
    end

  describe('.sort_tasks_by _date_asc') do
    it ('sorts tasks by date in ascending order') do
    test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
    test_task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-24'})
    test_task.save()
    test_task2.save()
    expect(Task.all()).to(eq([test_task, test_task2]))
    end
  end

    describe("#description") do
      it("lets you read the description out") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
        expect(test_task.description()).to(eq("learn SQL"))
      end
    end

    describe('#due_date') do
      it('lets you give a due date') do
        test_task = Task.new({:description => 'do shit', :list_id => 1, :due_date => '2016-12-25'})
        test_task.save()
        expect(test_task.due_date()).to(eq('2016-12-25'))
      end
    end

    describe("#list_id") do
      it("lets you read the list ID out") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
        expect(test_task.list_id()).to(eq(1))
      end
    end

    describe("#==") do
      it("is the same task if it has the same description and list ID") do
        task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
        task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2016-12-25'})
        expect(task1).to(eq(task2))
      end
    end
  end
