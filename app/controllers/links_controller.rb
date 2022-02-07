class LinksController < ApplicationController
  def create
    url = params[:url]
    name = params[:name]

    if url.present? && name.present?
      link = Link.where(name: name).first_or_initialize
      link.url = url
      link.save

      redirect_to root_path, notice: "TinyURL #{name} created/updated."
    else
      redirect_to root_path, alert: 'url and/or name not supplied, please try again'
    end
  end

  def list
    json = Link.all.order(:name).map do |link|
      { name: link.name, url: link.url }
    end

    render json: JSON.pretty_generate(json)
  end

  def go_to_url
    name = params[:path]
    url = Link.find_by_name(name).try(:url)

    if url.present?
      redirect_to url
    else
      redirect_to root_path, alert: 'Page Not Found. Redirecting to home page'
    end
  end
end
