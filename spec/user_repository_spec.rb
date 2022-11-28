require 'user_repository'

def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe UserRepository do
    before(:each) do 
      reset_table
    end
  
  it "returns 2 values" do
  repo = UserRepository.new
  list_of_users = repo.all
  expect(list_of_users.first.fullname).to eq "David D"
  expect(list_of_users.last.fullname).to eq "Anna A"
  expect(list_of_users.first.email_address).to eq 'david1@aol.com'
  expect(list_of_users.last.email_address).to eq 'anna1@aol.com'
  
  end
  it "finds user at ID 1 (David D)" do
    repo = UserRepository.new
    expect(repo.find(1).fullname).to eq "David D"
    expect(repo.find(2).fullname).to eq "Anna A"

end
  it "creates a third user" do
    repo = UserRepository.new
    new_user = User.new
    new_user.fullname = "Ian D"
    new_user.user_name = "ID1"
    new_user.email_address = "iand@aol.com"
    repo.create(new_user)
    expect(repo.all[2].fullname).to eq "Ian D"

end
  it "deletes a user" do
    repo = UserRepository.new
    repo.delete(1)
    expect(repo.all.first.fullname).to eq "Anna A"
    reset_table

end
end