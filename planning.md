# {{TABLE NAME}} Model and Repository Classes Design Recipe

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.



Table: user

Columns:
id (PK) serial | user_name text| email_address text

Table2: post
Columns:
id (primary key) serial | title text | content text | view_count int| user (FK) int



## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_user.sql)
CREATE TABLE user (
    id SERIAL PRIMARY KEY, 
    user_name text,
    email_address text
);

TRUNCATE TABLE user RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user  (name, user_name, email_address) VALUES ('David D', 'DD1', 'david1@aol.com');
INSERT INTO user  (name, user_name, email_address) VALUES ('Anna A', 'AA1','anna1@aol.com');


-- EXAMPLE
-- (file: spec/seeds_post.sql)
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    title text,
    content text,
    view_count int,
    user_id INT
    CONSTRAINT fk_user foreign key(user_id) REFERENCES user(id) ON DELETE CASCADE
);

TRUNCATE TABLE post RESTART IDENTITY; -- replace with your own table name.

INSERT INTO post (title, content, view_count, user_id) VALUES ('First', 'This is my first entry', 2, 1);
INSERT INTO post (title, content, view_count, user_id) VALUES ('First entry', 'This is also my first entry', 5, 2);
INSERT INTO post (title, content, view_count, user_id) VALUES ('Second', 'This is my second entry', 22, 1);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: user, post

# Model class
# (in lib/user.rb)
class User
end

class Post
end



# Repository class: user_repository, post_repository
# (in lib/user_repository.rb)
class UserRepository
end


class PostRepository
end


## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class User

  attr_accessor :id, :user_name, :email_address
end

class Post
    attr_accessor :id, :title, :content, :view_count, :user_id
end


## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: user

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM user;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM user WHERE id = $1;

    # Returns a single User object.
  end

  # def create(user)
  # INSERT INTO user (user_name, email_address) VALUES ($1, $2)
  # params = [user.user_name, user.email_address]
  #returns nothing
  # end

  # def delete(id)
  # DELETE FROM user WHERE id = $1
  #params = [id]
  #return nil 
  # end
end


class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM post;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM post WHERE id = $1;
    #param = [id]
    # Returns a single User object.
  end

   def create(post)
  # INSERT INTO post (title, content, view_count, user_id) VALUES ($1, $2, $3, $4)
  # params = [post.title, post.content, post.view_count, post.id]
  #returns nothing
   end

  # def delete(id)
  # DELETE FROM post WHERE id = $1
  #params = [id]
  #return nil 
  # end
end
```








## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new

user = repo.all

user.length # =>  2
user
user[0].id # =>  1
user[0].name # =>  'David D'
user[0].email_address # =>  'david1@aol.com'

user[1].id # =>  2
user[1].name # =>  'Anna A'
user[1].email_address # =>  'anna1@aol.com'



repo = UserRepository.new

user = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'david1@aol.com'

# Add more examples for each method



#3 create user
user = User.new
user.user_name = 'Ben B' 
user.email_address = 'Ben1@aol.com'

repo = UserRepository.new 
repo.create(user)
users =repo.all
user[3].name => 'Ben B' 

#4 delete user

repo = UserRepository.new
repo.delete(1)
users = repo.all
users.first.name => 'Anna A'

# POST REPO
# 1
# Get all posts

repo = PostRepository.new

post = repo.all

post.length # =>  3
post[0].id # =>  1
post[0].title # =>  'First'
post[0].content # =>  'This is my first entry'
post[0].view_count # =>  2
post[0].user_id # =>  1

post[1].id # =>  2
post[1].title # =>  'First'
post[1].content # =>  'This is also my first entry'
post[1].view_count # =>  5
post[1].user_id # =>  2

post[2].id # =>  3
post[2].title # =>  'Second'
post[2].content # =>  'This is my second entry
post[2].view_count # =>  22
post[2].user_id # =>  1

 2
# Get a single user

repo = PostRepository.new

post = repo.find(1)

post.title # =>  'First'
post.content # =>  'This is my first entry'
post.view_count # =>  2
post.user_id => 1
# Add more examples for each method



#3 create post
post = Post.new
post.title = 'Second entry' 
post.content = 'Hello World'
post.view_count = 5
post.user_id = 2

postrepo = PostRepository.new
postrepo.create(post)
posts = postrepo.all
posts[4].title = 'Second entry'
posts[4].content = 'Hello World'
posts[4].view_count = 5
posts[4].user_id = 2


#4 delete post

postrepo = PostRepository.new
postrepo.delete(1)
posts = repo.all
posts.first.content=> 'This is also my firsty entry'
posts.first.title => 'First'
posts.view_count => 5
posts.user_id => 2

);


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_table
  seed_sql = File.read('spec/seeds_students.sql')
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
expect(list_of_users.first.name).to eq "David D"
expect(list_of_users.last.name).to eq "Anna A"
expect(list_of_users.first.email).to eq 'david1@aol.com'
expect(list_of_users.last.email).to eq 'anna1@aol.com'

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

