class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(nil)
  end

  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'AC94a6a51de4317e05416b775c5b9af7f4'
    auth_token = 'dd28e8d6abe04fe62728d9594f9860ef'

    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token
    msg = "Hi there, please input the pin to continue login: #{self.pin}"
    client.account.messages.create({
                                       :from => '+13853992354',
                                       :to => '8018563926',
                                       :body => msg,
                                   })
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end