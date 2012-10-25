Feature: display list of movies sorted by different criteria
As an avid moviegoer
So that I can quickly browse movies based on my preferences
I want to see movies sorted by title or release date

Background: movies have been added to database
Given the following movies exist:
| title | rating | release_date |
| Aladdin | G | 25-Nov-1992 |
| The Terminator | R | 26-Oct-1984 |
| When Harry Met Sally | R | 21-Jul-1989 |
| The Help | PG-13 | 10-Aug-2011 |
| Chocolat | PG-13 | 5-Jan-2001 |
| Amelie | R | 25-Apr-2001 |
| 2001: A Space Odyssey | G | 6-Apr-1968 |
| The Incredibles | PG | 5-Nov-2004 |
| Raiders of the Lost Ark | PG | 12-Jun-1981 |
| Chicken Run | G | 21-Jun-2000 |

And I am on the RottenPotatoes home page

Scenario: sort movies alphabetically
When I follow the title header
Then I should see the following table rows:
| Movie Title | Rating | Release Date | More Info |
| 2001: A Space Odyssey | G | 1968-04-06 00:00:00 UTC | More about 2001: A Space Odyssey|
| Aladdin | G | 1992-11-25 00:00:00 UTC | More about Aladdin|
| Amelie | R | 2001-04-25 00:00:00 UTC | More about Amelie|
| Chicken Run | G | 2000-06-21 00:00:00 UTC | More about Chicken Run|
| Chocolat | PG-13 | 2001-01-05 00:00:00 UTC | More about Chocolat |
| Raiders of the Lost Ark | PG | 1981-06-12 00:00:00 UTC | More about Raiders of the Lost Ark|
| The Help | PG-13 | 2011-08-10 00:00:00 UTC | More about The Help |
| The Incredibles | PG | 2004-11-05 00:00:00 UTC | More about The Incredibles|
| The Terminator | R | 1984-10-26 00:00:00 UTC | More about The Terminator|
| When Harry Met Sally | R | 1989-07-21 00:00:00 UTC | More about When Harry Met Sally |


Scenario: sort movies in increasing order of release date
When I follow "Release Date"
Then I should see the following table rows:
| Movie Title | Rating | Release Date | More Info |
| 2001: A Space Odyssey | G | 1968-04-06 00:00:00 UTC | More about 2001: A Space Odyssey|
| Raiders of the Lost Ark | PG | 1981-06-12 00:00:00 UTC | More about Raiders of the Lost Ark|
| The Terminator | R | 1984-10-26 00:00:00 UTC | More about The Terminator|
| When Harry Met Sally | R | 1989-07-21 00:00:00 UTC | More about When Harry Met Sally |
| Aladdin | G | 1992-11-25 00:00:00 UTC | More about Aladdin|
| Chicken Run | G | 2000-06-21 00:00:00 UTC | More about Chicken Run|
| Chocolat | PG-13 | 2001-01-05 00:00:00 UTC | More about Chocolat |
| Amelie | R | 2001-04-25 00:00:00 UTC | More about Amelie|
| The Incredibles | PG | 2004-11-05 00:00:00 UTC | More about The Incredibles|
| The Help | PG-13 | 2011-08-10 00:00:00 UTC | More about The Help |


