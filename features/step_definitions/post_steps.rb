# Scroll to bottom to see post data
module KnowsMyBlog
  def my_blog
    @my_blog ||= Blog.new
  end
end

World(KnowsMyBlog)

class Blog
  def add_post(post)
    if @content
      @content = post + ' \n ' + @content
    else
      @content = post
    end
  end
  
  def content
    @content
  end
end

class Post
  attr_reader :created
  attr_accessor :title, :content
  
  def initialize(title,content)
    @title = title
    @content = content
    @created = Time.now
  end
end

Given /^this post:$/ do |table|
  post_hash = table.rows_hash
  post = Post.new(post_hash['title'],post_hash['content'])
end

When /^I submit this post "(.*?)"$/ do |new_post|
  my_blog.add_post(new_post)
end

Then /^output should be "(.*?)"$/ do |combined_posts|
  my_blog.content.should eq(combined_posts),"Expected the blog contents to be #{combined_posts} but it was #{my_blog.content}"
end

#view_posts.feature
Given /^blog contains post "(.*?)"$/ do |original_post|
  my_blog.add_post(original_post)
  my_blog.content.should eq(original_post),"Expected the blog contents to be #{original_post} but it was #{my_blog.content}"
end
Given /^blog contains posts titled "Post 1" and "Post 2"$/ do
  pending "view posts to do"
end
When /^I view all posts$/ do
  pending "view posts to do"
end
Then /^the output should be "Post 2. \\n Post 1." $/ do
  pending "view posts to do"
end
post1 = <<-POST1
           First steps to Outside-In blog creation:
           Project Start Date: January 24, 2013
           Post Date: January 25, 2013
           Work Methodology: Pomodoro Technique 
           
           Pom 1 (a timebox of 25 min): Feature: Create Post
             i) Launch Oracle Virtual Box
             ii) Load current Linux snapshot vm: crunch10amd64(Snapshot 6)
             iii) Decide on blog name: BOI Blog (Stands for Brett's Outside-In Blog)
             iv) Open terminal
             v) Navigate to projects folder
             vi) $mkdir boiblog
             vii) $cd boiblog
             viii) Open cucumber book to find steps - page 14
             ix) $cucumber -> "...no features directory..."
             x) $mkdir features
             xi) $cucumber -> 0 Scenarios output
             xii) $cd features
             xiii) $touch post.feature
             xiv) open feature file in editor: $geany post.feature
             xv) Write out feature:
                 Feature: Post
                  
                   Scenario: Create a new post
                     Given content to be posted
             xvi) Rename feature to Create Post
             xvii) Rename feature filename to create_post.feature
            
           Pom 2, 3 (so 2 timeboxes and 50 min): Write first post
             i) Review cucumber book on how to add data first time
             ii) Add to step definition file 
             iii) $mkdir features/step_definitions
             iv) $touch post_steps.rb
             v) $geany post_steps.rb
             vi) Decide on post declaration: :post1 = <<-DOC ... DOC
             vii) Decide what to write into first post: 
                  Go with previous Poms of actual code writing.
           POST1
post2 = <<-POST2
           Blog project - Create Post Feature continued
           Project Start Date: January 24, 2013
           Post Date: January 26, 2013
           Work Methodology: Pomodoro Technique 
           
           Pom 1,2: Write sample posts
             i) Post content will be actual posts about this project
             ii) $geany post_steps.rb
             iii) <inserted first post>
             iv) $cucumber 
                 =>
                  Feature: Create Post

                    Scenario: Create a new post
                      Given content to be posted "<post>"
                      When create post is selected
                      Then output should be "<post>"
                      
                  error: ":post1 = <<..."
             v) soln: Change from symbol to var: "post1 = <<..."
             vi) $cucumber
                 =>
                 "...no features..."
             vii) $cd projects/boiblog
             viii) $cucumber
                   =>
                   Feature: Create Post

                      Scenario: Create a new post           # features/create_post.feature:3
                        Given content to be posted "<post>" # features/create_post.feature:4
                        When create post is selected        # features/create_post.feature:5
                        Then output should be "<post>"      # features/create_post.feature:6

                    1 scenario (1 undefined)
                    3 steps (3 undefined)
                    0m0.011s

                    You can implement step definitions for undefined steps with these snippets:

                    Given /^content to be posted "(.*?)"$/ do |arg1|
                      pending # express the regexp above with the code you wish you had
                    end

                    When /^create post is selected$/ do
                      pending # express the regexp above with the code you wish you had
                    end

                    Then /^output should be "(.*?)"$/ do |arg1|
                      pending # express the regexp above with the code you wish you had
                    end
              viv) Edit post_steps.rb to contain suggested step defs (above)
              vv) $cucumber -> "Your block takes 0 arguments..."
              vvi) Edit post_steps.rb to receive arguments for Given and Then steps
              vvii) $cucumber -> 3 pending
           POST2
