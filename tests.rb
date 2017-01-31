require "test/unit"
require 'watir-webdriver'

#pass either chrome or firefox from the command line ex. dynamic.rb chrome
@client = ARGV[0]

DynamicTest = Struct.new :name

DYNAMIC_TESTS = [
DynamicTest.new("test_b2"),
DynamicTest.new("test_c3"),
DynamicTest.new("test_d4"),
DynamicTest.new("test_e5"),
DynamicTest.new("test_f6"),
DynamicTest.new("test_g7"),
DynamicTest.new("test_h8"),
DynamicTest.new("test_i9"),
DynamicTest.new("test_j10"),
DynamicTest.new("test_k11"),
]

class TC_test < Test::Unit::TestCase
    
    def self.startup()
    if @client == "chrome"
    @@browser = Watir::Browser.new :chrome
    elsif @client == "firefox"
    @@browser = Watir::Browser.new :firefox
    else #if empty or anything but chrome/firefox we default chrome
    @@browser = Watir::Browser.new :chrome
end
@@total_results = 0
end
def test_a1
    @@browser.goto 'bbc.com'
    @@browser.text_field(id: 'orb-search-q').set 'World Market'
    @@browser.text_field(id: 'se-searchbox-input-field').set 'World Market'
    @@browser.button(class: 'se-searchbox__submit').click
    search_results_exist = @@browser.ol(:class => "search-results results").exists?
    if search_results_exist
        @@total_results = @@browser.ol(:class => "search-results results").lis.length
        assert_equal(10, @@total_results, "Expected 10 results, got #{@total_results}.")
        else #if search results exist
        assert_equal(true, search_results_exist, "Failed. No search results to count.")
    end
end

DYNAMIC_TESTS.each do |t|
    define_method t.name do
        
        sleep(3) #wait to check if element is visible
        next_page_exists = @@browser.link(:class => "more").exists?
        if next_page_exists
            next_page_visible = @@browser.link(:class => "more").visible?
            if next_page_visible
                #@@browser.link(:text => "Show more results").click
                @@browser.link(:class =>"more").click #extra lick.. whatever
                sleep(3)
                #now count the total li's in search results results after the click
                @current_results_count=0 #will be compared to expected results to determine +10 results on next page
                @@browser.ols(:class => "search-results results").each do |ol|
                    temp = ol.lis.length
                    @current_results_count = @current_results_count + temp
                    #adds each set of page results togeather starting back on page 1...
                end
                expected_results=@@total_results+10; #will be used to determine pass, previus results page + 10
                @@total_results=@current_results_count
                assert_equal(expected_results, @current_results_count, "Failed. Expected #{expected_results} results, got #{@current_results_count}.")
                else
                assert(false, "Failed. No next page to check number of results of.")
                assert_equal(false, next_page_visible, "Failed. No next page of results to check.")
            end
        end #if exists
        
    end
end

def test_l12
    s=@@browser.html #assign html string
    value = s.scan(/(London market report)/).count #filter searches to exact phrase
    puts "The Search Term of 'World Market' contains #{value} references to articles relating to the 'London market report'." #print value in preffered wording to terminal
    
end

def shutdown
    @@browser.quit #exit browser at very end
end

end
