class VisitorsController < ApplicationController

  def send_email
    ContactMailer.contact_form(params[:name], params[:email], params[:phone], params[:message]).deliver_now

    respond_to do |format|
      format.html {render( :json => "email sent" )}
    end
  end
end
