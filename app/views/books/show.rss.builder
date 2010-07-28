xml.instruct! :xml, :version => "1.0" 
xml.rss( :version=>"2.0", :"xmlns:atom"=>"http://www.w3.org/2005/Atom" ) do
  xml.channel do
    xml.title @book.title
    xml.description @book.reward
    xml.link book_url(@book, :only_path => false, :host => SiteDomain)
    xml.atom( :link, :rel => "self", :type => "application/rss+xml", 
      :href => book_url(@book, :only_path => false, :host => SiteDomain, :format => :rss) 
    )
    
    for chapter in @book.chapters
      xml.item do
        xml.title chapter.title
        xml.description truncate( chapter.content)
        xml.pubDate chapter.created_at.to_s(:rfc822)
        xml.link book_chapter_url(@book.id, chapter.id, :only_path => false, :host => SiteDomain)
        xml.guid book_chapter_url(@book.id, chapter.id, :only_path => false, :host => SiteDomain)
      end
    end
  end
end

