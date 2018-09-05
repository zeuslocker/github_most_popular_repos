defmodule Hello.GithubRepoTest do
  use Hello.ModelCase

  alias Hello.GithubRepo

  @valid_attrs %{github_data: %{}, github_id: 42, name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GithubRepo.changeset(%GithubRepo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GithubRepo.changeset(%GithubRepo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
