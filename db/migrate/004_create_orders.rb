Sequel.migration do
  up do
    create_table(:orders) do
      primary_key :id
      Integer :user_id
      Integer :menu_id
      Date :created_on
      Date :updated_on
      foreign_key([:user_id], :users, key: :id)
    end
  end

  down do
    drop_table(:orders)
  end
end
