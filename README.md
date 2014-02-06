dev-payments
============

Setup
-----

As root:

    # gem install ruby-fifo stripe
    # echo "my-stripe-api-secret-key" > /etc/dev-payments
    # chmod 700 /etc/dev-payments
    # ruby dev-payments.rb

Use
---

Charge $2.00 to credit card with number 4242424242424242 and expiration date 10/2014, and the note "some payment"

    # echo "200 4242424242424242 10/14 some payment" > /dev/payments

 
