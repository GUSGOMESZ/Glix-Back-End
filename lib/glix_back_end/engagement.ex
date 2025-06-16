defmodule GlixBackEnd.Engagement do
  use Ash.Domain,
    otp_app: :glix_back_end

  resources do
    resource GlixBackEnd.Engagement.Comment
    resource GlixBackEnd.Engagement.LikePost
    resource GlixBackEnd.Engagement.LikeComment
  end
end
