defmodule HelloWeb.GithubRepoController do
  use HelloWeb, :controller
  alias Hello.{GithubRepo, Repo}

  def index(conn, params) do
    render conn, "index.json", github_repos: Repo.all(GithubRepo)
  end
end
