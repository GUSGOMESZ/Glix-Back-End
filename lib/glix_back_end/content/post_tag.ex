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
      action :get_trendings, :get_trendings
    end
  end

  postgres do
    table "post_tags"
    repo GlixBackEnd.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]

    action :get_trendings, :map do
      run fn _, _ ->
        result = GlixBackEnd.Repo.query!("""
          SELECT tag, COUNT(*) as count
          FROM post_tags
          GROUP BY tag
          ORDER BY count DESC
          LIMIT 5
        """)

        trending_tags = result.rows
        |> Enum.map(fn [tag, count] ->
          %{
            tag: tag,
            count: count
          }
        end)

        {:ok, trending_tags}
      end
    end
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
