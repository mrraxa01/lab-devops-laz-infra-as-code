#ECR Repository
resource "aws_ecr_repository" "ecr_laz_lab2" {
  name                 = "ecr-laz-lab2"
  image_tag_mutability = "MUTABLE"
}