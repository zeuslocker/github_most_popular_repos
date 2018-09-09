defmodule HelloWeb.GithubRepoController do
  use HelloWeb, :controller
  alias Hello.{GithubRepo, Repo}

  def index(conn, _params) do
    render conn, "index.json", github_repos: Repo.all(GithubRepo)
  end

  def show(conn, %{"id_or_name" => id_or_name}) do
    parsed_search_param = if Regex.match?(~r/^\d+$/, id_or_name), do: :github_id, else: :name
    github_repo = Repo.get_by(GithubRepo, "#{parsed_search_param}": id_or_name)

    if github_repo do
      render conn, "show.json", github_repo: github_repo
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", github_repo: github_repo)
    end
  end

  def sync(conn, _params) do
    Supervisor.terminate_child(Hello.Supervisor, Hello.GithubSync)
    Supervisor.restart_child(Hello.Supervisor, Hello.GithubSync)
    render(conn, "sync.json", status: "complete")
  end
end
