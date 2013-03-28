# -*- coding: utf-8 -*-
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
        pub_date: item.pubDate, # item.date と何が違う?
        content: content,
      )
    end
    m.save!
  end

  def get_rss
    rss = RSS::Maker.make("2.0") do |maker|
      # TODO: 名前とか決めろ
      maker.channel.about = 'hoge-about'
      maker.channel.title = 'hoge-title'
      maker.channel.description = 'hoge-description'
      maker.channel.link = 'hoge-link'

      feeds.each do |feed|
        maker.items.new_item do |item|
          item.link        = feed.link
          item.title       = feed.title
          item.description = feed.description
          item.date        = feed.pub_date.to_s # to_s しないと NameError: undefined method `w3cdtf' for class `ActiveSupport::TimeWithZone'
        end
      end
    end
    rss
  end

end
