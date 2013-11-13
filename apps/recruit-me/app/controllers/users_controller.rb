class UsersController < ApplicationController

  def friends_with
    users = User.in(friends: [BSON::ObjectId.from_string(params[:id])]).limit(10)
    render json: users.to_json
  end

  def skilled_at
    users = User.in(skills: [params[:skill]]).limit(10)
    render json: users.to_json
  end

  def unskilled_at
    users = User.nin(skills: [params[:skill]]).limit(10)
    render json: users.to_json
  end

  def living_in
    users = User.where('address.city' => params[:city]).only(:firstname, :lastname, :address).limit(10)
    render json: users.as_json(only:[:firstname, :lastname, :address])
  end

  def not_from
    users = User.ne('address.country' => params[:country]).only(:firstname, :lastname, :address).limit(10)
    render json: users.as_json(only:[:firstname, :lastname, :address])
  end
end
