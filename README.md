# Joe-T-1-31-17-C-JW
Installation
-	Ensure you have latest Ruby installed - https://www.ruby-lang.org/
-	Ensure you have the Watir Ruby library installed - http://watir.github.io/
-	Download Chrome and Firefox/Gecko WebDriver executables and ensure location of both are accessible by your systems PATH environment variable. (Watir will warn you during execution if they are not found)
https://sites.google.com/a/chromium.org/chromedriver/getting-started 
https://github.com/mozilla/geckodriver/releases

Execution
-	Using your systems terminal window ensure you are in the same directory as the tests.rb file. Then run it. 
  - Terminal: ruby /Users/joe/Desktop/Joe-T-1-31-17-C-JW-master/tests.rb
-	Note: You can choose to run tests in Firefox browser by simply adding the argument at the end like below (chrome is the default if no argument is passed)
  -	Terminal: ruby /Users/joe/Desktop/Joe-T-1-31-17-C-JW-master/tests.rb firefox
Approach
-	My approach uses the Watir framework to automate going to the BBC.com and searching a query and then validating the expected first 10 results on the page by counting each individual `<li>` element nested inside the `<ol>` list of search results (see test_a1 for reference)
-	Using a class variable (@@browser) enabled me to carry on testing further results beyond page 1’s (see test_b2- test_k11). Because the same action and verification occurs on further pages, the tests are dynamic which optimizes code space and allows verification of further result pages beyond to be added with ease. The same verification process that takes place in test_a1 occurs in these tests, they count every individual `<li>` (result) and checks against our expected results (which is 10 additional results (`<li>`) each time next page clicked by a user.
-	The final test (test_l12 )uses the results Watir has collected from the tests previously run to parse for occurrences of a predetermined phrase. It then outputs amount it found into the terminal.

Compromises
-	With the exception of the first test, the other tests are reliant on the previous ones for it to run correctly. This is not ideal as a general rule of good tests is that they should be isolated from each other to ensure accuracy.

Future Enhancements
-	Implementation of independent runnable tests, while this may very well add to total runtime it'd likely offer better accuracy of each case.

Test Cases To Be Implemented
-	The test cases present are just parsing and then counting `<li>` elements on the search page each time a new set of results are loaded. Additional cases in the future should be added to allow for a more accurate verification. Some of these checks could include:
    - Ensure each `<li>` element is actually visible on the users page (elements can be hidden using clever style methods in CSS, current cases don’t look for this trickery)
    - Ensure the amount of `<li>` BBC returned is the same as the number present in BBC’s expected amount to be return (BBC’s HTML markup shows an id with an integer count of how many elements should be present in each page load, current unit tests don’t check against this information)
    - Ensure there are no duplicate article listings in the search results (if this a requirement), after all is a search result really considered a new result if it’s already been listed before?
