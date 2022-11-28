
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'



DatabaseConnection.connect('social_network')

post = PostRepository.new
users = UserRepository.new

postRepo = post.all
userRepo = users.all


postRepo.each do |object| 
    p object.content
end

userRepo.each do |object|
    p object.fullname
end
