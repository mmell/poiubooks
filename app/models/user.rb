require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::StatefulRoles

  ProfileImages = File.join( "images", "users")   

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of :full_name, :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :full_name, :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  has_many :books, :dependent => :destroy
  has_many :chapters, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :notifications, :dependent => :destroy

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :full_name, :description, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  # Username or email login for restful_authentication in user.rb model from http://gist.github.com/16529
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => ["email = ? OR login = ?",login,login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def self.admins
    User.find(:all, :conditions => "is_admin='1'", :order => 'full_name')
  end
 
  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  # thanks http://www.railsforum.com/viewtopic.php?id=11962
  def create_reset_code
    @reset = true
    make_activation_code
    save(false)
  end 
  
  def delete_reset_code
    make_activation_code
    save(false)
  end
  
  def recently_reset?
    @reset
  end 
     
  def save_image_file(upload)
    name =  "user_#{self.id}" + File.extname(upload.original_filename)
    base = File.join(RAILS_ROOT, "public", "images", "users", image_parent ) 
    FileUtils.mkdir( base ) unless File.exist?( base )
    path = File.join(base, name)
    File.open(path, "wb") { |f| f.write(upload.read) }
    self.image = File.join('users', image_parent, name)
  end
  
  protected
  def image_parent
    "%02d" % id
  end
  
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end


end
