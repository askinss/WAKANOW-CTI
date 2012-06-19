class AddCalleridToAjaxsearch < ActiveRecord::Migration
  def self.up
    add_column :ajaxsearches, :caller_id, :string
  end

  def self.down
    remove_column :ajaxsearches, :caller_id
  end
end
