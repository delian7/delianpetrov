class LinksController < ApplicationController

  def create_small_url
    full_url = params[:full_url]
    nickname = params[:nickname]

    if full_url.present? && nickname.present?
      Link.create(full_url: full_url, nickname: nickname)
      redirect_to root_path, notice: "Nickname #{nickname} created."
    else
      redirect_to root_path, alert: "full_url or nickname not supplied, please try again"
    end
  end

  def go_to_url
  nickname = params[:path]
  full_url = Link.find_by_nickname(nickname).try(:full_url)
    if full_url.present?
      redirect_to full_url
    else
      redirect_to root_path, alert: 'Page Not Found. Redirecting to root page'
    end
  end
end
