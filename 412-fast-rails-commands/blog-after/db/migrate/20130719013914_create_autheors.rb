class CreateAutheors < ActiveRecord::Migration
  def change
    create_table :autheors do |t|
      t.string :name

      t.timestamps
    end
  end
end
