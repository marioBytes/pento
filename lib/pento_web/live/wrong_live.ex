defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    rand_int = Enum.random(1..10)
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        answer: rand_int,
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    answer = socket.assigns.answer
    guess = String.to_integer(guess)

    is_correct = if answer == guess, do: true, else: false

    score =
      if is_correct do
        socket.assigns.score + 1
      else
        socket.assigns.score - 1
      end

    message =
      if is_correct do
        "Correct!
          <%=
            live_patch to: Routes.live_path(
              @socket,
              PentoWeb.WrongLive,
              %{score: score}
              )
            do
          %>
            Click me
          <% end %> to play again"
      else
        "Your guess: #{guess}. Wrong. Guess again. "
      end

    answer = socket.assigns.answer

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
      )
    }
  end

  def handle_params(params, _uri, socket) do
    rand_int = Enum.random(1..10)
    score =
      if params["score"] do
        IO.puts("score exists")
      else
        0
      end

    {
      :noreply,
      assign(
        socket,
        message: "Guess a number",
        score: score,
        answer: rand_int
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>">
          <%= n %>
        </a>
      <% end %>
    </h2>
    <pre>
      <%= @user.email %>
      <%= @session_id %>
    </pre>
    """
  end
end
