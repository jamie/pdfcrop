class AddMetadataToPdfs < ActiveRecord::Migration[7.1]
  def change
    add_column :pdfs, :filename, :string
    add_column :pdfs, :uuid, :string

    add_index :pdfs, :uuid
  end
end
