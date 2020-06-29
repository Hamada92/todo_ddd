module TaskRecord
  class Task < ApplicationRecord
    self.table_name  = 'tasks'
  end
end
