defmodule TodoApp.Tarefa do
    use Ecto.Schema
    import Ecto.Changeset

    schema("tarefas") do
        field :titulo, :string
        field :pronto, :boolean
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:titulo, :pronto]) # cast para a estrutura de salvar
        |> validate_required([:titulo, :pronto]) # adicionar validacoes
    end
end