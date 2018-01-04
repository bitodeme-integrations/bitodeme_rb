# Bitodeme

Bitödeme official Ruby client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitodeme'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitodeme

Then set environment vars:

```shell
export BITODEME_HOSTNAME=alpha.bitodeme.com; # Bitodeme Domain
export BITODEME_CLIENT_ID=clientidentifier; # API key
export BITODEME_CLIENT_SECRET=clientsecret; # API secret
```

## Usage

### Currency

Fetch all currencies
```ruby
currencies = Bitodeme.currencies
```

Fetch all updated currencies after given time in milli seconds
```ruby
updated_currencies = Bitodeme.currencies(since: 1604131436476)
```

Pagination
```ruby
last_10_currencies = Bitodeme.currencies(page: 1, per_page: 10)
```

### Deposit (Unconfirmed deposits only)

Fetch all unconfirmed deposits

```ruby
deposits = Bitodeme.deposits
```

### Funds

Fetch all funds
```ruby
funds = Bitodeme.funds
```

Fetch all updated funds after given time
```ruby
updated_funds = Bitodeme.funds(since: 1513418293)
```

### FundAddress

Fetch all fund addresses
```ruby
fund_addresses = Bitodeme.fund_addresses
```

Fetch all updated fund_addresses after given time
```ruby
updated_fund_addresses = Bitodeme.fund_addresses(since: 1513418293)
```

### Invoice

Fetch an invoice information
```ruby
invoice = Bitodeme.invoice('id')
```

Build & create an invoice
```ruby
require 'securerandom'
my_unique_order_id = SecureRandom.hex

invoice =
  Bitodeme.build_invoice(
    name:                   'Virtual game gold',
    description:            'Buy a game gold',
    original_amount:        16.7,
    original_currency_code: 'USD',
    external_id:            my_unique_order_id,
    notify_url:             'https://requestb.in/1hfs3rr1',
    return_url:             'https://requestb.in/1hfs3rr1',
    cancel_return_url:      'https://requestb.in/xyz',
    purchasable:            {}
  )

invoice = Bitodeme.create_invoice(invoice)
```

### Transaction Logs

Fetch all transaction logs (deposits, withdrawals and fees)
```ruby
transaction_logs = Bitodeme.transaction_logs
```

Find a transaction_log
```ruby
transaction_log = Bitodeme.transaction_log('id')
```

### Withdrawal (Send money)

Build & create a withdrawal (send money)
```ruby
fund_id    = '12b241a7-941e-43a8-878e-a467809e988e'
withdrawal =
  Bitodeme.build_withdrawal(
    amount:    0.0013,
    address:   'morg4YKzAESEktS7H74dtaavFjuhNUi8zq',
    fund_id:   fund_id,
    otp_value: "123456" # otp value from Google Authenticator
  )

Bitodeme.create_withdrawal(withdrawal)
=> {"status"=>"accepted"}
```

### Notes

- All plural methods support `pagination`(`per_page` and `page`) and `since` query parameters

- Max allowed `per_page` value is 50, if you need more than 50 data, you have to paginate

- The `since` query parameter filters data by `updated_at` attribute

- The `transaction_logs` endpoint also takes `starts_at` and `ends_at` query params which filter content by creation date

### Authentication

Bitodeme endpoint requests automatically authenticated by `bitodeme` library. But in case you need, you can fetch access token by running the command below. The token automatically renews itself, so you don't need to worry about token expiration. Note: Auth class instance is shared across the threads, so everytime you should get the same token until it expires.

```ruby
auth = Bitodeme::Auth.build
auth.token
```

## Standalone Usage

In project root folder:
```shell
# Create an env file
# Edit yout .env file from alpha.bitodeme.com client credentials
cp .env.example .env

# Bundle
bundle

# Run console
bin/console
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bitodeme-integrations/bitodeme_rb.

## References

API Documentation: https://documenter.getpostman.com/view/2573284/bitodeme/7ED9Yvv

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

