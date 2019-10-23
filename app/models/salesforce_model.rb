# frozen_string_literal: true

class SalesforceModel < ApplicationRecord
  self.abstract_class = true
  self.inheritance_column = :_type_disabled

  alias_attribute :hc_error, :_hc_err
  alias_attribute :hc_status, :_hc_lastop
  alias_attribute :is_deleted, :isdeleted
  alias_attribute :created_at, :createddate

  after_commit :confirm_sync, unless: :ignore_confirm_sync?, on: [:create]

  def ignore_confirm_sync?
    @ignore_confirm_sync
  end

  private
    def confirm_sync
      begin
        recursive_confirm_sync
      rescue Exceptions::HCError => e
        @ignore_confirm_sync = true
        destroy if sfid_changed? # only destroy if hc error on create
        raise e
      end
    end

    def recursive_confirm_sync(current_attempt = 0)
      raise "Confirm Sync Timeout" if current_attempt > 24
      sleep 0.4
      reload
      return if %w(SYNCED INSERTED UPDATED).include?(hc_status)
      raise Exceptions::HCError.new(error_message) if hc_status == "FAILED"
      recursive_confirm_sync(current_attempt + 1)
    end

    def error_message
      JSON.parse(hc_error)["msg"]
    end

    def self.default_scope
      filters = {}
      # filters = { hc_status: [nil, 'SYNCED', 'INSERTED', 'UPDATED'] }
      filters.merge!(isdeleted: [nil, false]) if column_names.include?("isdeleted")
      where(filters)
    end
end