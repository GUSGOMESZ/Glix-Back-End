defmodule GlixBackEnd.Content.Post do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Content,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  postgres do
    table "posts"
    repo GlixBackEnd.Repo
  end


  attributes do
    uuid_v7_primary_key :id

    attribute :title, :string, public?: true, allow_nil?: false
    attribute :content, :string, public?: true, allow_nil?: false
  end

  relationships do
    belongs_to :user, GlixBackEnd.Accounts.User, primary_key?: false, allow_nil?: false
  end
end
