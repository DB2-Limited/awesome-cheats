# Implementing Search-on-type with RxJava

## Default solution
 Just put a search box on the page (probably in the action bar), wire up the onTextChange event handler, and do the search.
 
   ```java
   override fun onCreateOptionsMenu(menu: Menu?): Boolean {
      menuInflater.inflate(R.menu.menu_main, menu)
      val searchView = menu?.findItem(R.id.action_search)?.actionView as SearchView

      // Set up the query listener that executes the search
      searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
          override fun onQueryTextSubmit(query: String?): Boolean {
              Log.d(TAG, "onQueryTextSubmit: $query")
              return false
          }

          override fun onQueryTextChange(newText: String?): Boolean {
              Log.d(TAG, "onQueryTextChange: $newText")
              return false
          }
      })

      return super.onCreateOptionsMenu(menu)
  }
  ```
  *problem* - If you try to enter something like this
  
   ```{D/MainActivity: onQueryTextChange: TES
   D/MainActivity: onQueryTextChange: TE
   D/MainActivity: onQueryTextChange: T
   D/MainActivity: onQueryTextChange: 
   D/MainActivity: onQueryTextChange: S
   D/MainActivity: onQueryTextChange: SO
   D/MainActivity: onQueryTextChange: SOM
   D/MainActivity: onQueryTextChange: SOME
   D/MainActivity: onQueryTextChange: SOMET
   D/MainActivity: onQueryTextChange: SOMETH
   D/MainActivity: onQueryTextChange: SOMETHI
   D/MainActivity: onQueryTextChange: SOMETHIN
   D/MainActivity: onQueryTextChange: SOMETHING
   D/MainActivity: onQueryTextChange: SOMETHING 
   D/MainActivity: onQueryTextChange: SOMETHING E
   D/MainActivity: onQueryTextChange: SOMETHING EL
   D/MainActivity: onQueryTextChange: SOMETHING ELS
   D/MainActivity: onQueryTextChange: SOMETHING ELSE
   D/MainActivity: onQueryTextChange: SOMETHING ELSE
   D/MainActivity: onQueryTextSubmit: SOMETHING ELSE}```
    
   you generate 20 API cals.
   
#### Solution using RxJava
  ## Requirements:
  ```implementation "io.reactivex.rxjava2:rxjava:2.1.14"```
  ## Example 
  ```java
  override fun onCreateOptionsMenu(menu: Menu?): Boolean {
      menuInflater.inflate(R.menu.menu_main, menu)
      val searchView = menu?.findItem(R.id.action_search)?.actionView as SearchView

      // Set up the query listener that executes the search
      Observable.create(ObservableOnSubscribe<String> { subscriber ->
          searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
              override fun onQueryTextChange(newText: String?): Boolean {
                  subscriber.onNext(newText!!)
                  return false
              }

              override fun onQueryTextSubmit(query: String?): Boolean {
                  subscriber.onNext(query!!)
                  return false
              }
          })
      })
      .subscribe { text ->
          Log.d(TAG, "subscriber: $text")
      }

      return super.onCreateOptionsMenu(menu)
  }
  ```
   This code does exactly the same thing as the old code. However, the major difference is that we have a reactive stream to play with. The stream is an ```Observable```. The text handler (or in this case the query handler) submits elements into the stream using ```onNext()```. The observable has subscribers that consume those elements (after whatever pipeline we have deemed appropriate has been cleared).
    We can place a chain of methods in front of the subscribe call to adjust the list of strings that the subscribe method sees. Let’s start by adjusting our stream so that the text that is submitted is always lower-case and it is trimmed of whitespace at the beginning and end:
  ```java
  Observable.create(ObservableOnSubscribe<String> { ... })
  .map { text -> text.toLowerCase().trim() }
  .subscribe { text -> Log.d(TAG, "subscriber: $text" }
  ```
  Next, let’s de-bounce the stream by waiting for more content for up to 250ms:
  ```java
  Observable.create(ObservableOnSubscribe<String> { ... })
  .map { text -> text.toLowerCase().trim() }
  .debounce(250, TimeUnit.MILLISECONDS)
  .subscribe { text -> Log.d(TAG, "subscriber: $text" }
  ```
  And finally, let’s de-duplicate the stream so that only the first unique request gets processed — subsequent identical requests will get ignored and filter out blank requests
  ```java
  Observable.create(ObservableOnSubscribe<String> { ... })
  .map { text -> text.toLowerCase().trim() }
  .debounce(100, TimeUnit.MILLISECONDS)
  .distinct()
  .filter { text -> text.isNotBlank() }
  .subscribe { text -> Log.d(TAG, "subscriber: $text" }
  ```
  The complete code looks like this:
```java
 // Set up the query listener that executes the search
        Observable.create(ObservableOnSubscribe<String> { subscriber ->
            searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
                override fun onQueryTextChange(newText: String?): Boolean {
                    subscriber.onNext(newText!!)
                    return false
                }

                override fun onQueryTextSubmit(query: String?): Boolean {
                    subscriber.onNext(query!!)
                    return false
                }
            })
        })
        .map { text -> text.toLowerCase().trim() }
        .debounce(250, TimeUnit.MILLISECONDS)
        .distinct()
        .filter { text -> text.isNotBlank() }
        .subscribe { text ->
            Log.d(TAG, "subscriber: $text")
        }
```

  With this simple technique of wrapping your text controls in an observable and using RxJava, you can reduce the number of API calls you make for doing backend operations and improve the responsiveness of your app.


 
