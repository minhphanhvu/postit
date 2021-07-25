class User < ApplicationRecord
  include Sluggable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  # Votes
  has_many :votes

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def send_pin_to_twilio
    account_sid = 'AC3a3285a4955239ad68b3b23c73fdcddc'
    auth_token = ENV['TWILIO_KEY']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+18588425236' # Your Twilio number
    to = self.phone # Your mobile phone number

    msg = "Hi, please input the pin to continue login: #{self.pin}"
    client.messages.create(from: from, to: to, body: msg)
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digits
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def admin?
    self.role == 'admin'
  end
end
