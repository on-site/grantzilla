class CommentsMailer < ApplicationMailer
  def comment_email(comment, user)
    @comment = comment
    mail to: user.email,
         subject: "New comment on grant for #{@comment.grant.people.to_sentence}"
  end
end
