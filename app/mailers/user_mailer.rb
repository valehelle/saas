class UserMailer < ApplicationMailer

    def announcement_email(text)
        mail(to: "hazmiirfan92@gmail.com", subject: text)
      end
end
