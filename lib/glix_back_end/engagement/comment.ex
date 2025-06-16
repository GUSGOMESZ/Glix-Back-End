defmodule GlixBackEnd.Engagement.Comment do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Engagement,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "comments"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :content, :string, allow_nil?: false, public?: true
  end

  relationships do
    belongs_to :user, GlixBackEnd.Accounts.User, primary_key?: false, allow_nil?: false
    belongs_to :comment_father, GlixBackEnd.Engagement.Comment, primary_key?: false, allow_nil?: true
    belongs_to :post, GlixBackEnd.Content.Post, primary_key?: false, allow_nil?: false
  end
end
