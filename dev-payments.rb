require 'fifo'
require 'stripe'

pipe = Fifo.new("/dev/payments")

# Take the Stripe API key either from the command line or /etc/dev-payments
key = ARGV[0]
unless key
  begin
    key = IO.read "/etc/dev-payments"
  rescue
    abort "No Stripe API key. Either pass one as an argument or put it in /etc/dev-payments"
  end
end

Stripe.api_key = key

# read commands
while input = pipe.gets.strip
  amount, card, exp, note = input.split(" ", 4)
  exp_month, exp_year = exp.split("/")

  Stripe::Charge.create({
    :amount => amount.to_i,
    :currency => "usd",
    :card => {
      :number =>    card,
      :exp_month => exp_month.to_i,
      :exp_year =>  exp_year.to_i
    },
    :description => note
  })
end