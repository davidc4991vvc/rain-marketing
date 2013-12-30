class KeywordExtendWorker
  include Sidekiq::Worker

  def perform(keyword_id, keyword_name)
    puts 'Doing keyword extentions work'
    @agent = Mechanize.new
    get_extension_keywords(keyword_id, keyword)    
  end

  def get_extension_keywords(keyword_id, keyword)
    puts "extend #{keyword}"
    @agent ||= Mechanize.new
    baidu_url = "http://www.baidu.com/s?wd=#{keyword_name}"
    page = @agent.get(baidu_url)
    doc = Nokogiri::HTML(page.body)
    doc.search("div#rs a").each do |k|
      k_name = k.text
      ext_k = Market::Keyword.find_or_initialized_by(name: k_name)
      ext_k.parent_id = keyword_id
      ext_k.save!
      ext_k.reload
      get_extension_keywords(ext_k.id, k_name)
    end
  end
end

