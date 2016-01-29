namespace :question_digest do
  desc 'Create and send a question digest'
  task :create_and_send => :environment do
    generator =  GenerateQuestionDigest.new
    generator.call

    Rails.logger.info "Sent digest."
  end
end
