class User < ApplicationRecord
  validates :telegram_id, uniqueness: true, allow_nil: true
  validates :vk_id, uniqueness: true, allow_nil: true
  after_commit :log_transaction

  private

  def log_transaction
    Rails.logger.info "Transaction committed for User ##{id}"
  end
end
