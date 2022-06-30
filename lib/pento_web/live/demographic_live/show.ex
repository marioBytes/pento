defmodule PentoWeb.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  def details(assigns) do
    ~H"""
    <div>
      <h2>Demographics <%= raw "&#x2713;" %></h2>
      <ul>
        <li>Gender: <%= @demographic.gender %></li>
        <li>Year of birth: <%= @demographic.year_of_birth %></li>
        <li>Education level: <%= @demographic.education_level %></li>
      </ul>
    </div>
    """
  end
end
