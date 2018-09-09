defmodule HelloWeb.GithubRepoView do
  use HelloWeb, :view
  alias HelloWeb.GithubRepoView

  def render("index.json", %{github_repos: github_repos}) do
    render_many(github_repos, GithubRepoView, "github_repo.json")
  end

  def render("show.json", %{github_repo: github_repo}) do
    render_one(github_repo, GithubRepoView, "github_repo.json")
  end

  def render("github_repo.json", %{github_repo: github_repo}) do
    %{
      id: github_repo.id,
      github_id: github_repo.github_id,
      name: github_repo.name,
      data: github_repo.data
    }
  end

  def render("sync.json", %{status: status}) do
    %{
      status: status
    }
  end
end
