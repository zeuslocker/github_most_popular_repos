defmodule Hello.GithubRepo do
  use Ecto.Schema
  import Ecto.Changeset


  schema "github_repos" do
    field :data, :map
    field :github_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(github_repo, attrs) do
    github_repo
    |> cast(attrs, [:name, :github_id, :data])
    |> validate_required([:name, :github_id, :data])
    |> unique_constraint(:github_id)
  end
end
