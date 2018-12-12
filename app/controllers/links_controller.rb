class LinksController < ApplicationController

  def create
    url = params[:url]
    name = params[:name]

    if url.present? && name.present?
      existing_link = Link.find_by_name name
      if existing_link.present?
        existing_link.update(url: url)
        redirect_to root_path, notice: "Link with name #{name} already existed and was updated."
      else
        Link.create(url: url, name: name)
        redirect_to root_path, notice: "Link with name #{name} created."
      end
    else
      redirect_to root_path, alert: "url and/or name not supplied, please try again"
    end
  end

  def list
    redirect_to root_path, notice:
          "#{Link.all.collect {|link| link.name + " --> " + link.url}.join("<br>")}"
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
