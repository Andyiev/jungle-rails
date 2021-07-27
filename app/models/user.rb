class User < ActiveRecord::Base
  has_secure_password
  
  #for checking email address regardless of case
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  #for checking password length
  validates :password, length: { minimum: 6 }
  #for checking first and last names presence
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  #add method to check email address regardless of case
  before_save :downcase_email

  # add new authentification (class) method
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.delete(' '))
    @user && @user.authenticate(password) ? @user : nil
  end

  def downcase_email
    self.email.downcase!
  end

end
