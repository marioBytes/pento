defmodule PentoWeb.Presence do
  use Phoenix.Presence,
    otp_app: :pento,
    pubsub_server: Pento.PubSub

  alias PentoWeb.Presence
  alias Pento.Accounts

  @user_activity_topic "user_activity"

  def track_user(pid, product, user_email) do
    Presence.track(
      pid,
      @user_activity_topic,
      %{users: [%{email: user_email}]}
    )
  end
end
