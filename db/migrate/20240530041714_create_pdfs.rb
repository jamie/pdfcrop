class CreatePdfs < ActiveRecord::Migration[7.1]
  def change
    create_table :pdfs do |t|
      t.string :uuid, index: {unique: true}
      t.string :filename

      t.timestamps
    end
  end
end
