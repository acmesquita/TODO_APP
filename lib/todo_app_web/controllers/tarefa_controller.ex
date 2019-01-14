defmodule TodoAppWeb.TarefaController do
  use TodoAppWeb, :controller

  alias TodoApp.Tarefa
  alias TodoApp.Repo

  plug TodoAppWeb.Plug.RequireAuth when action in [:create, :update, :edit, :delete, :new]
  plug :verifica_permissao when action in [:update, :edit, :delete]

  def index(conn, _param) do
    render conn, "index.html", tarefas: Repo.all(Tarefa)
  end

  def new(conn, _param) do
    changeset = Tarefa.changeset %Tarefa{}
    render conn, "new.html", changeset: changeset
  end
  
  def create(conn, %{"tarefa" => tarefa}) do
    changeset =
    conn.assigns.user
    |> Ecto.build_assoc(:tarefas)
    |> Tarefa.changeset(tarefa)

    case Repo.insert changeset do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Tarefa incluida na lista")
        |> redirect to: Routes.tarefa_path( conn, :index)
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end
    render conn, "index.html"
  end

  def edit(conn, %{"id" => tarefa_id}) do
    tarefa = Repo.get(Tarefa, tarefa_id)
    changeset = Tarefa.changeset(tarefa)
    render conn, "edit.html", changeset: changeset, tarefa: tarefa
  end

  def update(conn, %{"tarefa" => tarefa, "id" => id}) do
    tarefa_alterar = Repo.get(Tarefa, id)
    changeset = Tarefa.changeset(tarefa_alterar, tarefa)
    case Repo.update changeset do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Tarefa #{id} Atualizada")
        |> redirect to: Routes.tarefa_path conn, :index
      {:error, changeset} -> 
        render conn, "edit.html", changeset: changeset, tarefa: tarefa
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Tarefa, id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Tarefa deletada")
    |> redirect to: Routes.tarefa_path conn, :index
  end

  def verifica_permissao(conn, _params) do
    %{params: %{"id" => tarefa_id}} = conn

    if Repo.get(Tarefa, tarefa_id).usuario_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "Essa tarefa não é sua.")
      |> redirect(to: Routes.tarefa_path(conn, :index))
      |> halt
    end
  end

end