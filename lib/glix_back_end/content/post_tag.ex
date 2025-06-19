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

  policies do
    policy always() do
      authorize_if always()
    end
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :tag, :string, public?: true, allow_nil?: false
  end

  relationships do
    belongs_to :post, GlixBackEnd.Content.Post, primary_key?: false, allow_nil?: false
  end
end
