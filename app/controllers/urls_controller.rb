class UrlsController < ApplicationController
  
  # respond_to :html, :json, :js

  def new
    @url = Url.new
  end

  # POST /urls
  # Creates a new shortened url
  def create

    @url = Url.new(params[:url])

    # Create the shortened version of the url
    #begin

    #  short_id = (0...8).map{65.+(rand(25)).chr}.join
    #  results = Url.where(:short_url => short_id);

    #end while results.length > 0

    #@url.short_url = short_id

    #@url.short_url = params[:url][:url];

    #binding.pry
    
    respond_to do |format|

      if @url.save

        flash.now[:notice] = 'URL was successfully shortened.'
        format.js

      else

        if (@url.id == nil)
          format.html { render :action => "new" }
        else
          format.js
        end

      end

    end

  end

  # GET /urls/goto/shortened
  # Sends the user to the desired link
  def show

    @long = params[:id].to_i(36)

    if Url.exists?(@long)

      @url = Url.find(@long).url

      redirect_to @url

    else
      redirect_to root_path
    end

  end

  # For JS API --------------------------

  # POST /urls_api
  def create_api

    binding.pry
    @url = Url.new(:url => params[:url])

    if @url.save
      url_hash = Hash.new

      url_hash[:short_url] = root_url.to_s() + "urls_api/" +  (@url.id).to_s(36)
      url_hash[:url] = @url.url

      render :json => url_hash.to_json
    end

    # a = Hash.new
    # a["x"] = "hola"

    # render :json => a.to_json

  end

  # GET /urls_api/goto/shortened
  def show_api

    url_hash = Hash.new

    #binding.pry

    @long = params[:id].to_i(36)

    if Url.exists?(@long)

      @url = Url.find(@long).url
      
      url_hash[:short_url]  = root_url.to_s() + "urls_api/" + params[:id]
      url_hash[:url] = @url
      
      render :json => url_hash.to_json

    end

  end

end
