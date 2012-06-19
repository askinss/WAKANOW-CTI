class AddExtennoToAjaxsearch < ActiveRecord::Migration
  def self.up
    add_column :ajaxsearches, :extenno, :string
  end

  def self.down
    remove_column :ajaxsearches, :extenno
  end
end
