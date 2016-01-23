class LinksController < ApplicationController

  def create
    full_url = params[:full_url]
    nickname = params[:nickname]

    if full_url.present? && nickname.present?
      if Link.exists?(nickname: nickname)
        Link.find_by_nickname(nickname).update_attributes(full_url: full_url)
        redirect_to root_path, notice: "Nickname #{nickname} already existed and was updated."
      else
        Link.create(full_url: full_url, nickname: nickname)
        redirect_to root_path, notice: "Nickname #{nickname} created."
      end
    else
      redirect_to root_path, alert: "full_url and/or nickname not supplied, please try again"
    end
  end

  def list_nicknames
    redirect_to root_path, notice:
          "#{Link.all.collect {|link| link.nickname + " --> " + link.full_url}.join("<br>")}"
  end

  def go_to_url
  nickname = params[:path]
  full_url = Link.find_by_nickname(nickname).try(:full_url)
    if full_url.present?
      redirect_to full_url
    else
      redirect_to root_path, alert: "Page Not Found. Redirecting to root page"
    end
  end
end
