# frozen_string_literal: true

json.call(user, :id, :email, :name, :image)
json.token user.generate_jwt
