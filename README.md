# Project 3 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling
- [x] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [x] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen
- [x] User can like a post and see number of likes for each post in the post details screen
- [ ] Style the login page to look like the real Instagram login page
- [ ] Style the feed to look like the real Instagram feed
- [ ] Implement a custom camera view

The following **additional** features are implemented:
- Custom section headers to display username/creation time for each post

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Better database design for likes, comments, etc.
2. Better methods for updating views that can improve loading speed.

## Video Walkthrough
The first video shows a quick demo of the app's required features. The second demonstrates user persistence after app restarts. The third demonstrates all completed stretch features.
<p float="left">
<img src='Demo/instagram1.gif' title='Video Walkthrough' alt='Video Walkthrough' width='200'/>
<img src='Demo/instagram2.gif' title='Persistence Walkthrough' alt='Persistence Walkthrough' width='200'/> 
<img src='Demo/instagram3.gif' title='Stretch Walkthrough' alt='Stretch Walkthrough' width='200'/> 
</p>

## Credits

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Parse](https://docs.parseplatform.org/ios/guide/) - backend service

## Notes


## License

    Copyright [2022] [Catherine Lu]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
