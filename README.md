# Locust GitHub Action

This GitHub Action allows you to run Locust performance tests in your CI/CD pipeline. You can easily configure it to load test your web applications using various parameters.

## Table of Contents

- [Features](#features)
- [Inputs](#inputs)
- [Usage](#usage)
- [License](#license)

## Features

- Run load tests using a custom Locust file or a default script.
- Install dependencies using Poetry.
- Flexible configuration options for user count, hatch rate, and test duration.
- Supports running Locust in headless mode.

## Inputs

| Input          | Description                                                                                      | Required | Default        |
|----------------|--------------------------------------------------------------------------------------------------|----------|----------------|
| `LOCUSTFILE`   | The locustfile you want to use to load test. If not provided, a default locustfile will be used. | No       | `locustfile.py`|
| `REQUIREMENTS` | (Not used with Poetry) requirements.txt file you want to use to install 3rd party dependencies.  | No       | N/A            |
| `URL`          | URL to the site you want to load test.                                                           | Yes      | N/A            |
| `USERS`        | Number of users to spawn.                                                                        | No       | `5`            |
| `RATE`         | Hatch rate (number of users to spawn per second).                                                | No       | `5`            |
| `RUNTIME`      | Run time for the test.                                                                           | No       | `10s`          |
| `HEADLESS`     | Run Locust in headless mode (no web UI).                                                         | No       | `true`         |
| `LOGLEVEL`     | Specify the log level (DEBUG, INFO, WARNING, ERROR, CRITICAL).                                   | No       | `INFO`         |
| `MASTER`       | Run as Locust master in distributed mode.                                                        | No       | `false`        | 
| `WORKERS`      | Number of worker nodes to run in distributed mode (if MASTER is true).                           | No       | `1`            |

## Usage

To use the Locust GitHub Action in your workflows, include it in your workflow YAML file:

```yaml
name: Run Locust Tests

on: [push]

jobs:
  locust:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run Locust Performance Tests
        uses: thomasvjoseph/locust@v1.0.0
        with:
          URL: https://yourwebsite.com
          LOCUSTFILE: locustfile.py
          USERS: 20
          RATE: 5
          RUNTIME: 1m
          HEADLESS: true
          LOGLEVEL: DEBUG

```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more details.

## Contributing

Feel free to open an issue or submit a pull request to improve the module.

## Author:  
thomas joseph
- [linkedin](https://www.linkedin.com/in/thomas-joseph-88792b132/)
- [medium](https://medium.com/@thomasvjoseph)
