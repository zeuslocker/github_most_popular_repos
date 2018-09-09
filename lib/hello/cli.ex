defmodule Hello.CLI do
  alias Hello.{GithubRepo, Repo, GithubSync}

  def main(args) do
    {parsed, _args, _invalid} = OptionParser.parse(args, strict: [all_repos: :boolean, sync: :boolean, show_repo: :string])
    if length(parsed) != 1 do
      IO.puts "Error: You have to specify one allowed option per command"
    else
      { key, value } = List.first(parsed)
      case key do
        :all_repos ->
          HelloWeb.GithubRepoView.render("index.json", %{github_repos: Repo.all(GithubRepo)}) |>
            inspect |>
            IO.puts
        :sync ->
          GithubSync.update_data()
        :show_repo ->
          parsed_search_param = if Regex.match?(~r/^\d+$/, value), do: :github_id, else: :name
          github_repo = Repo.get_by(GithubRepo, "#{parsed_search_param}": value)
          HelloWeb.GithubRepoView.render("show.json", %{github_repo: github_repo}) |>
            inspect |>
            IO.puts
        _ ->
          IO.puts "Error"
      end
      exit(:shutdown)
    end
  end
end
