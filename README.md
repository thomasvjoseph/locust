# Locust GitHub Action

This GitHub Action allows you to run Locust performance tests in your CI/CD pipeline. You can easily configure and run load tests on your web application and download the results in HTML format.

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

## Usage

To use the Locust GitHub Action in your workflows, include it in your workflow YAML file:

### Example Workflow

```yaml
name: Load Test

on: [push]

jobs:
  locust-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run Locust Performance Tests
        uses: thomasvjoseph/locust@v1.1.6
        with:
          URL: https://yourwebsite.com   # Replace with your target URL
          LOCUSTFILE: locustfile.py      # Path to your Locustfile
          USERS: 2                       # Number of concurrent users
          RATE: 1                        # Rate of user spawning
          RUNTIME: 10s                   # Duration of the test
          HEADLESS: true                 # Run Locust in headless mode
          LOGLEVEL: DEBUG                # Set logging level
          html_report: 'example.html'    # Name of the HTML report file

      - name: Upload Locust Test Results
        uses: actions/upload-artifact@v4
        with:
          name: locust-report            # Name of the artifact
          path: example.html             # Path to the generated HTML report
          if-no-files-found: warn        # Warn if no files are found
          retention-days: 1              # Retention period for the artifact

```

## Inputs

| Input          | Description                                                                                      | Required | Default        |
|----------------|--------------------------------------------------------------------------------------------------|----------|----------------|
| `LOCUSTFILE`   | The locustfile you want to use to load test. If not provided, a default locustfile will be used. | No       | `locustfile.py`|
| `REQUIREMENTS` | pyproject.toml file you want to use to install 3rd party dependencies.                           | No       | N/A            |
| `URL`          | URL to the site you want to load test.                                                           | Yes      | N/A            |
| `USERS`        | Number of users to spawn.                                                                        | No       | `5`            |
| `RATE`         | Hatch rate (number of users to spawn per second).                                                | No       | `5`            |
| `RUNTIME`      | Run time for the test.                                                                           | No       | `10s`          |
| `HEADLESS`     | Run Locust in headless mode (no web UI).                                                         | No       | `true`         |
| `LOGLEVEL`     | Specify the log level (DEBUG, INFO, WARNING, ERROR, CRITICAL).                                   | No       | `INFO`         |
| `MASTER`       | Run as Locust master in distributed mode.                                                        | No       | `false`        | 
| `WORKERS`      | Number of worker nodes to run in distributed mode (if MASTER is true).                           | No       | `1`            |



## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more details.

## Contributing

Feel free to open an issue or submit a pull request to improve the module.

## Author:  
thomas joseph
- [linkedin](https://www.linkedin.com/in/thomas-joseph-88792b132/)
- [medium](https://medium.com/@thomasvjoseph)
