defmodule Hello.GithubRepo do
  use Hello.Web, :model

  schema "github_repos" do
    field :name, :string
    field :github_id, :integer
    field :github_data, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :github_id, :github_data])
    |> validate_required([:name, :github_id, :github_data])
    |> unique_constraint(:github_id)
  end
end
