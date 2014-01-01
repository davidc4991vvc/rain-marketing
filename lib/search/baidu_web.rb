#Usage:
    # $:.unshift(File.dirname(__FILE__))
    # require 'baidu_web'
    # require 'cgi'
    # result = Search::BaiduWeb.search(CGI.escape("游戏"), :per_page => 10, :page_index => 1)

    # result[:record_arr].each do |record|
    #   puts record.title
    #   puts record.url
    #   puts record.summary
    #   puts record.updated_date
    #   puts record.item_index
    #   puts record.cached_url
    # end
    # result[:ext_key_arr].each do |ext_key|
    #  puts ext_key.title
    #  puts ext_key.url
    # end

require 'mechanize'
require 'nokogiri'
#require 'iconv'
require 'open-uri'

module Search
  module BaiduWeb
    class << self
      def search(key_word, options = {})
        result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}

        ic1 = Iconv.new('UTF-8//IGNORE', 'gb2312//IGNORE')
        ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
        key_word = key_word
        return result if key_word.blank?
        key_word = CGI.escape(ic2.iconv(key_word))

        #determine how many records display on one page. (same as www.baidu.com/?<some params>&rn=50)
        per_page = options[:per_page]
        per_page ||= 30

        #get which page of result. (same as www.baidu.com/?<some params>&pn=0)
        page_index = options[:page_index]
        page_index ||= 1

        #get the start item index.
        item_index = (page_index - 1 ) * per_page

        agent = Mechanize.new

        url = "http://www.baidu.com/s?wd=#{key_word}&rn=#{per_page}&pn=#{item_index}"
        #debug: url
        spage = agent.get(url)
        #debug
        #File.open(File.join(File.dirname(__FILE__), 'baidu_result.html'), "w"){|f| f.write(ic1.iconv(spage.body))}

        #doc = Hpricot(@ic.iconv(spage.body))
        doc = Nokogiri::HTML(spage.body)

        return result if doc.nil?
    
        result[:record_arr] = extract_item(doc, item_index)
        #result[:ext_key_arr] = extract_extension_key(doc)
        #debug
        puts result[:record_arr].size
    
        return result
      end
    
      private
      def extract_item(content, item_index)
        record_arr = []
        #remove op recors, e.g. search by 'mysql', see the second record.
        content.search("table[@class='result-op']").remove

        content.search("table[@class='result']").each do |res|
          next if res.at("h3").nil?

          record = Search::Record.new
          
          record.title   = res.at("h3").try(:inner_text)
          record.url     = res.at("h3").at("a").attributes['href'].to_s
          record.summary = res.at("div[@class='c-abstract']").try(:inner_text)
          if res.at("div[@class='f13']").try(:inner_text) =~ /(\d{4}-\d{1,2}-\d{1,2})/
            record.updated_date = begin Date.parse($1) end
          end

          item_index += 1
          record.item_index = item_index
          record_arr << record
        end
        return record_arr
      end

      def extract_extension_key(doc)
        rs = doc.at("//div#rs")
        return [] if rs.nil?
        ext_key_arr = []
        rs.get_elements_by_tag_name("a").each do |link|
           ext_key = ExtensionKey.new
           ext_key.title = link.inner_text
           ext_key.parent_key = @key_word
           ext_key.source = 'web'
           ext_key_arr << ext_key
        end
        ext_key_arr
      end

    end #end class
  end #end module Baidu
end #end module Search