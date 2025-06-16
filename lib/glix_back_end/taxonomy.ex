defmodule GlixBackEnd.Taxonomy do
  use Ash.Domain,
    otp_app: :glix_back_end

  resources do
    resource GlixBackEnd.Taxonomy.Tag
  end
end
