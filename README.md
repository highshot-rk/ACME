# ACME Widget Co Basket System

## Design Overview

1. **Product**: Represents items in the product catalog with code, name, and price.
2. **DeliveryCalculator**: Calculates delivery charges based on configurable rules.
3. **Offer**: Abstract base class for all offers, with specific implementations.
4. **Basket**: The main class that manages items and calculates totals.

## Running the Code

To run the test scenarios defined in the problem statement:

```bash
ruby acme_basket.rb
```

To run the test suite (requires RSpec):

```bash
rspec spec
```
