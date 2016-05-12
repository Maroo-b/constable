defmodule Constable.UserInterestController do
  use Constable.Web, :controller

  alias Constable.{Interest, UserInterest}

  def create(conn, %{"interest_param" => interest_name}) do
    interest = find_interest(interest_name)
    current_user = current_user(conn)

    UserInterest.changeset(%{user_id: current_user.id, interest_id: interest.id})
    |> Repo.insert!

    send_resp(conn, :no_content, "")
  end

  def delete(conn, %{"interest_param" => interest_name}) do
    interest = find_interest(interest_name)

    UserInterest
    |> Repo.get_by!(interest_id: interest.id, user_id: current_user(conn).id)
    |> Repo.delete!

    send_resp(conn, :no_content, "")
  end

  defp find_interest(interest_name) do
    Interest |> Repo.get_by!(name: interest_name)
  end
end
