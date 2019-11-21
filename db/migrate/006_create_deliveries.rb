Sequel.migration do
  up do
    create_table(:deliveries) do
      primary_key :user_id
      foreign_key([:user_id], :users, key: :id)
    end
  end

  down do
    drop_table(:deliveries)
  end
end
