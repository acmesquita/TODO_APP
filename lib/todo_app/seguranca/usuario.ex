defmodule TodoApp.Usuario do
    use Ecto.Schema
    import Ecto.Changeset
    alias TodoApp.Tarefa

    schema "usuarios" do
        field :nome, :string
        field :email, :string
        field :token, :string
        field :provider, :string
        has_many :tarefas, Tarefa
        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:nome, :email, :token, :provider])
        |> validate_required([:nome, :email, :token, :provider])
    end

end