post3 = <<-POST3
            Blog project - Create Post Feature continued
            Project Start Date: January 24, 2013
            Post Date: January 26, 2013
            Work Methodology: Pomodoro Technique 

            POM 1: Inside-Out Given step for Create Post Feature
              i) $geany post_steps.rb
              ii) remove pending line from Given step
              iii) Add code (following page 112 of book):
                  Given /^blog contains post "(.*?)"$/ do |post|
                    Blog.new(post)
                  end
              iv) $cucumber -> <error: blog doesn't exist>
              v) As in book, define class Blog above Given step:
                  class Blog
                    def initialize(post)
                    end
                  end
              vi) $cucumber -> <first step passed>
              vii) Refactor Notes:  
                a) Blog shouldn't require a post to initialize
                b) Define Blog method to add post
                c) Can't decide on terminology: Add vs Create (*postpone)
              viii) Refactor Blog Class: Remove initialize and add method.  Results:
                  class Blog
                    def add_post(post)
                    end
                  end
              ix) Refactor Given step: add Blog instance var and use method add_post:
                  Given /^blog contains post "(.*?)"$/ do |post|
                    my_blog = Blog.new
                    my_blog.add_post(post)
                  end
              x) $cucumber -> <first step passed>
              
            POM 2: When and Then steps 
              i) Need to check original blog contents
              ii) Add assertion to Given:
                  my_blog.content.should eq(post), "Expected the content to be \#{post} but it was \#{my_blog.content}
              iii) Add content method to class:
                  class Blog
                    def add_post(post)
                    end
                    def content
                    end
                  end
              iv) $cucumber -> "...ExpectationNotMetError..."
              v) Finish content method and add to add_post:
                  class Blog
                    def add_post(post)
                      @content + post
                    end
                    
                    def content
                      @content
                    end
                  end
              vi) $cucumber -> <error: can't add to nil object @content>
              vii) Looked online for how to make this condition the ruby way:
                  class Blog
                    def add_post(post)
                      if @content
                        @content = post + ' \n ' + @content
                      else
                        @content = post
                      end
                    end
                    
                    def content
                      @content
                    end
                  end
              viii) $cucumber -> 1st step passed
              ix) $geany create_post.feature <Refactor for meaningful hard-coded posts>
                  Feature: Create Post

                    Scenario: Successful creation of a new post
                      Given blog contains post "This is post 1."
                      When I add post "This is post 2."
                      Then output should be "This is post 2. \n This is post 1."
              x) $cucumber -> 1 skipped, 1 pending, 1 passed
              xi) $geany post_steps.rb <Replace pending in When step>
                  When /^I add post "(.*?)"$/ do |new_post|
                    my_blog.add_post(new_post)
                  end
              xii) $cucumber -> <error: my_blog unknown in When>
              xiii) Make my_blog an instance var to get pass:
                  Given /^blog contains post "(.*?)"$/ do |post|
                    @my_blog = Blog.new
                    @my_blog.add_post(post)
                    @my_blog.content.should eq(post), "Expected the content to be \#{post} but it was \#{@my_blog.content}
                  end
                  When /^I add post "(.*?)"$/ do |new_post|
                    @my_blog.add_post(new_post)
                  end
                  Then /^output should be "(.*?)"$/ do |arg1|
                    pending # express the regexp above with the code you wish you had
                  end
              xiv) $cucumber -> 2 passed, 1 pending
              xv) Refactor to pull instance out: Put module above class def: (book pg 122):
                  module KnowsMyBlog
                    def my_blog
                      @my_blog ||= Blog.new
                    end
                  end

                  World(KnowsMyBlog)
              xvi) Refactor to pull instance out: Remove @'s from my_blog in steps:
                  Given /^blog contains post "(.*?)"$/ do |post|
                    my_blog.new
                    my_blog.add_post(post)
                    my_blog.content.should eq(post),"Expected the blog contents to be \#{post} but it was \#{my_blog.content}"
                  end

                  When /^I add post "(.*?)"$/ do |new_post|
                    my_blog.add_post(new_post)
                  end

                  Then /^output should be "(.*?)"$/ do |arg1|
                    pending # express the regexp above with the code you wish you had
                  end
              xvii) $cucumber -> <error: second instantiation>
              xviii) Remove instantiation from Given for my_blog (done in module):
                    Given /^blog contains post "(.*?)"$/ do |post|
                      my_blog.add_post(post)
                      my_blog.content.should eq(post),"Expected the blog contents to be \#{post} but it was \#{my_blog.content}"
                    end
              xix) $cucumber -> 2 passed, 1 pending
              xx) Refactor to change working for step args:
                  Given /^blog contains post "(.*?)"$/ do |original_post|
                    my_blog.add_post(original_post)
                    my_blog.content.should eq(original_post),"Expected the blog contents to be \#{original_post} but it was \#{my_blog.content}"
                  end

                  When /^I add post "(.*?)"$/ do |new_post|
                    my_blog.add_post(new_post)
                  end

                  Then /^output should be "(.*?)"$/ do |combined_posts|
                    pending # express the regexp above with the code you wish you had
                  end
              xxi) $cucumber -> 2 passed, 1 pending
              xxii) Replace pending with assertion in Then step
                    Then /^output should be "(.*?)"$/ do |combined_posts|
                      my_blog.content.should eq(combined_posts),"Expected the blog contents to be \#{combined_posts} but it was \#{my_blog.content}"
                    end
              xxiii) $cucumber -> 3 passed
           POST3
