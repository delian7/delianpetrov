class ContactMailer < ApplicationMailer
  default from: 'hello@delianpetrov.com'

  def contact_form(name, email, phone, message)
    @name = name
    @email = email
    @phone = phone
    @message = message

    mail(to: 'hello@delianpetrov.com', subject: "#{@name} contacted you via delianpetrov.com", reply_to: @email)
  end
end
