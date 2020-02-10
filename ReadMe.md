On the project I did complete all what you did ask for. I didn’t do the 3 bonus points. But while working on this project I understood the importance of Clean Swift Architecture which would’ve made the code cleaner, and the Unit Testing: the code safer. For the third point, I guess it would’ve took an observer to check validity of the account (with MVC, I would need to put this observer on all views…).

# Bugs on the app:
* MapView: for iOS 11 and newer, when pressed on the MarkerAnnotation, it sends you to the DetailViewController, by coming back to the map, the annotation stays look bigger than others, you need to press somewhere else on map to resize it.

* Sometimes I get an error message on the console saying “atlas destroyed..”, it is related to MKMapView (info found through Google & StackOverFlow). I don’t know if it is related to memory management (I am may be having a memory leak).

* Rotation on gallery works well when you navigate from MapView to Details (press directly on the annotation from the map) and then press on the image at the top. But sometimes the scrollView (which takes care of the zooming function) bugs a little bit on the landscape mode. However, when you go to Details from the collectionView in the ListViewController (MapView, to List and then tap on a Collection View Cell) the rotation doesn’t enable in the gallery. I may think the problem is related with the fact that I present a navigation controller from MapView to ListView (And not pushing the list view using the same navigation controller). But everything works perfectly on portrait mode.

# Things I would do if I had more time:
* Learn more about Clean Swift and Unit Testing and implement (to improve the architecture and scalabality of the whole app.)
* Search more about the tool that will let me check for availability of the firebase user’s account (if disabled, send user to Landing View) (I am having Observers in my mind, but it will definitely require more in-depth researches).
* I would try to fix the bugs enumerated above.
* Redesign the Login Facebook button to make the difference between “Sign in” and “Sign out” and to make it thicker.
* Disable automatic dark mode for now.
* Make the status bar light on the dark views (for example DetailViewController and GalleryViewController).

# Cocoapods used:
* Firebase SDK
* Facebook SDK
