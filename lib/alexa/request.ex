defmodule Alexa.Request do
  alias Alexa.{Session, RequestElement, Request}

  defstruct [session: %Session{}, version: "1.0", request: %RequestElement{}]

  def application_id(request) do
    case request.session.application do
      %{ applicationId: appId } -> appId
      _ -> nil
    end
  end

  def intent_name(request) do
    request.request.intent.name
  end

  def slot_value(request, name) do
    (Map.get(request.request.intent, :slots) || %{})
    |> Map.get(name, %{})
    |> Map.get("value", nil)
  end

  def from_params(params) do
    Poison.decode!(Poison.encode!(params), as: %Request{})
  end

  def attributes(request) do
    request.session.attributes
  end

  def attribute(request, key) do
    Map.get(attributes(request), key)
  end

  def user_id(request) do
    Map.get(request.session, :user, %{}) |> Map.get("userId")
  end
end
