workflow "Build and Deploy" {
  on = "push"
  resolves = ["Verify EKS Deployment"]
}
action "Deploy to EKS" {
  needs = ["Build and Push Containers"]
  uses = "actions/aws/kubectl@master"
  args = ["apply -f config.yml"]
  secrets = ["KUBE_CONFIG_DATA"]
}

action "Verify EKS Deployment" {
  needs = "Deploy to EKS"
  uses = "actions/aws/kubectl@master"
  args = ["rollout status deployment/aws-example-octodex"]
  secrets = ["KUBE_CONFIG_DATA"]
}
