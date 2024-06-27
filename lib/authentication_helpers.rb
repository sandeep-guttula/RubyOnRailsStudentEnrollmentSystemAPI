module AuthenticationHelpers
  def authenticate!
    header = request.headers["authorization"]
    token = header.split(" ").last if header
    data = JWT.decode(token, "my$ecretK3")
    Current.user = User.find(data[0]["user_id"])
  rescue JWT::DecodeError
    error!("Unauthorized ", 401)
  end

  def current_user
    Current.user
  end

  def authorize_admin!
    error!("Unauthorized, This can be accessed by admins only. Your role: #{Current.user.role}", 401) unless Current.user.role == "admin"
  end

  def authorize_instructor!
    error!("Unauthorized, This can be accessed by instructors and admins only. Your role: #{Current.user.role}", 401) unless Current.user.role == "instructor" || Current.user.role == "admin"
  end

  def authorize_student!
    error!("Unauthorized, This can be accessed by students. Your role: #{Current.user.role}", 401) unless Current.user.role == "student"
  end

end
