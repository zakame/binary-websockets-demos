defmodule BinaryWS do
  @moduledoc """
  Binary.com WebSockets demo for Elixir.
  """

  @doc """
  Open a websocket and request a stream of updates for the symbol `R_100`.

  On receipt of each update, it emits a message.
  """
  def main(_args) do
    {:ok, omsg} = Poison.encode(%{"ticks" => "R_100"})
    socket = Socket.Web.connect! "ws.binaryws.com", 443,
      [{:secure, true}, {:path, "/websockets/v3?app_id=1089"}]
    socket |> Socket.Web.send!({:text, omsg})
    spawn_link(fn -> loop(socket) end)
    :timer.sleep(10000)
    socket |> Socket.Web.close
  end

  # Start receiving updates in another process until main process wakes up.
  defp loop(socket) do
    case socket |> Socket.Web.recv! do
      {:text, imsg} ->
        IO.puts "ticks update: " <> imsg
        loop(socket)
      _ -> exit(:normal)
    end
  end
end
