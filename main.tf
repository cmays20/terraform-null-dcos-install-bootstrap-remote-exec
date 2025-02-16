/**
 * DC/OS bootstrap remote exec install
 * ============
 * This module creates the DC/OS installation and configuration on a bootstrap node.
 *
 * EXAMPLE
 * -------
 *
 * ```hcl
 * module "dcos-bootstrap-install" {
 *   source = "dcos-terraform/dcos-install-bootstrap-remote-exec/null"
 *
 *   # version = "~> 0.1.0"
 *
 *   bootstrap_ip         = "${module.dcos-infrastructure.bootstrap.public_ip}"
 *   bootstrap_private_ip = "${module.dcos-infrastructure.bootstrap.private_ip}"
 *   os_user              = "${module.dcos-infrastructure.bootstrap.os_user}"
 *   # Only allow upgrade and install as installation mode
 *   dcos_install_mode   = "install"
 *   dcos_bootstrap_port = "80"
 *   dcos_cluster_name   = "${var.cluster_name}"
 *   dcos_version        = "${var.dcos_version}"
 *   dcos_ip_detect_public_contents = <<EOF
 * #!/bin/sh
 * set -o nounset -o errexit
 *
 * curl -fsSL http://whatismyip.akamai.com/
 * EOF
 *   dcos_ip_detect_contents = <<EOF
 * #!/bin/sh
 * # Example ip-detect script using an external authority
 * # Uses the AWS Metadata Service to get the node's internal
 * # ipv4 address
 * curl -fsSL http://169.254.169.254/latest/meta-data/local-ipv4
 * EOF
 *   dcos_fault_domain_detect_contents = <<EOF
 * #!/bin/sh
 * set -o nounset -o errexit
 *
 * METADATA="$(curl http://169.254.169.254/latest/dynamic/instance-identity/document 2>/dev/null)"
 * REGION=$(echo $METADATA | grep -Po "\"region\"\s+:\s+\"(.*?)\"" | cut -f2 -d:)
 * ZONE=$(echo $METADATA | grep -Po "\"availabilityZone\"\s+:\s+\"(.*?)\"" | cut -f2 -d:)
 *
 * echo "{\"fault_domain\":{\"region\":{\"name\": $REGION},\"zone\":{\"name\": $ZONE}}}"
 * EOF
 *   dcos_variant                      = "ee"
 *    dcos_license_key_contents      = ""
 *   dcos_master_discovery          = "static"
 *   dcos_exhibitor_storage_backend = "static"
 *   master_ips                     = ["${module.dcos-infrastructure.masters.private_ips}"]
 *   dcos_num_masters               = "${length(module.dcos-infrastructure.masters.instances)}"
 * }
 * ```
 */

module "dcos-bootstrap" {
  source  = "dcos-terraform/dcos-core/template"
  version = "~> 0.1.0"

