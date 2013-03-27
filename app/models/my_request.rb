require 'rss'
class MyRequest < ActiveRecord::Base
  attr_accessible :url

  has_many :feeds, :dependent => :destroy

  URL = 'http://www.info-construction.ntt-west.co.jp/info-report/ku010/kU010200/' # 故障情報

  def self.latest
    self.all(:order => 'created_at DESC', :limit => 1).first
  end

  def self.get(url)
    feeds = RSS::Parser.parse(url)
    items = feeds.items
    items.inject([]) do |m, item|
      contents = "" # ruby の scopeの話
      open(item.link) {|f| contents = f.read}
      m << [item, contents]
    end
  end

  def self.store!
    m = new(:url => URL)
    get(URL).each do |item, content|
      m.feeds.build(
        title: item.title,
        link: item.link,
        description: item.description,
        pub_date: item.pubDate,
      )
    end
    m.save!
  end

end
