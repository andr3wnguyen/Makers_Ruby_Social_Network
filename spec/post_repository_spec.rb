require 'post_repository'

def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe PostRepository do
    before(:each) do 
      reset_table
    end
  it "retrieves all posts" do
    post = PostRepository.new
    list_of_posts = post.all
    expect(list_of_posts.length).to eq 3
    expect(list_of_posts[0].title).to eq "First"
    expect(list_of_posts[0].content).to eq 'This is my first entry'
    expect(list_of_posts[0].view_count).to eq 2
    expect(list_of_posts[0].users_id).to eq 1

  end
  it "finds a post at a given value" do
    post = PostRepository.new
    expect(post.find(1).title).to eq 'First'
    expect(post.find(1).content).to eq 'This is my first entry'
    expect(post.find(1).view_count).to eq 2
    expect(post.find(1).users_id).to eq 1

end
it "creates a post" do
    postRepo = PostRepository.new
    post = Post.new
    post.title = 'Test'
    post.content = 'Just a test'
    post.view_count = 1200
    post.users_id = 2
    postRepo.create(post)
    expect(postRepo.all.length).to eq 4
    expect(postRepo.find(4).title).to eq 'Test'
    expect(postRepo.find(4).content).to eq 'Just a test'
    expect(postRepo.find(4).view_count).to eq 1200
    expect(postRepo.find(4).users_id).to eq 2


end
it "deletes a post at a given id" do
    postRepo = PostRepository.new
    expect(postRepo.all.length).to eq 3
    expect(postRepo.find(postRepo.all.length).content).to eq 'This is my second entry'
    postRepo.delete(3)
    expect(postRepo.all.length).to eq 2
    expect(postRepo.find(postRepo.all.length).content).to eq 'This is also my first entry'

end
end