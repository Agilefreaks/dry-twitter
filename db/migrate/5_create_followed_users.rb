Sequel.migration do
  change do
    create_table(:followed_users) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :followed_user_id, :users
    end
  end
end