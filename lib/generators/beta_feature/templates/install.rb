class <%= migration_class_name %> < <%= migration_parent %>
  def self.up
    create_table :beta_feature_settings, :force => true do |t|
      t.integer :betable_id
      t.string :betable_type
      t.string :betas, array: true, default: []
      t.timestamps

      t.index [:betable_type, :betable_id], unique: true
    end
  end

  def self.down
    drop_table :beta_feature_settings
  end
end
