defmodule GlixBackEnd.Accounts do
  use Ash.Domain,
    otp_app: :glix_back_end

  resources do
    resource GlixBackEnd.Accounts.Token
    resource GlixBackEnd.Accounts.User
  end
end
