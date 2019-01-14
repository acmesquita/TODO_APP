defmodule TodoApp.Repo.Migrations.AddUsuariosTarefa do
  use Ecto.Migration

  def change do
    alter table(:tarefas) do
      add :usuario_id, references(:usuarios)
    end
  end
end
