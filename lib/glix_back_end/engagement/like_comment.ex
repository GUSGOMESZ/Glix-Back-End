defmodule GlixBackEnd.Engagement.LikeComment do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Engagement,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "like_comments"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  relationships do
    belongs_to :user, GlixBackEnd.Accounts.User, primary_key?: true, allow_nil?: false
    belongs_to :comment, GlixBackEnd.Engagement.Comment, primary_key?: true, allow_nil?: false
  end
end
