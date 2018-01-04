require 'json'
require 'faraday'
require 'faraday_middleware'
require_relative 'bitodeme/version'
require_relative 'bitodeme/validation_error'
require_relative 'bitodeme/configuration'
require_relative 'bitodeme/auth'
require_relative 'bitodeme/conn'
require_relative 'bitodeme/resources/base'
require_relative 'bitodeme/resources/currency'
require_relative 'bitodeme/resources/deposit'
require_relative 'bitodeme/resources/fund'
require_relative 'bitodeme/resources/fund_address'
require_relative 'bitodeme/resources/invoice'
require_relative 'bitodeme/resources/transaction_log'
require_relative 'bitodeme/resources/withdrawal'

Currency       = Bitodeme::Resource::Currency
Deposit        = Bitodeme::Resource::Deposit
Fund           = Bitodeme::Resource::Fund
FundAddress    = Bitodeme::Resource::FundAddress
Invoice        = Bitodeme::Resource::Invoice
TransactionLog = Bitodeme::Resource::TransactionLog
Withdrawal     = Bitodeme::Resource::Withdrawal

# Base module for Bitodome client
module Bitodeme
  extend SingleForwardable

  def_delegator :Currency, :all, :currencies
  def_delegator :Deposit, :all, :deposits
  def_delegator :Fund, :find, :fund
  def_delegator :Fund, :all, :funds
  def_delegator :FundAddress, :find, :fund_address
  def_delegator :FundAddress, :all, :fund_addresses
  def_delegator :Invoice, :build, :build_invoice
  def_delegator :Invoice, :create, :create_invoice
  def_delegator :Invoice, :find, :invoice
  def_delegator :TransactionLog, :find, :transaction_log
  def_delegator :TransactionLog, :all, :transaction_logs
  def_delegator :Withdrawal, :build, :build_withdrawal
  def_delegator :Withdrawal, :create, :create_withdrawal

  def config
    Bitodeme::Configuration.build
  end

  module_function :config
end
