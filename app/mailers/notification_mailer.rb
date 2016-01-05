class NotificationMailer < ApplicationMailer

  def new_comment_email(user, comment)
    @user = user
    @comment = comment
    title = @comment.question.title

    attachments.inline['logo.png'] = File.read(Rails.root.to_s + '/app/assets/images/emails/bbd_logo2.png')
    mail(to: @user.email, subject: 'New comment on ' + title)
  end
end
