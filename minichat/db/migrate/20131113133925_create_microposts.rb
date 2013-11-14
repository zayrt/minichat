class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :author
      t.string :content

      t.timestamps
    end
  end
end
