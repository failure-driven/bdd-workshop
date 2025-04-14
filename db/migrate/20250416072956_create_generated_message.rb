class CreateGeneratedMessage < ActiveRecord::Migration[8.0]
  def change
    create_table :generated_messages do |t|
      t.text :body
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
