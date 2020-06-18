# View definition under db/views

class Views::TaskWithAssociatedTag < ApplicationRecord
  self.primary_key = 'id' # views don't have a primary key, but rails expects one.
end
