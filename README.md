# Limitations
- DefinitionName and InitiativeName have a maximum length of 64 characters
- AssignmentName has maximum length of 24 characters at Management Group Scope and 64 characters at all other Scopes
- DisplayName has a maximum length of 128 characters and description a maximum length of 512 characters

# Naming convention
- Initiative name: `<default_action>_<generic_services_name>`
- Custom policy definition file name: `<initiative_name>_<definition_name>.json`

Example:
```
# Initiative name
audit_unused_resources

# Custom policy definition file name
- audit_unused_resources_azure_hybrid_benefit
- audit_unused_resources_disks
- audit_unused_resources_public_ip_addresses
- audit_unused_resources_server_farms
```
Benefit: for_each quickly read all file relevent to regarding intiative.