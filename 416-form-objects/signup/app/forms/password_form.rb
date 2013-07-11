class PasswordForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_accessor :changing_password, :original_password, :new_password
  validate :verify_original_password, if: :changing_password
  validates_presence_of :original_password, :new_password, if: :changing_password
  validates_confirmation_of :new_password, if: :changing_password
  validates_length_of :new_password, minimum: 6, if: :changing_password

  def initialize(user)
    @user = user
  end

  def verify_original_password
    unless @user.authenticate(original_password)
      errors.add :original_password, "is not correct"
    end
  end

  def change_password
    @user.password = new_password
  end
end