# Google App Engine: Blog

### Styling

### Function

#### Landing
- [ ] Show only 5 posts 
  (**Now**: show ALL!)
- [x] Login Redirect
- [x] New Post Redirect
- [x] Show All Post Button

#### Login
- [x] Normal Login
- [x] Login Auth when Create New Post
      (**Now**: will redirect when click new post button , haven't test the actully request)

#### Posting
- [x] Create New Post
      (**Now**: seems working......need more test)
- [x] Cancel Button

#### Access to Posts
- [x] Show all posts
      (**Issue**: login all in JSP, can it be done in .doGet()? how to passed data to redirect page? => **Is "render" available?**)
- [ ] "Previous/Next" (**Optional**)

#### Cron
**Haven't start yet**

#### Issue
- Is "BlogCollection" necessary????
  Now it's pure hard-coded, **may** need to add the feature later, so user can have different blogCollection
