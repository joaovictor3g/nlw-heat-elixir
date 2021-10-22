defmodule HeatTagsWeb.MessagesController do
  use HeatTagsWeb, :controller

  alias HeatTags.Messages.Create
  alias HeatTags.Message

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_create(conn)

    conn
    |> text("RECEBI A REQUISIÇÃO")
  end

  defp handle_create({:ok, %Message{} = message}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", message: message)
  end

  defp handle_create({:error, %{result: result, status: status}}, conn) do
    conn
    |> put_status(status)
    |> put_view(HeatTagsWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
