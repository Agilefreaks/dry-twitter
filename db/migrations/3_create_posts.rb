Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      String :message, null: false
      foreign_key :user_id, :users
    end
  end
end