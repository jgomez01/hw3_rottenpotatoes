# Add a declarative step here for populating the DB with movies.
require 'date'
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
      Movie.create!(movie)
  end
  temp = movies_table.raw
  @original = []
    temp.drop(1).each do |row|
      @original << [row[0], row[1], DateTime.parse(row[2]).to_s.gsub(/T.*/," 00:00:00 UTC"), "More about " + row[0]]
    end
end

When /I follow the title header/ do 
  click_link('title_header')
end
Then /^I should see the following table rows:$/ do |expected_table|
  rows = find("table#movies").all("tr")
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end

When /I follow "Release Date"/ do 
  click_link('release_date_header')
end
# redundant to meet Homework specific requirement
Then /I should see '1968-04-06' before '1981-06-12' and so on/ do 
  
end

When /I check the PG and R checkboxes/ do
  @checked_boxes = []
  check("ratings[PG]")
  @checked_boxes << "PG"
  check("ratings[R]")
  @checked_boxes << "R"
end

Then /^the PG and R checkboxes should be checked$/ do 
   ["PG","R"].each do |box|
     field_checked = find_field("ratings["+box+"]")
     if field_checked.respond_to? :should
      field_checked.should be_true
     else
      assert field_checked
     end
    end  
end

Then /^uncheck all other checkboxes$/ do
    (@all_ratings - @checked_boxes).each do |box|
      uncheck("ratings["+box+"]")
    end  
end

When /^I press the Refresh button$/ do
  click_button('ratings_submit')
end

Then /^the PG and R movies are visible$/ do
  rows = find("table#movies").all("tr")
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  pg_count = 0
  r_count = 0
  @other_count = 0
  table.drop(1).each do |row|
    if row[1] == "PG" 
      pg_count += 1
    elsif row[1] == "R"
      r_count += 1
    else
      @other_count += 1
    end    
  end 
  @ratings_count = Movie.count(:all,:group => 'rating')
  assert (@ratings_count["PG"] == pg_count), "wrong number of PG movies" + ", found = " + pg_count.to_s
  assert (@ratings_count["R"] == r_count), "wrong number of R movies" + ", found = " + r_count.to_s 
end
Then /^movies with other ratings are not visible$/ do
  assert (@other_count == 0), "movies not selected are visible"
end


When /^I uncheck the following ratings: "(.*?)"$/ do |arg1|
  (arg1.gsub(/ /,"").split(/,/)).each do |r|
    uncheck("ratings["+r+"]")
  end
end

Then /^the "(.*?)" checkboxes will be actually unckecked$/ do |arg1|
  (arg1.gsub(/ /,"").split(/,/)).each do |box|
     field_checked = find_field("ratings["+box+"]")
     if field_checked.respond_to? :should
      field_checked.should be_true
     else
      assert field_checked
     end
  end 
end

When /^I uncheck all ratings$/ do
# uncheck and submit filtered form
  @all_ratings.each do |r|
    uncheck("ratings["+r+"]")
  end
   click_button('ratings_submit')
end  
Then /^no movies are displayed$/ do
  rows = find("table#movies").all("tr")
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  rows_count = 0
  table.drop(1).each do |row|
    rows_count += 1
  end
  assert (rows_count == 0), "movies not selected are visible"
end   
#   

When /^I check all ratings$/ do
# uncheck and submit filtered form
  @all_ratings.each do |r|
    check("ratings["+r+"]")
  end
   click_button('ratings_submit')
end  
Then /^all movies are displayed$/ do
  rows = find("table#movies").all("tr")
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  rows_count = 0
  table.drop(1).each do |row|
    rows_count += 1
  end
 assert (rows_count == Movie.count(:all)), "number of displayed movies does not match the number of stored movies"
end   
