class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :serial_number
      t.belongs_to :match
      t.timestamps
    end
  end
end
