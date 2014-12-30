# Introduction to Code Smells and Refactoring Techniques

![https://www.flickr.com/photos/mbshane/3165456548/](https://farm4.staticflickr.com/3131/3165456548_70fe4dc501.jpg)

## What is this code smell?


* This exercise focuses on divergent change. Not sure what divergent
  change is? Check it out
[here](http://sourcemaking.com/refactoring/divergent-change)


## Let's get to the code already!
* We have one account class, which correctly handled savings, checking,
  and CD accounts. However, we no want to add money market accounts.
* The tests for money market are written - you just need to write the
  code to make them pass
* A 'shameless green' approach to making these tests pass will make the
  code even uglier - try refactoring the code (and the tests) to make it
more readable and easier to change in the future.

A great resource for learning more about code smells/refactoring:

[http://sourcemaking.com/refactoring](http://sourcemaking.com/refactoring) 
