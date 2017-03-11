class NotificationMailer < ApplicationMailer

  def new_comment_email(user, comment)
    @user = user
    @comment = comment
    title = @comment.question.title

    attachments.inline['logo.png'] = File.read(Rails.root.to_s + '/app/assets/images/emails/bbd_logo2.png')
    mail(to: @user.email, subject: 'New comment on ' + title)
  end

  def new_contractor_email(user, contractor)
    @user = user
    @contractor = contractor
    @contractor_admin_url = root_url + rails_admin.show_path(model_name: 'contractor', id: @contractor.id)
    title = @contractor.title

    attachments.inline['logo.png'] = File.read(Rails.root.to_s + '/app/assets/images/emails/bbd_logo2.png')
    mail(to: @user.email, subject: 'New contratctor recommendation: ' + title)
  end

  def contact_user_email(from, to, body)
    @from = from
    @user = to
    @body = body

    attachments.inline['logo.png'] = File.read(Rails.root.to_s + '/app/assets/images/emails/bbd_logo2.png')
    mail(from: from.email, to: @user.email, subject: 'A Brick + Beam user has contacted you')
  end

  def question_digest_email(user, questions)
    @questions = questions
    attachments.inline['logo.png'] = File.read(Rails.root.to_s + '/app/assets/images/emails/bbd_logo2.png')
    mail(to: user.email, subject: 'New rehab questions on Brick + Beam Detroit')
  end
end
