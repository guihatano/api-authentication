json.(user, :id, :email, :name, :image)
json.token user.generate_jwt
