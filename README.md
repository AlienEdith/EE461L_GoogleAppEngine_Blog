# Google App Engine: Blog

### Styling

### Function

#### Landing
- [x] Show only 5 posts 
- [x] Login Redirect
- [x] New Post Redirect
- [x] Show All Post Button
- [x] Subscribe Button
- [x] Unsubscribe Button

#### Login
- [x] Normal Login
- [x] Login Auth when Create New Post
      (**Now**: will redirect when click new post button , haven't test the actully request)

#### Posting
- [x] Create New Post
- [x] Cancel Button

#### Access to Posts
- [x] Show all posts
     - [x] do Logic in .jsp file
     - [x] do Login in servlet, pass data to .jsp file
- [ ] Detail Individual Post Page (**Optional**)
- [ ] "Previous/Next" (**Optional**)

#### Cron
 - [x] Add User to Subscriber Collection
 - [x] Delete User from Subscriber Collection
 - [x] Add Cron
 - [x] Send Email
 - [x] Testing Email List
#### Issue
- Add "BlogCollection" ?
- Show message when subscribe/unsubscribe
- UTC shown on webpage, CST stored in datastore
- GMT on Dashboard - Cron jobs => manully convert in cron.xml
