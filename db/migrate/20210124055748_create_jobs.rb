class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.decimal :rate

      t.timestamps
    end
  end
end
