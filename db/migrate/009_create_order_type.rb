Sequel.migration do
  up do
    create_table(:menu_types) do
      primary_key :user_id
      String :menu
      Int :weight
    end

    DB[:menu_types].insert([1, 'menu_individual', 1])
    DB[:menu_types].insert([2, 'menu_pareja', 2])
    DB[:menu_types].insert([3, 'menu_familiar', 4])
  end

  down do
    drop_table(:menu_types)
  end
end
