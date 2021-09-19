# Network Design

- VPC
  - Network CIDR: `10.10.0.0/16`
  - Subnets:
    - Instance Subnets: `10.10.1.0/24`
    - GKE Subnet:
      - Network CIDR (work node cidr): `10.20.90.0/24`
        - Master Subnets: `10.20.100.0/24`
        - Service Subnets: `10.20.110.0/24`
        - Pod Subnets: `10.20.120.0/22`
