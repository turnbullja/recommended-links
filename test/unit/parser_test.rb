require_relative "../test_helper"
require_relative "../../lib/recommended_links/parser"

module RecommendedLinks
  class ParserTest < Test::Unit::TestCase
    def csv_fixture_file
      File.expand_path("../fixtures/sample.csv", File.dirname(__FILE__))
    end
    
    def deleted_links_fixture_file
      File.expand_path("../fixtures/deleted.txt", File.dirname(__FILE__))
    end
    
    test "Can parse a CSV file" do
      recommended_links = Parser.new(csv_fixture_file).recommended_links
      
      assert_equal 1, recommended_links.size
      assert_equal "Care homes", recommended_links.first.title
      assert_equal "Find a care home and other residential housing on the NHS Choices website", recommended_links.first.description
      assert_equal "http://www.nhs.uk/CarersDirect/guide/practicalsupport/Pages/Carehomes.aspx", recommended_links.first.url
      assert_equal ["care homes", "old people's homes", "nursing homes", "sheltered housing"], recommended_links.first.match_phrases
    end
    
    test "Can parse a deleted links file" do
      deleted_links = DeletedLinksParser.new(deleted_links_fixture_file).deleted_links
      
      assert_equal ['http://delete.me/some/page.html'], deleted_links
    end
    
  end
end