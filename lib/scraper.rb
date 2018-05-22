require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   learn_ver = Nokogiri::HTML(open(index_url)) 
   
   students = []
   
     learn_ver.css("div.student-card").each do |student|
       student_hash = {}
       student_hash = {
        :name => student.css("div.card-text-container h4").text,
        :location =>student.css("div.card-text-container p").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << student_hash
    end
   students
  end

  def self.scrape_profile_page(profile_url)
    student_prof = Nokogiri::HTML(open(profile_url))
    
    student_hash = {}
  
    
    student_hash = {
    
    student_prof.css("div.social-icon-container").css("a").each do |s_icon|
      
    
      
      if s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"") == "twitter"
      :twitter => s_icon.attribute("href").value,
       else 
      :twitter => "",
      end
      
      if s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"") == "linkedin"
      :linkedin => s_icon.attribute("href").value,
       else 
      :linkedin => "",
      end
      
      if s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"") == "github"
      :github => s_icon.attribute("href").value,
       else 
      :github => "",
      end
      
      #if s_icon.attribute("href").value.gsub(/http(s)?:\/\/(www.)?|.(com|net|co.uk|us)+.*/,"") == "blog"
      #:github => s_icon.attribute("href").value
      # else 
      #:github => ""
      
      end
    
     :profile_quote => student_prof.css("div.profile-quote").text,
     :bio => student_prof.css("div.bio-content p").text
    }
    
    #binding.pry
  end

end

