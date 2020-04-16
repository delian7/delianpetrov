class LinksController < ApplicationController

  def create
    url = params[:url]
    name = params[:name]

    if url.present? && name.present?
      Link.create(url: url, name: name)
      redirect_to root_path, notice: "TinyURL #{name} created/updated."
    else
      redirect_to root_path, alert: "url and/or name not supplied, please try again"
    end
  end

  def list
    json = Link.all.map do |link|
      {:name => link.name, :url => link.url}
    end

    render :json => JSON.pretty_generate(json)
  end

  def go_to_url
    name = params[:path]
    url = Link.find_by_name(name).try(:url)
      if url.present?
        redirect_to url
      else
        redirect_to root_path, alert: "Page Not Found. Redirecting to root page"
      end
  end
end
