class KeywordExtendWorker
  include Sidekiq::Worker

  def perform(keyword_id, keyword, opt1, opt2)
    puts 'Doing keyword extentions work'
    @agent = Mechanize.new
    get_extension_keywords(keyword_id, keyword, opt1, opt2)    
  end

  def get_extension_keywords(keyword_id, keyword, opt1, opt2)
    puts "extend #{keyword_id}: #{keyword}"
    return if !(opt1.nil? && opt2.nil? || !opt1.nil? && keyword =~ /#{opt1}/im || !opt2.nil? && keyword =~ /#{opt2}/im)

    @agent ||= Mechanize.new
    baidu_url = "http://www.baidu.com/s?wd=#{keyword}"
    page = @agent.get(baidu_url)
    doc = Nokogiri::HTML(page.body)
    doc.search("div#rs a").each do |k|
      k_name = k.text
      next if Market::Keyword.find_by(name: k_name)
      ext_k = Market::Keyword.create!(name: k_name, parent_id: keyword_id)
      ext_k.reload
      unless ext_k.try(:parent).try(:parent).try(:parent)
        get_extension_keywords(ext_k.id, k_name, opt1, opt2)
      end
    end
  end
end

