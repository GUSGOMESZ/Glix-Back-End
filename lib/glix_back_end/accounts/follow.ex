defmodule GlixBackEnd.Accounts.Follow do
  use Ash.Resource,
    otp_app: :glix_back_end,
    domain: GlixBackEnd.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource]

  graphql do
    type :follow

    queries do
      action :get_followers, :get_followers
      action :get_followings, :get_followings
    end
  end

  postgres do
    table "follows"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]

    read :filter_followers do
      argument :followed_id, :uuid_v7 do
        allow_nil? true
        public? true
      end

      filter expr(
        if is_nil(^arg(:followed_id)) do
          true
        else
          followed_id == ^arg(:followed_id)
        end
      )
    end

    action :get_followers, :integer do
      argument :followed_id, :uuid_v7, allow_nil?: false

      run fn input, _ ->
        id = input.arguments.followed_id

        follow = GlixBackEnd.Accounts.Follow
        |> Ash.Query.for_read(:filter_followers, %{followed_id: id})
        |> Ash.read!()

        {:ok, length(follow)}
      end
    end

    read :filter_following do
      argument :user_id, :uuid_v7 do
        allow_nil? true
        public? true
      end

      filter expr(
        if is_nil(^arg(:user_id)) do
          true
        else
          follower_id == ^arg(:user_id)
        end
      )
    end

    action :get_followings, :integer do
      argument :user_id, :uuid_v7, allow_nil?: false

      run fn input, _ ->
        id = input.arguments.user_id

        following = GlixBackEnd.Accounts.Follow
        |> Ash.Query.for_read(:filter_following, %{user_id: id})
        |> Ash.read!()

        {:ok, length(following)}
      end
    end
  end

  attributes do
  end

  relationships do
    belongs_to :follower, GlixBackEnd.Accounts.User, primary_key?: true, allow_nil?: false
    belongs_to :followed, GlixBackEnd.Accounts.User, primary_key?: true, allow_nil?: false
  end
end
