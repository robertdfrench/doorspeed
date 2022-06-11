include tools.mk
help: ##: Display this help menu
	@echo "DoorSpeed - An illumos Doors tutorial"
	@echo
	@echo "USAGE:"
	@echo
	@awk -F': ' \
		'/##:/ && !/awk/ { print "\t","make",$$1,"-",$$3 }' \
	       	$(MAKEFILE_LIST)

outputs.tf: $(TERRAFORM) ec2_host.tf
	$(TERRAFORM) apply

init: .terraform/initialized.stamp ##: Initialize Terraform for this directory

.terraform/initialized.stamp: $(TERRAFORM) providers.tf $(wildcard *.lock.hcl)
	$(TERRAFORM) init
	@touch $@
