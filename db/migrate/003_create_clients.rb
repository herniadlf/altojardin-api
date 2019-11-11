Sequel.migration do
  up do
    create_table(:clients) do
      primary_key :user_id
      String :phone
      String :address
      foreign_key([:user_id], :users, key: :id)
    end
  end

  down do
    drop_table(:clients)
  end
end
