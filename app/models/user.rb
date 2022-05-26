class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :nickname, presence: { message: "must be given please" }, uniqueness: { case_sensitive: false }, length: { maximum: 20, too_long: "%{count} characters is the maximum allowed" }
    # insérer un message pour doublon nickname https://guides.rubyonrails.org/active_record_validations.html#format
    # validates :username,
      # uniqueness: {
          # object = person object being validated
          # data = { model: "Person", attribute: "Username", value: <username> }
        #  message: ->(object, data) do
            #"Hey #{object.name}, #{data[:value]} is already taken."
        #  end
      # }
    #  end
  validates :email, uniqueness: { case_sensitive: false }


  has_many :garages
  has_many :cars, through: :garages, dependent: :destroy
  has_many :invoices, through: :cars, dependent: :destroy
end
