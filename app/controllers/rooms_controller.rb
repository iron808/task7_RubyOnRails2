class RoomsController < ApplicationController
  def index
  end

  def new
    @room  = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
      if @room .save
          @room .attach_default_roomimage unless @room.roomimage.attached?
          redirect_to show_user_facility_room_path(@room), notice: "施設の登録が完了しました"
      else
        render "new"
      end
  end

  def show
    @room = Room.all
  end

  def room_params
    params.require(:room).permit(:room_name, :room_details, :room_rate, :facility_address, :roomimage)
  end

  def show_user_facility
    @user = current_user
    @rooms = @user.rooms
  end

  def show_room
    @room = Room.find(params[:id])
  end

  def detail_room
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit_room
    @room = Room.find(params[:id])
  end

  def search
    @rooms = Room.all

  if params[:area].present?
    @rooms = @rooms.where("facility_address LIKE ?", "%#{params[:area]}%")
  end

  if params[:query].present?
    keyword = "%#{params[:query]}%"
    @rooms = @rooms.where(
      "room_name LIKE :q OR room_details LIKE :q OR facility_address LIKE :q",
      q: keyword
    )
  end

  end

  def update
    @room = Room.find(params[:id])
      if @room.update(params.require(:room).permit(:roomimage, :room_name, :room_details, :room_rate, :facility_address))
      flash[:notice] = "施設情報を更新しました"
      redirect_to show_user_facility_room_path(@room)
      else
      render "edit_room"
      end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to show_user_facility_room_path
  end

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

end
