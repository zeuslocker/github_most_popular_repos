defmodule Hello.GithubSync do
  alias Hello.{Repo, GithubRepo}
  @get_all_repos_url "https://api.github.com/search/repositories?q=stars%3A%3E0&sort=stars&per_page=100"
  use Task

  def start_link do
    Task.start_link(&initial_sync/0)
  end

  def cron_sync do
    receive do
    after
      30_000 ->
        update_data()
        cron_sync()
    end
  end

  def initial_sync do
    update_data()
    cron_sync()
  end

  def update_data do
    responce = Poison.decode!(HTTPoison.get!(@get_all_repos_url).body)
    Repo.query("TRUNCATE github_repos")

    Enum.each(responce["items"], fn(repo) ->
      Repo.insert(%GithubRepo{name: repo["name"], github_id: repo["id"], data: repo})
    end)
  end
end
