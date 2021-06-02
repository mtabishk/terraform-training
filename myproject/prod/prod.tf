module "myEnv" {
  source         = "../modules/ec2"
  myInstanceType = "t2.large"
}
