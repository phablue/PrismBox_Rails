class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :department, presence: true
  validates :email, uniqueness: true
  has_secure_password
  before_destroy :ensure_an_admin_remains

  def admin
    self.email == admin_email
  end

  private

  def ensure_an_admin_remains
    raise "Can’t delete admin" if admin
  end

  protected

  def admin_email
    "testadmin@example.com"
  end
end
