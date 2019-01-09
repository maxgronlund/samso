class ServiceFunctions::PrintedAd < ApplicationRecord
  PENDING = 'pending'
  RECEIVED = 'received'
  REJECTED = 'rejected'
  APPROVED = 'approved'
  PRINTED = 'printed'

  STATES = [
    [PENDING, I18n.t('printed_ad.' + PENDING)],
    [RECEIVED, I18n.t('printed_ad.' + RECEIVED)],
    [APPROVED, I18n.t('printed_ad.' + APPROVED)],
    [REJECTED, I18n.t('printed_ad.' + REJECTED)],
    [PRINTED, I18n.t('printed_ad.' + PRINTED)]
  ].freeze


  COLUMNS
end
