defmodule TodoApp.Repo.Migrations.AddUsuarios do
  use Ecto.Migration

  def change do
    create table :usuarios do
      add :nome, :string
      add :email, :string
      add :token, :string
      add :provider, :string

      timestamps()
    end
  end
end
