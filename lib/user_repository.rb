require_relative './user'

class UserRepository
    def all
        sql_query = 'SELECT fullname, user_name, email_address from users'
        all_users = DatabaseConnection.exec_params(sql_query, [])
        users =[] 
        all_users.each do |userObject|
            user = User.new
            user.fullname = userObject['fullname']
            user.user_name = userObject['user_name']
            user.email_address = userObject['email_address']
            users << user
        end
        return users
    end
    def find(id)
        sql_query = 'SELECT fullname, user_name, email_address from users WHERE id = $1'
        param = [id]
        return_results = DatabaseConnection.exec_params(sql_query, param)
        user = return_results[0]
        userObject = User.new
        userObject.fullname = user['fullname']
        userObject.user_name = user['user_name'] 
        userObject.email_address= user['email_address'] 
        return userObject
end
    def create(user)
        sql_query = "INSERT INTO users (fullname, user_name, email_address) VALUES ($1, $2, $3)"
        param = [user.fullname, user.user_name, user.email_address]
        DatabaseConnection.exec_params(sql_query, param)
end
    def delete(id)
        sql_query = "DELETE FROM users WHERE id = $1"
        param = [id]
        DatabaseConnection.exec_params(sql_query, param)
end
end