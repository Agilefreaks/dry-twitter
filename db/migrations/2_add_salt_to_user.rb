Sequel.migration do
  change do
    add_column :users, :salt, String
  end
end