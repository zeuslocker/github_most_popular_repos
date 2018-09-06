defmodule HelloWeb.GithubRepoController do
  use HelloWeb, :controller
  alias Hello.{GithubRepo, Repo}

  def index(conn, _params) do
    render conn, "index.json", github_repos: Repo.all(GithubRepo)
  end

  def show(conn, %{"id_or_name" => id_or_name}) do
    if Regex.match?(~r/^\d+$/, id_or_name) do
      render conn, "show.json", github_repo: Repo.get(GithubRepo, id_or_name)
    else
      render conn, "show.json", github_repo: Repo.get_by(GithubRepo, name: id_or_name)
    end
  end
end
