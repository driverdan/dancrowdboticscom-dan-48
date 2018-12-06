
resource "heroku_app" "staging" {
  name   = "${var.app_name}-staging"
  region = "us"

  buildpacks = [
    "heroku/python"
  ]

  config_vars = {
    DEBUG_COLLECTSTATIC = "1"
  }
}

resource "heroku_addon" "database_staging" {
  app  = "${heroku_app.staging.id}"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "sendgrid_staging" {
  app  = "${heroku_app.staging.id}"
  plan = "sendgrid:starter"
}

resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.pipeline.id}"
  stage    = "staging"
}
