{
  "Comment": "VM Approval and Deployment Workflow",
  "StartAt": "LogStart",
  "States": {
    "LogStart": {
      "Type": "Task",
      "Resource": "manageiq://log",
      "Parameters": {
        "level": "info",
        "message": "New VM provisioning request received."
      },
      "Next": "NotifyAdmin1"
    },

    "NotifyAdmin1": {
      "Type": "Task",
      "Resource": "manageiq://email",
      "Parameters": {
        "to": "admin1@example.com",
        "Subject": "VM Approval Required",
        "Body": "A new VM request has been submitted and requires your approval."
      },
      "Next": "NotifyAdmin2"
    },

    "NotifyAdmin2": {
      "Type": "Task",
      "Resource": "manageiq://email",
      "Parameters": {
        "to": "admin2@example.com",
        "Subject": "VM Approval Required",
        "Body": "A new VM request has been submitted and requires your approval."
      },
      "Next": "ApprovalPending"
    },

    "ApprovalPending": {
      "Type": "Pass",
      "Comment": "Approval logic will be implemented in the next phase.",
      "Next": "Finished"
    },

    "Finished": {
      "Type": "Succeed"
    }
  }
}