post4 = <<-POST4
            Blog project - Create Post Feature continued
            Project Start Date: January 24, 2013
            Post Date: February 15-17, 2013
            Work Methodology: Pomodoro Technique 
            
            POM 1-6: Refactor Create Post
              i) Now that I understand a post and blog better, came up with some new DSL:
                A) Blog defined:
                  1) Core components:
                    a) Title: Never changes, defines the blog by subject and/or point-of-view
                    b) Content (specifically, the main content): Posts
                    c) Intended Audience (<- review if this should stand apart from Goal/Mission)
                    d) Mission (a.k.a. Goal or Mission Statement)
                    e) Visitor (a.k.a. user)
                  2) Other components:
                    a) Style: Fonts, colour scheme, layout, extras (extra features)
                    b) Format (implementation)
                    c) Stages of a blog: 
                      i) Conception
                      ii) Implementation
                      iii) Dynamic
                      iv) Static
                      v) Retirement
                      vi) Destruction
                    d) Metadata (<- review term): Data about the blog (Statistical, administrative, historical)
                    e) Extras (<- review term)
                B) Blog Content defined (<- review relevance, chose this because comments belong to blog-post, not post.  Could a post be used in a different blog?):
                  1) Core components:
                    a) Posts: Brief "stories" relevant to blog title subject area
                  2) Other components: 
                    a) Comments: Blog visitor responses to blog posts
                    b) Archive: Blog content not visible on main page
                      i) Core components:
                        A) Search:
                      ii) Other components:
                        A) Tag cloud:
                        B) Categories:
                C) Blog Extras:
                  1) Components (could be 0):
                    a) Plugins: Bells and whistles not tied to content
                    b) Blogroll: Subject relevant external blog links as chosen by blogger (blog author)
                 
           POST4
post5 = <<-POST5
            Blog project - Design analysis after DSL refactor
            Project Start Date: January 24, 2013
            Post Date: February 18, 2013
            Work Methodology: Pomodoro Technique 
            
            POM 1: Decisions on design:
              i)  Posts are part of the blog (ideologically):  KiSS (Keep it Simple Stupid)
              ii) The term "Content" is too vague to stand on it's own so break it up
              iii) Blog title defines blog (by representing subject and/or point-of-view)
              iv) Since blog is, by definition, a web-based journal, conceptual distinction can be made around web pages or page groups.  For Example:
                A) Main page
                B) View post page
                C) Edit post page
                D) Create post page
                E) Archive page
                F) Admin page
              v) Terminology for people using blog:
                A) Blogger (blog author)
                B) Visitor (regular blog user/guest)
              vi) Decisions outstanding:
                A) Notifications (Errors and other)
                B) Metadata
           POST5
Post6 = <<-POST6
            Blog project - View Posts
            Project Start Date: January 24, 2013
            Post Date: March 10, 2013
            Work Methodology: Pomodoro Technique 
            
            POM 1: Second Feature
              i) Decisions on design:
                A) Decided against "View Main Page" or "View Home Page" as the medium isn't important at this stage - kiss
                B) Decided the Blog title should be something like "Blogging my blog" - more specific to the posts I'm creating right now
                C) Considered refactoring Feature: Create Post into a scenario of Feature: Manage Posts but decided against it - too general
                D) New feature to be Feature: View Posts
              ii) Second Feature:  View Posts
                A) Will require refactor of Create Post as it contains similar test as it tests viewing and therefore duplicates what View Posts does.
                
          POST6
          
           
