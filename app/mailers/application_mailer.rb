class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@instatute.heroku.com'
  layout 'mailer'
end
