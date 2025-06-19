defmodule GlixBackEnd.Content.PostTag do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Content,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshGraphql.Resource]

  graphql do
    type :post_tag

    queries do
    end

    mutations do
      create :create_post_tag, :create
    end

  end

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

  relationships do
    belongs_to :post, GlixBackEnd.Content.Post, primary_key?: true, allow_nil?: false
    belongs_to :tag, GlixBackEnd.Taxonomy.Tag, primary_key?: true, allow_nil?: false
  end
end
