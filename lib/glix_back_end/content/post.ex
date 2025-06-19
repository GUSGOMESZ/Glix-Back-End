defmodule GlixBackEnd.Content.Post do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Content,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :post

    queries do
      list :list_posts, :read
    end

    mutations do
      create :create_post, :create_post
    end
  end

  actions do
    defaults [:read, :destroy, update: :*]

    create :create_post do
      argument :user_id, :string do
        description "Author ID"
        allow_nil? false
        public? true
      end

      argument :title, :string do
        description "Posts title"
        allow_nil? false
        public? true
      end

      argument :content, :string do
        description "Posts content"
        allow_nil? false
        public? true
      end

      argument :post_tag, {:array, :map}

      change set_attribute(:title, arg(:title))
      change set_attribute(:content, arg(:content))
      change set_attribute(:user_id, arg(:user_id))

      change manage_relationship(:post_tag, type: :create, on_no_match: :create, on_match: :error)
    end
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
    has_many :post_tag, GlixBackEnd.Content.PostTag, public?: true
  end
end