  # Only allow upgrade and install as installation mode
  dcos_install_mode                            = "${var.dcos_install_mode}"
  role                                         = "dcos-bootstrap"
  dcos_master_list                             = "\n - ${join("\n - ", var.master_ips)}"
  bootstrap_private_ip                         = "${var.bootstrap_private_ip}"
  custom_dcos_download_path                    = "${var.custom_dcos_download_path}"
  dcos_adminrouter_tls_1_0_enabled             = "${var.dcos_adminrouter_tls_1_0_enabled}"
  dcos_adminrouter_tls_1_1_enabled             = "${var.dcos_adminrouter_tls_1_1_enabled}"
  dcos_adminrouter_tls_1_2_enabled             = "${var.dcos_adminrouter_tls_1_2_enabled}"
  dcos_adminrouter_tls_cipher_suite            = "${var.dcos_adminrouter_tls_cipher_suite}"
  dcos_agent_list                              = "${var.dcos_agent_list}"
  dcos_audit_logging                           = "${var.dcos_audit_logging}"
  dcos_auth_cookie_secure_flag                 = "${var.dcos_auth_cookie_secure_flag}"
  dcos_aws_access_key_id                       = "${var.dcos_aws_access_key_id}"
  dcos_aws_region                              = "${var.dcos_aws_region}"
  dcos_aws_secret_access_key                   = "${var.dcos_aws_secret_access_key}"
  dcos_aws_template_storage_access_key_id      = "${var.dcos_aws_template_storage_access_key_id}"
  dcos_aws_template_storage_bucket             = "${var.dcos_aws_template_storage_bucket}"
  dcos_aws_template_storage_bucket_path        = "${var.dcos_aws_template_storage_bucket_path}"
  dcos_aws_template_storage_region_name        = "${var.dcos_aws_template_storage_region_name}"
  dcos_aws_template_storage_secret_access_key  = "${var.dcos_aws_template_storage_secret_access_key}"
  dcos_aws_template_upload                     = "${var.dcos_aws_template_upload}"
  dcos_bootstrap_port                          = "${var.dcos_bootstrap_port}"
  dcos_bouncer_expiration_auth_token_days      = "${var.dcos_bouncer_expiration_auth_token_days}"
  dcos_ca_certificate_chain_path               = "${var.dcos_ca_certificate_chain_path}"
  dcos_ca_certificate_key_path                 = "${var.dcos_ca_certificate_key_path}"
  dcos_ca_certificate_path                     = "${var.dcos_ca_certificate_path}"
  dcos_check_time                              = "${var.dcos_check_time}"
  dcos_cluster_docker_credentials              = "${var.dcos_cluster_docker_credentials}"
  dcos_cluster_docker_credentials_dcos_owned   = "${var.dcos_cluster_docker_credentials_dcos_owned}"
  dcos_cluster_docker_credentials_enabled      = "${var.dcos_cluster_docker_credentials_enabled}"
  dcos_cluster_docker_credentials_write_to_etc = "${var.dcos_cluster_docker_credentials_write_to_etc}"
  dcos_cluster_docker_registry_enabled         = "${var.dcos_cluster_docker_registry_enabled}"
  dcos_cluster_docker_registry_url             = "${var.dcos_cluster_docker_registry_url}"
  dcos_cluster_name                            = "${var.dcos_cluster_name}"
  dcos_config                                  = "${var.dcos_config}"
  dcos_custom_checks                           = "${var.dcos_custom_checks}"
  dcos_customer_key                            = "${var.dcos_customer_key}"
  dcos_dns_bind_ip_blacklist                   = "${var.dcos_dns_bind_ip_blacklist}"
  dcos_dns_forward_zones                       = "${var.dcos_dns_forward_zones}"
  dcos_dns_search                              = "${var.dcos_dns_search}"
  dcos_docker_remove_delay                     = "${var.dcos_docker_remove_delay}"
  dcos_enable_docker_gc                        = "${var.dcos_enable_docker_gc}"
  dcos_enable_gpu_isolation                    = "${var.dcos_enable_gpu_isolation}"
  dcos_exhibitor_address                       = "${var.dcos_exhibitor_address}"
  dcos_exhibitor_azure_account_key             = "${var.dcos_exhibitor_azure_account_key}"
  dcos_exhibitor_azure_account_name            = "${var.dcos_exhibitor_azure_account_name}"
  dcos_exhibitor_azure_prefix                  = "${var.dcos_exhibitor_azure_prefix}"
  dcos_exhibitor_explicit_keys                 = "${var.dcos_exhibitor_explicit_keys}"
  dcos_exhibitor_storage_backend               = "${var.dcos_exhibitor_storage_backend}"
  dcos_exhibitor_zk_hosts                      = "${var.dcos_exhibitor_zk_hosts}"
  dcos_exhibitor_zk_path                       = "${var.dcos_exhibitor_zk_path}"
  dcos_fault_domain_enabled                    = "${var.dcos_fault_domain_enabled}"
  dcos_gc_delay                                = "${var.dcos_gc_delay}"
  dcos_gpus_are_scarce                         = "${var.dcos_gpus_are_scarce}"
  dcos_http_proxy                              = "${var.dcos_http_proxy}"
  dcos_https_proxy                             = "${var.dcos_https_proxy}"
  dcos_install_mode                            = "${var.dcos_install_mode}"
  dcos_ip_detect_public_filename               = "${var.dcos_ip_detect_public_filename}"
  dcos_l4lb_enable_ipv6                        = "${var.dcos_l4lb_enable_ipv6}"
  dcos_license_key_contents                    = "${var.dcos_license_key_contents}"
  dcos_log_directory                           = "${var.dcos_log_directory}"
  dcos_master_discovery                        = "${var.dcos_master_discovery}"
  dcos_master_dns_bindall                      = "${var.dcos_master_dns_bindall}"
  dcos_master_external_loadbalancer            = "${var.dcos_master_external_loadbalancer}"
  dcos_mesos_container_log_sink                = "${var.dcos_mesos_container_log_sink}"
  dcos_mesos_dns_set_truncate_bit              = "${var.dcos_mesos_dns_set_truncate_bit}"
  dcos_mesos_max_completed_tasks_per_framework = "${var.dcos_mesos_max_completed_tasks_per_framework}"
  dcos_no_proxy                                = "${var.dcos_no_proxy}"
  dcos_num_masters                             = "${var.dcos_num_masters}"
  dcos_oauth_enabled                           = "${var.dcos_oauth_enabled}"
  dcos_overlay_config_attempts                 = "${var.dcos_overlay_config_attempts}"
  dcos_overlay_enable                          = "${var.dcos_overlay_enable}"
  dcos_overlay_mtu                             = "${var.dcos_overlay_mtu}"
  dcos_overlay_network                         = "${var.dcos_overlay_network}"
  dcos_package_storage_uri                     = "${var.dcos_package_storage_uri}"
  dcos_previous_version                        = "${var.dcos_previous_version}"
  dcos_previous_version_master_index           = "${var.dcos_previous_version_master_index}"
  dcos_process_timeout                         = "${var.dcos_process_timeout}"
  dcos_public_agent_list                       = "${var.dcos_public_agent_list}"
  dcos_resolvers                               = "${var.dcos_resolvers}"
  dcos_rexray_config                           = "${var.dcos_rexray_config}"
  dcos_rexray_config_filename                  = "${var.dcos_rexray_config_filename}"
  dcos_rexray_config_method                    = "${var.dcos_rexray_config_method}"
  dcos_s3_bucket                               = "${var.dcos_s3_bucket}"
  dcos_s3_prefix                               = "${var.dcos_s3_prefix}"
  dcos_security                                = "${var.dcos_security}"
  dcos_skip_checks                             = "${var.dcos_skip_checks}"
  dcos_staged_package_storage_uri              = "${var.dcos_staged_package_storage_uri}"
  dcos_superuser_password_hash                 = "${var.dcos_superuser_password_hash}"
  dcos_superuser_username                      = "${var.dcos_superuser_username}"
  dcos_telemetry_enabled                       = "${var.dcos_telemetry_enabled}"
  dcos_variant                                 = "${var.dcos_variant}"
  dcos_ucr_default_bridge_subnet               = "${var.dcos_ucr_default_bridge_subnet}"
  dcos_use_proxy                               = "${var.dcos_use_proxy}"
  dcos_version                                 = "${var.dcos_version}"
  dcos_zk_agent_credentials                    = "${var.dcos_zk_agent_credentials}"
  dcos_enable_mesos_input_plugin               = "${var.dcos_enable_mesos_input_plugin}"
}

