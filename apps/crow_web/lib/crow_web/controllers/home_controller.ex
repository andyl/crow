defmodule CrowWeb.HomeController do
  use CrowWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:body_data, CrowData.Query.job_query())
    |> assign(:side_data, CrowData.Query.side_data())
    |> assign(:uistate,   %{field: nil, value: nil})
    |> render("index.html")
  end

  def urls(conn, _params) do
    render(conn, "urls.html")
  end

  def logs(conn, _params) do
    render(conn, "logs.html")
  end

  def stats(conn, _params) do
    render(conn, "stats.html")
  end
end
