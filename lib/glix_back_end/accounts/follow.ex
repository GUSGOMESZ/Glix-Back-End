defmodule GlixBackEnd.Accounts.Follow do
  use Ash.Resource,
  otp_app: :glix_back_end,
  domain: GlixBackEnd.Accounts,
  data_layer: AshPostgres.DataLayer,
  authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "follows"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
  end

  relationships do
    belongs_to :follower, GlixBackEnd.Accounts.User, primary_key?: true, allow_nil?: false
    belongs_to :followed, GlixBackEnd.Accounts.User, primary_key?: true, allow_nil?: false
  end
end
