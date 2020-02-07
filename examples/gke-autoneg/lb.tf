/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 3.1.0"

  project           = var.project
  name              = "gke-http-lb"
  target_tags       = ["gke-gke-cluster-dev"]

  firewall_projects = [var.network_project]
  firewall_networks = [var.network_name]

  backends = {
    default = {
      description                     = "GKE instances"
      protocol                        = "HTTP"
      port                            = 80
      port_name                       = "http"

      timeout_sec                     = 10
      connection_draining_timeout_sec = null
      enable_cdn                      = false

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 80
        host                = null
      }

      groups = [
        # {
        #   # Each node pool instance group should be added to the backend.
        #   group                        = "null"
        #   balancing_mode               = null
        #   capacity_scaler              = null
        #   description                  = null
        #   max_connections              = null
        #   max_connections_per_instance = null
        #   max_connections_per_endpoint = null
        #   max_rate                     = null
        #   max_rate_per_instance        = null
        #   max_rate_per_endpoint        = null
        #   max_utilization              = null
        # },
      ]
    }
  }
}