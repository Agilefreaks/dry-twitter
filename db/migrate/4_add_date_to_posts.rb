Sequel.migration do
  change do
    add_column :posts, :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
  end
end