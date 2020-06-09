# frozen_string_literal: true

class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  validate :unique_user_subject, :user_is_tutor

  private

  def unique_user_subject
    if UserSubject.all.any? { |us| us.user_id == user_id && us.subject_id == subject_id }
      errors.add(:base, message: 'user subject combination must be unique')
    end
  end

  def user_is_tutor
    tutor = User.all.find(user_id)
    if tutor.role_id != Role.all.find_by_name('tutor').id
      errors.add(:base, message: 'user must be tutor role')
    end
  rescue StandardError => e
  end
end
