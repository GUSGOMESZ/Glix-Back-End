defmodule GlixBackEnd.Taxonomy.Tag do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Taxonomy,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "tags"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :description, :string
  end
end
