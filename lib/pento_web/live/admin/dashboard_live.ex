defmodule PentoWeb.Admin.DashboardLive do
  use PentoWeb, :live_view

  alias PentoWeb.Endpoint

  @survey_topic "survey_results"
  @user_activity_topic "user_activity"
  @user_survey "user_survey"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@survey_topic)
      Endpoint.subscribe(@user_activity_topic)
      Endpoint.subscribe(@user_survey)
    end

    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey-results")
     |> assign(:user_activity_component_id, "user-activity")
     |> assign(:user_survey_component_id, "user-survey")}
  end

  def handle_info(%{event: "rating_created"}, socket) do
    send_update(PentoWeb.Admin.SurveyResultsLive, id: socket.assigns.survey_results_component_id)
    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff", topic: topic}, socket) when topic == @user_activity_topic do
    send_update(PentoWeb.UserActivityLive, id: socket.assigns.user_activity_component_id)
    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff", topic: topic}, socket) when topic == @user_survey do
    send_update(PentoWeb.UserSurveyLive, id: socket.assigns.user_survey_component_id)
    {:noreply, socket}
  end
end
