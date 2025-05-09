variable "databases" {
  type = list(object({
    name             = string
    connection_limit = optional(number)
  }))
  default     = []
  description = "The logical database to create and configure"

  validation {
    condition = alltrue([
      for db in var.databases : (
        (db.connection_limit == null ? true : (db.connection_limit == -1 || db.connection_limit >= 1))
      )
    ])
    error_message = "Database connection_limit, if set, must be -1 (for unlimited connections) or an integer greater than or equal to 1."
  }
}

variable "roles" {
  type = list(object({
    role = object({
      # See defaults: https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/postgresql_role
      name                      = string
      superuser                 = optional(bool)
      create_database           = optional(bool)
      create_role               = optional(bool)
      inherit                   = optional(bool)
      login                     = optional(bool)
      replication               = optional(bool)
      bypass_row_level_security = optional(bool)
      connection_limit          = optional(number)
      encrypted_password        = optional(bool)
      password                  = optional(string)
      roles                     = optional(list(string))
      search_path               = optional(list(string))
      valid_until               = optional(string)
      skip_drop_role            = optional(bool)
      skip_reassign_owned       = optional(bool)
      statement_timeout         = optional(number)
      assume_role               = optional(string)
    })
    default_privileges = optional(list(object({
      role        = string
      database    = string
      schema      = string
      owner       = string
      object_type = string
      privileges  = list(string)
    })))
    database_grants = optional(object({
      role        = string
      database    = string
      object_type = string
      privileges  = list(string)
    }))
    schema_grants = optional(object({
      role        = string
      database    = string
      schema      = string
      object_type = string
      privileges  = list(string)
    }))
    sequence_grants = optional(object({
      role        = string
      database    = string
      schema      = string
      object_type = string
      objects     = list(string)
      privileges  = list(string)
    }))
    table_grants = optional(object({
      role        = string
      database    = string
      schema      = string
      object_type = string
      objects     = list(string)
      privileges  = list(string)
    }))
  }))
  default     = []
  description = "List of static postgres roles to create and related permissions. These are for applications that use static credentials and don't use IAM DB Auth. See defaults: https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/postgresql_role"
}
