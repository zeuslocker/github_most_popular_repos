defmodule Hello.GithubSync do
  use Task

  def start_link do
    Task.start_link(&initial_sync/0)
  end

  def sync() do
    receive do
    after
      10_000 ->
        get_price()
        sync()
    end
  end

  def initial_sync do
    get_price()
    sync()
  end

  defp get_price() do
    IO.puts "To the moon!"
  end
end
