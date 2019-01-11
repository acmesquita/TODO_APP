defmodule TodoApp.Repo.Migrations.CriarTarefa do
  use Ecto.Migration

  def change do
    create table(:tarefas) do
      add :titulo, :string
      add :pronto, :boolean
    end
  end
end