resource "null_resource" "bootstrap" {
  triggers = {
    trigger                                      = "${join(",", var.trigger)}"
    custom_dcos_download_path                    = "${var.custom_dcos_download_path}"
    dcos_adminrouter_tls_1_0_enabled             = "${var.dcos_adminrouter_tls_1_0_enabled}"
    dcos_adminrouter_tls_1_1_enabled             = "${var.dcos_adminrouter_tls_1_1_enabled}"
    dcos_adminrouter_tls_1_2_enabled             = "${var.dcos_adminrouter_tls_1_2_enabled}"
    dcos_adminrouter_tls_cipher_suite            = "${var.dcos_adminrouter_tls_cipher_suite}"
    dcos_agent_list                              = "${var.dcos_agent_list}"
    dcos_audit_logging                           = "${var.dcos_audit_logging}"
    dcos_auth_cookie_secure_flag                 = "${var.dcos_auth_cookie_secure_flag}"
    dcos_aws_access_key_id                       = "${var.dcos_aws_access_key_id}"
    dcos_aws_region                              = "${var.dcos_aws_region}"
    dcos_aws_secret_access_key                   = "${var.dcos_aws_secret_access_key}"
    dcos_aws_template_storage_access_key_id      = "${var.dcos_aws_template_storage_access_key_id}"
    dcos_aws_template_storage_bucket             = "${var.dcos_aws_template_storage_bucket}"
    dcos_aws_template_storage_bucket_path        = "${var.dcos_aws_template_storage_bucket_path}"
    dcos_aws_template_storage_region_name        = "${var.dcos_aws_template_storage_region_name}"
    dcos_aws_template_storage_secret_access_key  = "${var.dcos_aws_template_storage_secret_access_key}"
    dcos_aws_template_upload                     = "${var.dcos_aws_template_upload}"
    dcos_bootstrap_port                          = "${var.dcos_bootstrap_port}"
    dcos_bouncer_expiration_auth_token_days      = "${var.dcos_bouncer_expiration_auth_token_days}"
    dcos_ca_certificate_chain_path               = "${var.dcos_ca_certificate_chain_path}"
    dcos_ca_certificate_key_path                 = "${var.dcos_ca_certificate_key_path}"
    dcos_ca_certificate_path                     = "${var.dcos_ca_certificate_path}"
    dcos_check_time                              = "${var.dcos_check_time}"
    dcos_cluster_docker_credentials              = "${var.dcos_cluster_docker_credentials}"
    dcos_cluster_docker_credentials_dcos_owned   = "${var.dcos_cluster_docker_credentials_dcos_owned}"
    dcos_cluster_docker_credentials_enabled      = "${var.dcos_cluster_docker_credentials_enabled}"
    dcos_cluster_docker_credentials_write_to_etc = "${var.dcos_cluster_docker_credentials_write_to_etc}"
    dcos_cluster_docker_registry_enabled         = "${var.dcos_cluster_docker_registry_enabled}"
    dcos_cluster_docker_registry_url             = "${var.dcos_cluster_docker_registry_url}"
    dcos_cluster_name                            = "${var.dcos_cluster_name}"
    dcos_config                                  = "${var.dcos_config}"
    dcos_custom_checks                           = "${var.dcos_custom_checks}"
    dcos_customer_key                            = "${var.dcos_customer_key}"
    dcos_dns_bind_ip_blacklist                   = "${var.dcos_dns_bind_ip_blacklist}"
    dcos_dns_forward_zones                       = "${var.dcos_dns_forward_zones}"
    dcos_dns_search                              = "${var.dcos_dns_search}"
    dcos_docker_remove_delay                     = "${var.dcos_docker_remove_delay}"
    dcos_enable_docker_gc                        = "${var.dcos_enable_docker_gc}"
    dcos_enable_gpu_isolation                    = "${var.dcos_enable_gpu_isolation}"
    dcos_exhibitor_address                       = "${var.dcos_exhibitor_address}"
    dcos_exhibitor_azure_account_key             = "${var.dcos_exhibitor_azure_account_key}"
    dcos_exhibitor_azure_account_name            = "${var.dcos_exhibitor_azure_account_name}"
    dcos_exhibitor_azure_prefix                  = "${var.dcos_exhibitor_azure_prefix}"
    dcos_exhibitor_explicit_keys                 = "${var.dcos_exhibitor_explicit_keys}"
    dcos_exhibitor_storage_backend               = "${var.dcos_exhibitor_storage_backend}"
    dcos_exhibitor_zk_hosts                      = "${var.dcos_exhibitor_zk_hosts}"
    dcos_exhibitor_zk_path                       = "${var.dcos_exhibitor_zk_path}"
    dcos_fault_domain_enabled                    = "${var.dcos_fault_domain_enabled}"
    dcos_gc_delay                                = "${var.dcos_gc_delay}"
    dcos_gpus_are_scarce                         = "${var.dcos_gpus_are_scarce}"
    dcos_http_proxy                              = "${var.dcos_http_proxy}"
    dcos_https_proxy                             = "${var.dcos_https_proxy}"
    dcos_ip_detect_public_filename               = "${var.dcos_ip_detect_public_filename}"
    dcos_l4lb_enable_ipv6                        = "${var.dcos_l4lb_enable_ipv6}"
    dcos_license_key_contents                    = "${var.dcos_license_key_contents}"
    dcos_log_directory                           = "${var.dcos_log_directory}"
    dcos_master_discovery                        = "${var.dcos_master_discovery}"
    dcos_master_dns_bindall                      = "${var.dcos_master_dns_bindall}"
    dcos_master_external_loadbalancer            = "${var.dcos_master_external_loadbalancer}"
    dcos_mesos_container_log_sink                = "${var.dcos_mesos_container_log_sink}"
    dcos_mesos_dns_set_truncate_bit              = "${var.dcos_mesos_dns_set_truncate_bit}"
    dcos_mesos_max_completed_tasks_per_framework = "${var.dcos_mesos_max_completed_tasks_per_framework}"
    dcos_no_proxy                                = "${var.dcos_no_proxy}"
    dcos_num_masters                             = "${var.dcos_num_masters}"
    dcos_oauth_enabled                           = "${var.dcos_oauth_enabled}"
    dcos_overlay_config_attempts                 = "${var.dcos_overlay_config_attempts}"
    dcos_overlay_enable                          = "${var.dcos_overlay_enable}"
    dcos_overlay_mtu                             = "${var.dcos_overlay_mtu}"
    dcos_overlay_network                         = "${var.dcos_overlay_network}"
    dcos_package_storage_uri                     = "${var.dcos_package_storage_uri}"
    dcos_previous_version                        = "${var.dcos_previous_version}"
    dcos_previous_version_master_index           = "${var.dcos_previous_version_master_index}"
    dcos_process_timeout                         = "${var.dcos_process_timeout}"
    dcos_public_agent_list                       = "${var.dcos_public_agent_list}"
    dcos_resolvers                               = "${var.dcos_resolvers}"
    dcos_rexray_config                           = "${var.dcos_rexray_config}"
    dcos_rexray_config_filename                  = "${var.dcos_rexray_config_filename}"
    dcos_rexray_config_method                    = "${var.dcos_rexray_config_method}"
    dcos_s3_bucket                               = "${var.dcos_s3_bucket}"
    dcos_s3_prefix                               = "${var.dcos_s3_prefix}"
    dcos_security                                = "${var.dcos_security}"
    dcos_skip_checks                             = "${var.dcos_skip_checks}"
    dcos_staged_package_storage_uri              = "${var.dcos_staged_package_storage_uri}"
    dcos_superuser_password_hash                 = "${var.dcos_superuser_password_hash}"
    dcos_superuser_username                      = "${var.dcos_superuser_username}"
    dcos_telemetry_enabled                       = "${var.dcos_telemetry_enabled}"
    dcos_variant                                 = "${var.dcos_variant}"
    dcos_ucr_default_bridge_subnet               = "${var.dcos_ucr_default_bridge_subnet}"
    dcos_use_proxy                               = "${var.dcos_use_proxy}"
    dcos_version                                 = "${var.dcos_version}"
    dcos_zk_agent_credentials                    = "${var.dcos_zk_agent_credentials}"
    dcos_enable_mesos_input_plugin               = "${var.dcos_enable_mesos_input_plugin}"
  }

  connection {
    host = "${var.bootstrap_ip}"
    user = "${var.os_user}"
    agent= true
  }

  provisioner "file" {
    content = "${var.dcos_ip_detect_contents}"

    destination = "/tmp/ip-detect"
  }

  provisioner "file" {
    content = "${var.dcos_ip_detect_public_contents}"

    destination = "/tmp/ip-detect-public"
  }

  provisioner "file" {
    content     = "${var.dcos_fault_domain_detect_contents}"
    destination = "/tmp/fault-domain-detect"
  }

  provisioner "file" {
    content     = "${module.dcos-bootstrap.script}"
    destination = "run.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "# depends ${join(",",var.depends_on)}'",
      "chmod +x run.sh",
      "sudo bash -x ./run.sh",
    ]
  }
}
