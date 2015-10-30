class PhonesController < ApplicationController
  load_and_authorize_resource

  def index
    # @phones = Phone.accessible_by(current_ability)
    # @page_title = "List Phone Number"
  end

  def show
    # @phone = Phone.find(params[:id])
  end

  def new
    # @phone = Phone.new
    @contact_id = params[:contact_id]
    # binding.pry
  end

  def create
    # @phones = Phone.all #load all phones data utk ditampilkan lg
    @phones = Phone.accessible_by(current_ability)

    @phone = Phone.new(phone_params)
    # @phone = Phone.new(params[:phone]) tdk secure

    @phone.save
    # redirect_to phones_path
    # redirect_to @phone #redirect the user to the show action
  end

  def edit
    @phone = Phone.find(params[:id])
  end

  def update
    # @phones = Phone.all
    @phones = Phone.accessible_by(current_ability)
    @phone = Phone.find(params[:id])

    @phone.update_attributes(phone_params)
  end

  def delete
    @phone = Phone.find(params[:phone_id]) #routes -> phone_delete GET /phones/:phone_id/delete(.:format) phones#delete
  end

  def destroy
    @phones = Phone.accessible_by(current_ability)
    @phone = Phone.find(params[:id])
    @phone.destroy
  end

  private
    def phone_params
      params.require(:phone).permit(:phone_number, :phone_title, :contact_id)
    end
end
