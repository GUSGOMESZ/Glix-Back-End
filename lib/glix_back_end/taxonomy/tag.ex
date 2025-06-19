defmodule GlixBackEnd.Taxonomy.Tag do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Taxonomy,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshGraphql.Resource]

  graphql do
    type :tag

    queries do
      list :list_tags, :read
    end

    mutations do

    end
  end

  postgres do
    table "tags"
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

    attribute :description, :string, public?: true
  end
end
