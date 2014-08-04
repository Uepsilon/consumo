class RealmsController < ApplicationController
  def index
    @realms = Realm.all
  end

  def show
    @realm = Realm.find params[:id]
  end

  def new
    @realm = Realm.new
  end

  def create
    @realm = Realm.new realm_params

    if @realm.save
      redirect_to :realms, notice: "Mandant erstellt."
    else
      render :new
    end
  end

  def edit
    @realm = Realm.find params[:id]
  end

  def update
    @realm = Realm.find params[:id]

    if @realm.update_attributes realm_params
      redirect_to :realms, notice: "Mandant geändert."
    else
      render :edit
    end
  end

  private

  def realm_params
    params.require(:realm).permit(:name)
  end
end
