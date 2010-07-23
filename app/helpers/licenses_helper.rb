module LicensesHelper
  def license_button(license, *parts)
    parts = [:img, :text] if parts.empty?
    s = []
    s << link_to(image_tag(license.image_src), license.url) if parts.include?(:img)
    s << link_to(license.name, license.url) if parts.include?(:text)
    s.join(' ')
  end
  
end
