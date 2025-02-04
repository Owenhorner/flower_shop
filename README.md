# Roda App

This is a Roda-based web application for processing flower-shop orders.

## Installation

1. Install the dependencies:
```sh
bundle install
```

> **Note:** Devcontainer users can simply open the project in a devcontainer, which will automatically run `bundle install` and `rspec`.

## Usage

1. Start the application:
```sh
rackup
```

2. Open your web browser and navigate to:
```
http://localhost:9292
```

3. Use the order form to submit your orders. The form accepts order lines in the format:
```
<quantity> <product_code>
```
eg: 
```
10 R12
15 L09
13 T58
```

## Running Tests

To run the tests, use the following command:
```sh
rspec
```

## Additional Documentation

For more detailed documentation, refer to the [Flower Shop PDF](docs/flower-shop.pdf).