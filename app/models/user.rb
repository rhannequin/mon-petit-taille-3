# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :lockable
  acts_as_paranoid

  friendly_id :slug_candidates, use: %i[slugged finders]

  validates :name, presence: true, uniqueness: true

  after_update :notify_email_change, if: -> { saved_change_to_email? }

  def slug_candidates
    [:name, %i[name uid]]
  end

  def should_generate_new_friendly_id?
    saved_change_to_name? || super
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid)
      .first_or_create { |u| user_hash(u, auth) }
  end

  def self.user_hash(user, auth)
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user
  end

  private

    def notify_email_change
      UserMailer.email_modified_email(self, email_before_last_save, email_before_last_save).deliver_now
      UserMailer.email_modified_email(self, email_before_last_save, email).deliver_now
    end
end
