class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_organizer!, :only => [:create, :update, :new, :edit, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.sorted_by_date
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    if organizer_signed_in?
      @event = Event.new
    end
  end

  # GET /events/1/edit
  def edit
    if organizer_signed_in?
      @event = Event.friendly.find(params[:id])
    end
  end

  # POST /events
  # POST /events.json
  def create
    if organizer_signed_in?
      @event = Event.new(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render action: 'show', status: :created, location: @event }
        else
          format.html { render action: 'new' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if organizer_signed_in?
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if organizer_signed_in?
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.friendly.find(params[:id])
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != event_path(@event)
      #return redirect_to @event, :status => :moved_permanently
      # TODO: fix to not break /edit
    end
    
    #logger.debug "UUUUUUUUUGGGGGGGGGGHHHHHHHHH header image always blank: #{ params[:header_image_file] }"
    # File upload stuffs
    #unless params[:header_image_file].nil?
    #  uploaded_io = params[:header_image_file]
      
    #  File.open(Rails.root.join('public', 'header_backgrounds', uploaded_io.original_filename), 'wb') do |file|
    #    file.write(uploaded_io.read)
        # Not sure about the elegance of this approach, but more mechanically simpler than Paperclip
    #    params[:header_image] = '/header_backgrounds/' + uploaded_io.original_filename
    #  end
    #end # doesn't work
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:city, :theme, :hackathon_start, :hackathon_end, :show_start, :show_end, :about, :hack_rsvp_url, :show_rsvp_url, :venue_id, :theme_excerpt, :header_image, :header_image_artist, :header_image_artist_website, :featured_video, :press_blurbs_attributes => [:id, :headline, :source_name, :source_url, :logo_uri, :featured, :event_id, :_destroy], :projects_attributes => [:id, :name, :description, :tag, :event_id, :main_image, :_destroy], :sponsors_attributes => [:id, :name, :website, :logo, :event_id, :_destroy])
  end
end
