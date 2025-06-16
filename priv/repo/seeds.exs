# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GlixBackEnd.Repo.insert!(%GlixBackEnd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

tags = [
  %{tag: "Elixir"},
  %{tag: "Phoenix"},
  %{tag: "Ash Framework"},
  %{tag: "NodeJS"},
  %{tag: "React"},
  %{tag: "TypeScript"},
  %{tag: "PostgreSQL"},
  %{tag: "JavaScript"},
  %{tag: "HTML/CSS"},
  %{tag: "APIs REST"},
  %{tag: "GraphQL"},
  %{tag: "Testes Automatizados"},
  %{tag: "Deploy"},
  %{tag: "Docker"},
  %{tag: "UI/UX"},
  %{tag: "Orientação a Objetos"},
  %{tag: "Programação Funcional"},
  %{tag: "Git"},
  %{tag: "Performance"},
  %{tag: "Segurança"}
]

Enum.each(tags, fn %{tag: description} ->
  case GlixBackEnd.Repo.get_by(GlixBackEnd.Taxonomy.Tag, description: description) do
    nil ->
      GlixBackEnd.Repo.insert!(%GlixBackEnd.Taxonomy.Tag{description: description})
      _ -> :ok
  end
end)
