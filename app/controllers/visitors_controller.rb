class VisitorsController < ApplicationController

  def go_to_url
  nickname = params[:path]
  full_url = Link.find_by_nickname(nickname).try(:full_url)
    if full_url.present?
      redirect_to full_url
    else
      redirect_to root_path, alert: 'URL nickname not found! Please try again'
    end
  end

end
