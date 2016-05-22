class Comment < ActiveRecord::Base
  belongs_to :grant
  belongs_to :user

  after_create :notify_users
  default_scope { order(id: :desc) }

  def context
    @context ||= grant.comments.where("id < ?", id)
  end

  def notify_users
    users =
      if user.admin?
        [grant.user]
      else
        User.admins
      end
    users.each do |user|
      CommentsMailer.comment_email(self, user).deliver
    end
  end
end
