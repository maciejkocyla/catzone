class Cat < ActiveRecord::Base
  
  require 'flickraw'
  
  has_many :sweetness
  
  FlickRaw.api_key="24136702cabc673f44ff21d2cbc5b84d"
  FlickRaw.shared_secret="95fc072301938e0c"
  
  mount_uploader :picture, CatUploader
  
  paginates_per 20
  
  class << self
  
    def find_new_cat
      source = flickr.photos.search(:text => 'cat', :page => 1, :per_page => 100)
      cursor = 1
      picture_number = 0
    
      cat = nil
    
      while cat.nil? do
      
        if cursor % 100 == 0
          source = flickr.photos.search(:text => 'cat', :page => cursor % 100, :per_page => 100)
          picture_number = 0
        end
      
        if Cat.find_by_flickr_id(source[picture_number].id).nil?
          cat = source[picture_number]
        end
      
        picture_number += 1
        cursor += 1
      end
      cat
    end
  
    def save_new
      new_cat = self.find_new_cat
      if new_cat
        begin
          info = flickr.photos.getInfo(:photo_id => new_cat.id)
          source = FlickRaw.url_q(info)
          c = Cat.create!(name: new_cat.title, flickr_id: new_cat.id)
          c.remote_picture_url = source
          c.save!
        rescue => error
          puts error
        end
      end
    end
    
    def save_new_100
      100.times do
        save_new
      end
    end
  
    def random n
      if count > n
        ids = Cat.all.map( &:id )
        arr = Cat.find( (1..n).map { ids.delete_at( ids.size * rand ) } )
        if arr.count == 1
          arr.first
        else
          arr
        end
      else
        nil
      end
    end
    
    def top_ten
      all_ordered.first(10)
    end
    
    def top_ten_in n
      all.sort_by {|cat| cat.sweets_in n}.reverse.first(10)
    end
  
    def top n
      all.sort_by(&:sweets).reverse.limit(n)
    end
    
    def all_ordered
      all.sort_by(&:sweets).reverse
    end
    
  end # end of self
  
  def sweets
    sweetness.count
  end
  
  def sweets_in n
    sweetness.where("created_at > ?", Date.today - n.days).count
  end
  
end