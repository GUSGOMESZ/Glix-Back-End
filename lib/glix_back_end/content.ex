defmodule GlixBackEnd.Content do
  use Ash.Domain,
    otp_app: :glix_back_end

  resources do
    resource GlixBackEnd.Content.Post
    resource GlixBackEnd.Content.PostTag
  end
end
