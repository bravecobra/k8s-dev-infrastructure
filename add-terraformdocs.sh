#!/bin/bash

terraform-docs markdown table "./src/terraform" --output-file "README.md"
terraform-docs markdown table "./src/clusters/k3d" --output-file "README.md"
terraform-docs markdown table "./src/clusters/kind" --output-file "README.md"