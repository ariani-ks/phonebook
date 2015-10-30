class ContactsController < ApplicationController
  load_and_authorize_resource

  def dashboard

  end

  def index
    @contacts = Contact.accessible_by(current_ability).order(:id).page(params[:page]).per(5)
    @page_title = "List Contacts"
    # @abc = Phone.find(1) mencari phone ber id 1
  end

  def show
    # @contact = Contact.find(params[:id])
  end

  def new
    # @contact = Contact.new
  end

  def create
    # @phones = Phone.all #load all phones data utk ditampilkan lg
    @contacts = Contact.accessible_by(current_ability)

    @contact = Contact.new(contact_params)
    # @phone = Phone.new(params[:phone]) tdk secure

    @contact.user_id = current_user.id
    @contact.save
    # redirect_to phones_path
    # redirect_to @phone #redirect the user to the show action
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    # @phones = Phone.all
    @contacts = Contact.accessible_by(current_ability)
    @contact = Contact.find(params[:id])

    @contact.update_attributes(contact_params)
  end

  def delete
    @contact = Contact.find(params[:contact_id]) #routes -> contact_delete GET /contacts/:contact_id/delete(.:format) contacts#delete
  end

  def destroy
    @contacts = Contact.all
    @contact = Contact.find(params[:id])
    @contact.destroy
  end

  def get_phones
    # binding.pry
    @phones = Phone.where(:contact_id => params[:param_contact_id])
    respond_to do |format|
      # format.html # index.html.erb, tdk render template
      format.json  { render :json => @phones }
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name)
    end
end
