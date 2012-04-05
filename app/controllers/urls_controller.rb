class UrlsController < ApplicationController
  
  # respond_to :html, :json, :js

  skip_before_filter :verify_authenticity_token

  def new
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  # Creates a new shortened url
  def create

    @url = Url.new(params[:url])

    # Create the shortened version of the url
    begin

      short_id = (0...8).map{65.+(rand(25)).chr}.join
      results = Url.where(:short_url => short_id);

    end while results.length > 0

    @url.short_url = short_id

    # @url.short_url = params[:url][:url];

    respond_to do |format|

      if @url.save

        flash[:notice] = 'URL was successfully shortened.'
        flash[:short_id] = @url.short_url

        #flash[:short_id] = @short_url.id

        #render :json => @url.to_json
        # redirect_to new_url_url
        
        # Luego usar @url.url o @url.short_url en el JS

        # respond_with(@url, :location => new_url_url)
        format.html { redirect_to (new_url_url) }
        format.js # { render :json => @url }
      else
        format.html { render :action => "new" }
        format.js
      end
    end

  end

  def show

    # Aqui va lo del GET :)
    @url = Url.find(params[:id])
    #render :json => @url.to_json

    #redirect_to (@url.short_url).url

    #redirect_to @short_url.url
  end


end
