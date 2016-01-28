class AddGrantCascades < ActiveRecord::Migration
  TABLES = %w{
    other_payments
    people
  }

  def remove_and_add(cascade = true)
    on_delete = cascade ? :cascade : :restrict

    TABLES.each do |t|
      remove_foreign_key(t, :grants)
      add_foreign_key(t, :grants, on_delete: on_delete)
    end
  end

  def up
    remove_and_add

    remove_foreign_key(:incomes, :people)
    add_foreign_key(:incomes, :people, on_delete: :cascade)
  end

  def down
    remove_and_add(false)

    remove_foreign_key(:incomes, :people)
    add_foreign_key(:incomes, :people)
  end
end
