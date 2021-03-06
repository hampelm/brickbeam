class GenerateQuestionDigest
  attr_accessor :questions

  def call
    build
    return if questions.size == 0
    send
  end

  private

  def build
    self.questions = Question.where('created_at > ?', 1.day.ago).order(updated_at: :desc)
  end

  def send
    User.subscribed_to_question_digest.find_each do |user|
      Rails.logger.info "Sending digest to user.email."
      NotificationMailer.question_digest_email(user, self.questions).deliver_now
    end
  end
end
