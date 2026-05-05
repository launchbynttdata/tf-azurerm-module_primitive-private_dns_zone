// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_private_dns_zone" "private_zone" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [1] : []
    content {
      email        = var.soa_record.email
      expire_time  = lookup(var.soa_record, "expire_time", 2419200)
      minimum_ttl  = lookup(var.soa_record, "minimum_ttl", 10)
      refresh_time = lookup(var.soa_record, "refresh_time", 3600)
      retry_time   = lookup(var.soa_record, "retry_time", 300)
      ttl          = lookup(var.soa_record, "ttl", 3600)
      tags         = local.soa_record_tags
    }
  }

  tags = local.tags

}
