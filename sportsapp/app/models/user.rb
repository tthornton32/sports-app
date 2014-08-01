class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  validates :cellphone,
      format: { with: /[\(\)0-9\- \+\.]{10,20} *[extension\.]{0,9} *[0-9]{0,5}/,
      message: "Must be a valid telephone number!" }

  validates_presence_of :cellphone
  validates_uniqueness_of :cellphone

  acts_as_commentable

has_many :comments,    :dependent => :destroy

	attr_accessor :login

  require 'twilio-ruby'

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

    def send_sms(message)
      account_sid = ENV['DTP_TWILIO_SID']
      auth_token = ENV['DTP_TWILIO_TOKEN']
      @client = Twilio::REST::Client.new account_sid, auth_token

      message = @client.account.messages.create({
        :body => message,
        :to => cellphone,
        :from => '+16313362470',}) 
      puts message.to
    end

end
