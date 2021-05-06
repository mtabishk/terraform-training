variable "x" {
  type    = string
  default = "linux world"
}

output "myvalue" {
  value = "The value of my variable is ${var.x}"
}
