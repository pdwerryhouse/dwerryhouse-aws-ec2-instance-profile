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


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "role" {
  name = "${var.name}-role"
  force_detach_policies = true
  
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "instance-role-attachment" {
   count = length(var.policy_attachments)

   role = aws_iam_role.role.name
   policy_arn = var.policy_attachments[count.index]
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.name}-profile"
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "policy" {

  dynamic "statement" {
    for_each = var.policies

    content {
      actions = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}

resource "aws_iam_role_policy" "policy" {
  name = "${var.name}-policy"
  role = aws_iam_role.role.id

  policy = data.aws_iam_policy_document.policy.json
}
