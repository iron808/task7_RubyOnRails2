class ReservationsController < ApplicationController
  def index
  end

  def new
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.fetch(:reservation, {}).permit(:checkin_day, :checkout_day, :number_of_guests)
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)

    @reservation.user = current_user
    @reservation.room = @room

    if @reservation.checkin_day.present? && @reservation.checkout_day.present?
      @reservation.number_of_night = (@reservation.checkout_day - @reservation.checkin_day).to_i
    end

    if @reservation.number_of_night.present? && @reservation.number_of_guests.present?
      @reservation.payment = @room.room_rate * @reservation.number_of_night * @reservation.number_of_guests
    end

    if @reservation.valid?
      render :confirm
    else
      render 'rooms/detail_room', locals: { reservation: @reservation }
    end

  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.room_id = params[:room_id]

    @reservation.room = @room
    
    @reservation.confirmed_day = Time.current

    if @reservation.checkin_day.present? && @reservation.checkout_day.present?
      @reservation.number_of_night = (@reservation.checkout_day - @reservation.checkin_day).to_i
    end

    if @reservation.number_of_night.present? && @reservation.number_of_guests.present?
      @reservation.payment = @room.room_rate * @reservation.number_of_night * @reservation.number_of_guests
    end

    if @reservation.save
      redirect_to @reservation
    else
      render 'rooms/detail_room', locals: { reservation: @reservation }
    end

  end

  def edit
  end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to show_user_reservations_user_path(current_user), notice: "予約が削除されました"
  end

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

end
