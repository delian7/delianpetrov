class ContactMailer < ApplicationMailer
  default from: 'delian7@gmail.com'

  def contact_form(name, email, phone, message)
    @name = name
    @email = email
    @phone = phone
    @message = message

    mail(to: "delian7@gmail.com", subject: "#{@name} contacted you via delianpetrov.com", reply_to: @email)
  end
end
