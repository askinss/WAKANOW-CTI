class CreateAjaxsearches < ActiveRecord::Migration
  def self.up
    create_table :ajaxsearches do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ajaxsearches
  end
end
