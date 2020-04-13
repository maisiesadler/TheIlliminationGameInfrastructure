resource "aws_iam_role" "api_lambda" {
  name = "api_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "api-lambda"
  }
}

data "aws_iam_policy" "AWSXrayWriteOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "api_lambda_AWSXrayWriteOnlyAccess" {
  role       = "${aws_iam_role.api_lambda.id}"
  policy_arn = "${data.aws_iam_policy.AWSXrayWriteOnlyAccess.arn}"
}

data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "api_lambda_AWSLambdaBasicExecutionRole" {
  role       = "${aws_iam_role.api_lambda.id}"
  policy_arn = "${data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn}"
}

data "aws_iam_policy" "AWSLambdaENIManagementAccess" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
}

resource "aws_iam_role_policy_attachment" "api_lambda_AWSLambdaENIManagementAccess" {
  role       = "${aws_iam_role.api_lambda.id}"
  policy_arn = "${data.aws_iam_policy.AWSLambdaENIManagementAccess.arn}"
}

data "aws_iam_policy" "AmazonSSMFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "api_lambda_AmazonSSMFullAccess" {
  role       = "${aws_iam_role.api_lambda.id}"
  policy_arn = "${data.aws_iam_policy.AmazonSSMFullAccess.arn}"
}
