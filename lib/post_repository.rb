require_relative './post'
class PostRepository
def all 
    sql_query = 'SELECT id, title, content,view_count, users_id from post'
    post_data = DatabaseConnection.exec_params(sql_query, [])
    posts =[]
    post_data.each do |postObj|
        post = Post.new
        post.id = postObj['id']
        post.title = postObj['title']
        post.content = postObj['content']
        post.view_count = postObj['view_count'].to_i
        post.users_id = postObj['users_id'].to_i
        posts << post
    end
    return posts
end
def find(id)
    sql_query = 'SELECT id, title, content, view_count, users_id from post WHERE id = $1'
    param = [id]
    returned_post = DatabaseConnection.exec_params(sql_query, param)
    post_item = Post.new
    post_item.id = returned_post[0]['id']
    post_item.title = returned_post[0]['title']
    post_item.content = returned_post[0]['content']
    post_item.view_count = returned_post[0]['view_count'].to_i
    post_item.users_id = returned_post[0]['users_id'].to_i
    return post_item
end
def create(post)
    sql_query = 'INSERT INTO post (title, content, view_count, users_id) VALUES ($1, $2, $3, $4)'
    param = [post.title, post.content, post.view_count, post.users_id]
    DatabaseConnection.exec_params(sql_query,param)
end
def delete(id)
    sql_query = 'DELETE FROM post WHERE id = $1'
    param = [id]
    DatabaseConnection.exec_params(sql_query, param)
end
end