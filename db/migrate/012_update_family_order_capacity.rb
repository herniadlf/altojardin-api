Sequel.migration do
  up do
    DB.run 'ALTER TABLE menu_types RENAME "user_id" TO "id"'
    DB.run 'UPDATE menu_types SET weight = 3 WHERE id = 3'
  end

  down do
    DB.run 'ALTER TABLE menu_types RENAME "id" TO "user_id"'
  end
end
