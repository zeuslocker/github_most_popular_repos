defmodule Hello.Repo.Migrations.CreateGithubRepo do
  use Ecto.Migration

  def change do
    create table(:github_repos) do
      add :name, :string
      add :github_id, :integer
      add :github_data, :map

      timestamps()
    end

    create unique_index(:github_repos, [:github_id])
  end
end
