
<p align="center"> <img src="https://media.giphy.com/media/RKApDdwsQ6jkwd6RNn/giphy.gif" /> </p>

<h1 align="center"> CulturePot </h1>

<div align="center"> Stir up the melting pot of UTD's diversity with CulturePot! This app is designed to celebrate our diverse campus. Whether you're looking to practice a new language, share the richness of your cultural heritage, or connect with peers from different backgrounds, CulturePot is the app for you. Join your fellow students in swapping stories, languages, and traditions, and watch as your personal growth simmers to perfection. CulturePot: where every culture has a place in the pot, and different cultures season every conversation.
</div>

## MVP 💰

 -  User Account
	 -   User authentication with username and password
	 -   Personalization - ex: profile photo, personal info, etc.
    -   Add Friends
    -    Allow users to include their native language, country of origin, cultural interests, traditional festivals, and favorite cultural practices to their profile


 - Cultural Showcase Feed
	 -  Users can post about their cultures, such as traditional recipes, music, stories, or holidays.
	 -   Acts as a mini-blog or social media timeline, allowing users to share and celebrate their unique cultural backgrounds.
    -   Allow users to comment on posts on their feed

 -   Language Phrasebook
	 -   Allow users to share common phrases or idioms in their native language
	 -   Complete with translations and usage examples
     -    Help others learn key phrases and understand the nuances of different languages.



      
 - Basic Matchmaking System
	 -   A simple algorithm to match students for language exchange based on their profile information.

## Stretch Goals 🙆
-   Gamification elements like Duolingo: Structured Language Lessons
Interactive Quizzes and Exercises
Daily Goals and Streaks

-  Video Call Integration: Incorporating secure video calling for more immersive language practice and cultural exchanges.
-  Resource Library: A comprehensive library with language learning resources, cultural articles, and recommended multimedia content.
-   Collaboration with Faculty and Organizations: Partnership features with campus organizations and faculty involvement for expert insights and language help.


## Milestones 🏃‍♂️
|Week| Deliverables/Tasks |
|--|--|
| 1 | Meet team, set up development environment, explore ideas using similar apps |
| 2 & 3 | *Front end:* plan pages, create wireframes & code initial screens, get familiar with Flutter widgets, and start designing the UI for the user profile and to-do list. *Back end:* Firebase, create the Firebase project, and set up Firebase Authentication. Set up Firestore for user data. Implement user authentication and creation of user profiles in Firebase. Allow users to add friends. (Week 3)|
| 4 |*Front end:* 50% of app screens, *Back-end:* Implement the interactive to-do list in Firestore, including the ability for users to create, update, and delete tasks. Integrate with Front End|
| 5 | *Front end:* complete 75% of screens, *Back end:* Implement the live feed feature in Firestore. Enable users to post completed tasks with pictures and allow users to comment on these posts,Implement push notifications using Firebase Cloud Messaging (FCM). Notifications should be sent when a task is due soon. Continue to integrate with frontend as needed | 
| 6 & 7 | *Front end:* 100% of app screens, enhancing features/animations, *Back end:* Implement collaborative to-do lists in Firestore. Implement task categories in Firestore. Tasks should be categorizable |
| 8 & 9 | Implement functionality for tracking how many to-do tasks were completed by the user each day, finish integration of Front End and Back End|
| 10 | Practice presentation, final touches|
| 11 | Presentation Night!!|

## Tech Stack 💻
Wireframing: [Figma](https://www.figma.com/)  
Front-end: [Flutter](https://docs.flutter.dev/get-started/install)   
Back-end: Dart & [Firebase](https://firebase.google.com/)   
 
## Helpful Resources/Tutorials 📚
Installation & Set Up:  
[Flutter Installation for Mac OS](https://www.youtube.com/watch?v=fzAg7lOWqVE)    
[Installation guide pt 2 for Mac OS](https://www.youtube.com/playlist?list=PL82uaKJraAII8HJjA98l-M6qb_teI97kW)  
[Flutter Installation for Windows](https://www.youtube.com/watch?v=5JBlvjH8ChA)  
[Flutter Installation for Windows pt 2](https://www.youtube.com/watch?v=fDnqXmLSqtg)  
[Firebase w/ Flutter Set Up](https://www.youtube.com/watch?v=EXp0gq9kGxI&t=15s)  
[Install Android Studios](https://developer.android.com/studio/install?gclid=CjwKCAiAuOieBhAIEiwAgjCvcjwYSPTJuW9nn167xix8BzL8KzlDuCIwczz-JaqpBWLl1LyPWHwV1xoCWf0QAvD_BwE&gclsrc=aw.ds#mac)  
[VS Code](https://code.visualstudio.com/download)  
[Git](https://git-scm.com/downloads)  
[Xcode (for Mac users and the ios emulator and packages](https://apps.apple.com/us/app/xcode/id497799835?mt=12)


Tutorials:  
[Flutter Tutorial](https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ)  
[Figma Tutorial](https://www.youtube.com/watch?v=FTFaQWZBqQ8)  
[Dart Tutorial](https://www.youtube.com/watch?v=veMhOYRib9o&t=812s)  
[Git Tutorial](https://www.youtube.com/watch?v=USjZcfj8yxE)  
[Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)  


[How to implement push notifications with Flutter and Firebase Cloud Messaging](https://www.youtube.com/watch?v=AUU6gbDni4Q)  
[Working with Firebase CRUD and REST API's](https://www.youtube.com/watch?v=ErP_xomHKTw)

    

Quick Read :)
[How to be Successful in Projects](https://docs.google.com/document/d/18Zi3DrKG5e6g5Bojr8iqxIu6VIGl86YBSFlsnJnlM88/edit)

## GitHub Cheat Sheet ᛘ


| Command | Description |
| ------ | ------ |
| **cd "Task-Mate"** | Change directories over to our repository |
| **git branch** | Lists branches for you |
| **git branch "branch name"** | Makes new branch |
| **git checkout "branch name"** | Switch to branch |
| **git checkout -b "branch name"** | Same as 2 previous commands together |
| **git add .**| Finds all changed files |
| **git commit -m "Testing123"** | Commit with message |
| **git push origin "branch"** | Push to branch |
| **git pull origin "branch"** | Pull updates from a specific branch |
| get commit hash (find on github or in terminal run **git log --oneline** ) then **git revert 2f5451f --no-edit**| Undo a commit that has been pushed |
| **git reset --soft HEAD~** | Undo commit (not pushed) but *keep* the changes |
| get commit hash then **git reset --hard 2f5451f** | Undo commit (not pushed) and *remove*  changes |

## Developers 👥
Kruthi Vancha  
Vidur Nangia    
Jack Le   
Leila Igwegbe\
Megan Chacko


Ridwan Amin - *Project Manager*  
Sean Hassan - *Industry Mentor*
