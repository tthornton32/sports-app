class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  validates :cellphone,
      format: { with: /[\(\)0-9\- \+\.]{10,20} *[extension\.]{0,9} *[0-9]{0,5}/,
      message: "Must be a valid telephone number!" }

  acts_as_commentable

has_many :comments,    :dependent => :destroy

	attr_accessor :login

	# validates :username,
 #  :uniqueness => {
 #    :case_sensitive => false
 #  },

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
  end

end
