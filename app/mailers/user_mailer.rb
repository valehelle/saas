class UserMailer < ApplicationMailer

    def announcement_email(email,title,content)
        @content = content
        mail(to: email, subject: title)
      end
end
