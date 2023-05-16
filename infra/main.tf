terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "~> 3.0.1"
        }
    }
    backend "s3" {
      bucket                      = "tfstate"
      region                      = "main"
      key                         = "terraform-infra-tfstate"
      skip_credentials_validation = true
      skip_metadata_api_check     = true
      skip_region_validation      = true
      force_path_style            = true
  }
}
provider "docker" {
  host = "tcp://10.5.1.169:2377"
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 80
    external = 8000
  }
}

