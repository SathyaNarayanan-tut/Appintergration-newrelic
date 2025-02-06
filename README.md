# App Integration with New Relic

This project automates the integration of an application with New Relic for monitoring and observability. It installs and configures the New Relic agent to collect performance metrics, logs, and system insights, helping to monitor the application's health and optimize its performance.

## How It Works
1. The setup script installs the necessary dependencies and the New Relic agent on an AWS EC2 instance.
2. The New Relic agent collects real-time application performance data, including CPU usage, memory consumption, and request response times.
3. This data is then sent to the New Relic dashboard, where users can visualize, analyze, and set alerts for performance anomalies.
4. The configuration file allows customization of monitoring settings to tailor the observability experience to specific needs.

## Features
- Automates the installation and configuration of New Relic agent.
- Supports monitoring of application performance.
- Provides logging and metrics collection.
- Deployable on AWS EC2 instances.

## Prerequisites
Before you begin, ensure you have the following:
- An AWS EC2 instance (Ubuntu 22.04 or later recommended).
- New Relic account with an active license key.
- Terraform and Ansible installed (if using for automation).

## Installation
### 1. Clone the Repository
```bash
git clone https://github.com/SathyaNarayanan-tut/Appintergration-newrelic.git
cd Appintergration-newrelic
```

### 2. Set Up Environment Variables
Create a `.env` file and add your New Relic license key:
```bash
export NEW_RELIC_LICENSE_KEY="your_license_key"
export APP_NAME="your_app_name"
```

### 3. Install Dependencies
Ensure all required dependencies are installed:
```bash
sudo apt update && sudo apt install -y curl jq
```

### 4. Run the Setup Script
Execute the installation script to install and configure New Relic:
```bash
bash install_newrelic.sh
```

## Configuration
Modify the `newrelic-config.yml` file to customize monitoring settings.

## Usage
- After installation, verify the agent is running:
```bash
systemctl status newrelic-infra
```
- Check logs for debugging:
```bash
journalctl -u newrelic-infra --no-pager -n 50
```
- View metrics on the New Relic dashboard.

## Troubleshooting
- Ensure the correct license key is set.
- Check logs for errors.
- Restart the New Relic service if necessary:
```bash
sudo systemctl restart newrelic-infra
```

## Contributing
Feel free to open issues or submit pull requests.

## License
This project is licensed under the MIT License. See `LICENSE` for details.

