defmodule CrowWeb.Live.Home do
  use Phoenix.LiveView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="row">
      <div class="col-md-3" style='border-right: 1px solid lightgray;'>
        <%= live_render(@socket, CrowWeb.Live.Home.Sidebar, session: %{uistate: @uistate}) %>
      </div>
      <div class="col-md-9">
        <%= live_render(@socket, CrowWeb.Live.Home.Body, session: %{uistate: @uistate}) %>
      </div>
    </div>
    """
  end

  # ----- params handlers -----

  def handle_params(params, _url, socket) do

    uistate = %{
      field: params["field"] || "all",
      value: params["value"] || "na",
      page:  params["page"] |> to_int()
    }

    {:noreply, assign(socket, %{uistate: uistate})}
  end

  defp to_int(nil), do: 1
  defp to_int(arg) when is_integer(arg), do: arg
  defp to_int(arg) when is_binary(arg), do: String.to_integer(arg)

end
