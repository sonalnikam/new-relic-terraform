terraform {
  # Require Terraform version 0.13.x (recommended)
  required_version = "1.1.4"

  # Require the latest 2.x version of the New Relic provider
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "2.21"
    }
  }
}

variable "api_key" {
  type = string
}

provider "newrelic" {
  account_id = 3448380   # Your New Relic account ID
  api_key = "${var.api_key}" # Your New Relic user key
  region = "US"        # US or EU (defaults to US)
}

data "newrelic_account" "acc" {
  account_id  = 3448380
  scope = "global"
}

resource "newrelic_api_access_key" "terraform" {
  account_id  = 3448380
  key_type    = "INGEST"
  ingest_type = "LICENSE"
  name        = "APM Ingest License Key (blue)"
  notes       = "To be used with service X"
}

output "ds" {
  description = "ID of the EC2 instance"
  value       = data.newrelic_account.acc.account_id
}
