class <%= migration_class_name %> < <%= migration_parent %>
  def self.up
    create_table :beta_feature_settings, :force => true do |t|
      t.integer :ownerable_id
      t.string :ownerable_type
      t.string :betas, array: true, default: []
      t.timestamps

      t.index [:ownerable_type, :ownerable_id], unique: true
    end
  end

  def self.down
    drop_table :beta_feature_settings
  end
end
