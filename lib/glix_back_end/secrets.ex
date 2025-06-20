defmodule GlixBackEnd.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        GlixBackEnd.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:glix_back_end, :token_signing_secret)
  end
end
