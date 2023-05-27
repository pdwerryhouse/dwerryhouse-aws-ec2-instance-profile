#    dwerryhouse-aws-ec2-instance-profile
#    Copyright (C) 2023 Paul Dwerryhouse <paul@dwerryhouse.com.au>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

variable "name" {
  type = string
}

variable "policy_attachments" {
  type = list
  default = []
}

variable "policies" {
  type = list(object({
    actions = list(string)
    resources = list(string)
  }))
}
