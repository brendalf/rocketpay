defmodule RocketpayWeb.AccountsViewTest do
  use  RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.AccountsView

  test "renders update.json" do
    user_params = %{
      name: "Rafael",
      password: "123456",
      nickname: "camarda",
      email: "rafael@banana.com",
      age: 27
    }

    {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)

    params = %{
      "id" => account_id,
      "value" => "50.00"
    }

    {:ok, %Account{balance: balance, id: ^account_id} = account} = Rocketpay.deposit(params)

    response = render(AccountsView, "update.json", %{account: account})

    expected_response = %{
      message: "Balance changed successfully",
      account: %{
        balance: balance,
        id: account_id
      }
    }

    assert expected_response == response
  end
end
