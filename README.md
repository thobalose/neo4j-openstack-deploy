# Deploying a Neo4j instance on OpenStack using Terraform

This provides a template for deploying a Neo4j instance on OpenStack.

**You will need to modify [`variables.tf`](./variables.tf) defaults or you can input variable values by passing them directly using the `-var` flag.**

## Usage

Download and install [Terraform](https://www.terraform.io/downloads.html):

```sh
$ wget -P /tmp/ https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip
--
$ unzip /tmp/terraform_0.12.13_linux_amd64.zip
$ sudo mv terraform /usr/local/bin/
$ terraform --version
```

Log in to the OpenStack dashboard, choose the project for which you want to download the OpenStack RC file, and run the following commands:

```sh
$ source ~/Downloads/PROJECT-openrc.sh
Please enter your OpenStack Password for project PROJECT as user username:
```

Initialize Terraform:

- Initialize a new or existing Terraform working directory by creating
  initial files, loading any remote state, downloading modules, etc.

```sh
$ terraform init
Initializing...
```

Generate an execution Plan:

- This execution plan can be reviewed prior to running apply to get a sense for what Terraform will do

```sh
$ terraform plan
# or with specific variables
terraform plan -var 'pool=public1' \
                -var 'image=ubuntu-16.04' \
                -var 'flavor=m1.small' \
                -var 'volume_size=3' \
                -var 'ssh_key_file=./id_rsa_os'
```

Install the [OpenStack CLI client](https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html) and run the following:

_To get a list of usable floating IP pools run the command below and take note of the name:_

```sh
$ openstack network list --external
+--------------------------------------+----------+--------------------------------------+
| ID                                   | Name     | Subnets                              |
+--------------------------------------+----------+--------------------------------------+
| 1352e2cb-4bb1-44e8-a3fe-8f08ec73c2d5 | public1  | 165ab7e5-a9e4-414c-8cac-88cc127453f3 |
+--------------------------------------+----------+--------------------------------------+

```

_To get a list of images available for use run and take note of the name:_

```sh
$ openstack image list
```

Afterwards apply changes with:

```sh
$ terraform apply
# or with specific variables
terraform plan -var 'pool=public1' \
                -var 'image=ubuntu-16.04' \
                -var 'flavor=m1.small' \
                -var 'volume_size=3' \
                -var 'ssh_key_file=./id_rsa_os'
...
Outputs:

address = FLOATING-IP
volume_devices = /dev/sdb
```

Upon completion, the above command will output the instances floating IP address.

You will then point your browser to [http://FLOATING-IP:7474](http://FLOATING-IP:7474) to access the Neo4j database web interface!
