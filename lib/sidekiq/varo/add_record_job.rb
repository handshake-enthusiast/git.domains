# frozen_string_literal: true

module Varo
  class AddRecordJob
    include Sidekiq::Job

    def perform(login)
      Varo::AddRecord.new(login:).call
    end
  end
end
