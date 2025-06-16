defmodule GlixBackEnd.Content.PostTag do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Content,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "post_tags"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  relationships do
    belongs_to :post, GlixBackEnd.Content.Post, primary_key?: true, allow_nil?: false
  end
end
