# TillyWilly API

"Tilly" indicates it's purpose (cashbox-ish) while "Willy" depicts its silliness and how naive it is

## Architecture

* PostgreSQL 12.3
* Rails 6.0.3
* Ruby 2.7.0
* RSpec 3.9

## Setup

To start the app run following:

```
bundle install
bundle exec rails db:setup
bundle exec rails server
```

## Development

Tests are written using RSpec framework. To run tests execute the following command:

```
bundle exec rspec
```

Code quality is checked using RuboCop:

```
bundle exec rubocop
```

## API

Following endpoints are available

### GET /products

Get a list of available products

#### Examples

```
curl http://localhost:3000/products
```
```json
[
  {
    "code": 1,
    "name": "Lavender heart",
    "price": 9.25,
    "currency": "GBP"
  },
  {
    "code": 2,
    "name": "Personalised cufflinks",
    "price": 45,
    "currency": "GBP"
  },
  {
    "code": 3,
    "name": "Kids T-shirt",
    "price": 19.95,
    "currency": "GBP"
  }
]
```

### POST /checkouts

Creates a new checkout session. Responds with created checkout

#### Examples

```
curl -X POST http://localhost:3000/checkouts
```
```json
{
  "id": "0a9c7717-9b5e-4358-b4d1-fa675f331e09",
  "items": [],
  "discounts": []
}
```

### POST /checkouts/:id/add

Add a specific product to a checkout and recalculate discounts

#### Params

* `id` - checkout UUID
* `product_id` - UUID of a product to add

#### Examples

```
curl -X POST http://localhost:3000/checkouts/0a9c7717-9b5e-4358-b4d1-fa675f331e09/add -d 'product_id=35f359d5-60b3-4913-bb30-3ae4f2f5d2ed'
```
```json
{
  "id": "0a9c7717-9b5e-4358-b4d1-fa675f331e09",
  "items": [
    {
      "id": "335a9050-cd51-4ad9-9900-c55d9058c340",
      "price": 9.25,
      "currency": "GBP",
      "product_id": "35f359d5-60b3-4913-bb30-3ae4f2f5d2ed"
    }
  ],
  "discounts": []
}
```

```
curl -X POST http://localhost:3000/checkouts/0a9c7717-9b5e-4358-b4d1-fa675f331e09/add -d 'product_id=35f359d5-60b3-4913-bb30-3ae4f2f5d2ed'
```
```json
{
  "id": "0a9c7717-9b5e-4358-b4d1-fa675f331e09",
  "items": [
    {
      "id": "335a9050-cd51-4ad9-9900-c55d9058c340",
      "price": 8.5,
      "currency": "GBP",
      "product_id": "35f359d5-60b3-4913-bb30-3ae4f2f5d2ed"
    },
    {
      "id": "486c81d1-1e60-483d-9e77-ca99c7961e0a",
      "price": 8.5,
      "currency": "GBP",
      "product_id": "35f359d5-60b3-4913-bb30-3ae4f2f5d2ed"
    }
  ],
  "discounts": [
    {
      "price": 8.5,
      "currency": "GBP",
      "rules": {
        "product_id": "35f359d5-60b3-4913-bb30-3ae4f2f5d2ed",
        "quantity": 2
      }
    }
  ]
}
```

### DELETE /checkouts/:checkout_id/items/:id

Remove an item from checkout and recalculate discounts

#### Params

`checkout_id` - checkout UUID
`id` - checkout item UUID

#### Examples

```
curl -X DELETE http://localhost:3000/checkouts/0a9c7717-9b5e-4358-b4d1-fa675f331e09/items/335a9050-cd51-4ad9-9900-c55d9058c340
```
```json
{
  "id": "0a9c7717-9b5e-4358-b4d1-fa675f331e09",
  "items": [
    {
      "id": "486c81d1-1e60-483d-9e77-ca99c7961e0a",
      "price": 9.25,
      "currency": "GBP",
      "product_id": "35f359d5-60b3-4913-bb30-3ae4f2f5d2ed"
    }
  ],
  "discounts": []
}
```

### DELETE /checkouts/:id

Resets checkout session

#### Params

* `id` - checkout UUID

#### Examples

```
curl -X DELETE http://localhost:3000/checkouts/0a9c7717-9b5e-4358-b4d1-fa675f331e09
```
```json
{
  "id": "8fabafc9-063b-4ce0-a7d7-8b335e2a1bea",
  "items": [],
  "discounts": []
}
```

### HTTP Status Codes

In different cases API can respond with following HTTP status codes
* `200` - All is good. Well done!
* `404` - A record wasn't found
* `422` - Incoming data is not valid

## Notes

There are two types of discounts:
1. **Total** - Applied on total amount of checkout. Configured by a value of `sum_cents` field
1. **Quantity** - Applied on a specific product quantity. Configured by value of fields `product_id` and `quantity`

Each discount can have two affects:
1. **percentage** - Substracts a specific percentage of product price
1. **price** - Sets item price to a configured value

First we apply all discounts except total discounts which are applied last. So total discounts are using discounted price for calculations. Discounts can be extended using STI and configuration JSONB field

All operations on prices are performed using `ruby-money` gem to ensure consistency and avoid nasty rounding issues
