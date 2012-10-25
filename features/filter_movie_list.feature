Feature: display list of movies filtered by MPAA rating
 
  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page
  
Scenario: restrict to movies with 'PG' or 'R' ratings
  Given I am on the RottenPotatoes home page
  # enter step(s) to check the 'PG' and 'R' checkboxes
  When I check the PG and R checkboxes
  Then the PG and R checkboxes should be checked

  # enter step(s) to uncheck all other checkboxes
  Then uncheck all other checkboxes

  # enter step to "submit" the search form on the homepage
  When I press the Refresh button

  # enter step(s) to ensure that PG and R movies are visible
  Then the PG and R movies are visible

  # enter step(s) to ensure that other movies are not visible
  And movies with other ratings are not visible

  # step to uncheck some checkboxes
  When I uncheck the following ratings: "G, PG-13"
  Then the "G, PG-13" checkboxes will be actually unckecked

Scenario: no ratings selected
  Given I am on the RottenPotatoes home page
  When I uncheck all ratings
  Then no movies are displayed

Scenario: all ratings selected
Given I am on the RottenPotatoes home page
  When I check all ratings
  Then all movies are displayed
