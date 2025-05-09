# Test cases for 'databases' variable connection_limit validation

variables {
  #roles are not relevant for this test but are required by the module
  roles = []
}

# Valid case: connection_limit = -1
run "valid_connection_limit_negative_one" {
  command = plan

  variables {
    databases = [{
      name             = "db_neg_one"
      connection_limit = -1
    }]
  }
}

# Valid case: connection_limit = 1
run "valid_connection_limit_one" {
  command = plan

  variables {
    databases = [{
      name             = "db_one"
      connection_limit = 1
    }]
  }
}

# Valid case: connection_limit = 10
run "valid_connection_limit_ten" {
  command = plan

  variables {
    databases = [{
      name             = "db_ten"
      connection_limit = 10
    }]
  }
}

# Valid case: connection_limit is not provided (optional)
run "valid_connection_limit_not_provided" {
  command = plan

  variables {
    databases = [{
      name = "db_no_limit"
      # connection_limit is omitted
    }]
  }
}

# Invalid case: connection_limit = 0
run "invalid_connection_limit_zero" {
  command = plan

  variables {
    databases = [{
      name             = "db_zero"
      connection_limit = 0
    }]
  }

  expect_failures = [
    var.databases
  ]
}

# Invalid case: connection_limit = -2
run "invalid_connection_limit_negative_two" {
  command = plan

  variables {
    databases = [{
      name             = "db_neg_two"
      connection_limit = -2
    }]
  }

  expect_failures = [
    var.databases
  ]
}

